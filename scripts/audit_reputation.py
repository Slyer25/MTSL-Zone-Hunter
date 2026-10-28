#!/usr/bin/env python3
"""Audit researched reputation-vendor entries against independent Classic lists.

This is a static database check, not a guarantee the NPC exists on every 1.12 realm.
Sources:
https://www.wow-professions.com/classic/npc/meilosh
https://www.wow-professions.com/classic/npc/rinwosho-the-trader
Cenarion Circle vendor tooltips manually verified in game, 2026-10-28.
"""
from pathlib import Path
import re
import sys

data = (Path(__file__).resolve().parents[1] / "MissingTradeSkillsList/logic/zone_workflows.lua").read_text()
section_match = re.search(r"additional_reputation_vendors\s*=\s*\{(.*?)\n    \},", data, re.S)
if not section_match:
    sys.exit("FAIL: additional_reputation_vendors table missing")
entries = re.findall(r'\["([^"]+)"\]\s*=\s*\{vendor = "([^"]+)", faction = "([^"]+)", rank = "([^"]+)"', section_match.group(1))
actual = {}
errors = []
for item, vendor, faction, rank in entries:
    key = (vendor, item)
    if key in actual:
        errors.append("duplicate: " + vendor + " / " + item)
    actual[key] = (faction, rank)

expected = {
    "Meilosh": {
        "Friendly": ["Recipe: Transmute Earth to Water", "Formula: Enchant 2H Weapon - Agility", "Pattern: Warbear Harness", "Pattern: Warbear Woolies"],
        "Honored": ["Plans: Heavy Timbermaw Belt", "Formula: Enchant Weapon - Agility", "Pattern: Might of the Timbermaw", "Pattern: Wisdom of the Timbermaw"],
        "Revered": ["Plans: Heavy Timbermaw Boots", "Pattern: Timbermaw Brawlers", "Pattern: Mantle of the Timbermaw"],
    },
    "Rin'wosho the Trader": {
        "Friendly": ["Recipe: Greater Dreamless Sleep", "Schematic: Bloodvine Lens", "Pattern: Bloodvine Boots", "Pattern: Primal Batskin Bracers", "Plans: Bloodsoul Gauntlets", "Plans: Darksoul Shoulders", "Formula: Brilliant Mana Oil"],
        "Honored": ["Pattern: Blood Tiger Shoulders", "Pattern: Bloodvine Leggings", "Pattern: Primal Batskin Gloves", "Plans: Bloodsoul Shoulders", "Plans: Darksoul Leggings", "Schematic: Bloodvine Goggles", "Recipe: Major Troll's Blood Potion", "Formula: Brilliant Wizard Oil"],
        "Revered": ["Pattern: Blood Tiger Breastplate", "Plans: Darksoul Breastplate", "Recipe: Mageblood Potion", "Pattern: Bloodvine Vest", "Pattern: Primal Batskin Jerkin", "Plans: Bloodsoul Breastplate"],
        "Exalted": ["Recipe: Living Action Potion"],
    },
}
factions = {"Meilosh": "Timbermaw Hold", "Rin'wosho the Trader": "Zandalar Tribe"}
for vendor, ranks in expected.items():
    required = {item: rank for rank, items in ranks.items() for item in items}
    for item, rank in required.items():
        got = actual.get((vendor, item))
        if got != (factions[vendor], rank):
            errors.append(f"{vendor}: {item}: expected {factions[vendor]} {rank}, got {got}")
    for (v, item), (_, rank) in actual.items():
        if v == vendor and item not in required:
            errors.append(f"unreviewed entry: {vendor}: {item} ({rank})")
# Cenarion Circle expectations were checked against in-game vendor tooltips
# supplied for Vargus, Kania, Aendel Windspear and Mishta (2026-10-28).
cenarion_expected = {
    "Vargus": {
        "Friendly": ["Plans: Heavy Obsidian Belt", "Plans: Ironvine Belt"],
        "Honored": ["Plans: Light Obsidian Belt", "Plans: Ironvine Gloves"],
        "Revered": ["Plans: Ironvine Breastplate"],
    },
    "Kania": {
        "Friendly": ["Formula: Enchant Cloak - Greater Fire Resistance"],
        "Honored": ["Formula: Enchant Cloak - Greater Nature Resistance"],
    },
    "Aendel Windspear": {
        "Friendly": ["Pattern: Sandstalker Bracers", "Pattern: Spitfire Bracers", "Pattern: Bramblewood Belt"],
        "Honored": ["Pattern: Sandstalker Gauntlets", "Pattern: Spitfire Gauntlets", "Pattern: Bramblewood Boots"],
        "Revered": ["Pattern: Sandstalker Breastplate", "Pattern: Spitfire Breastplate", "Pattern: Bramblewood Helm"],
        "Exalted": ["Pattern: Dreamscale Breastplate"],
    },
    "Mishta": {
        "Friendly": ["Pattern: Cenarion Herb Bag", "Pattern: Sylvan Shoulders"],
        "Honored": ["Pattern: Sylvan Crown"],
        "Revered": ["Pattern: Satchel of Cenarius", "Pattern: Sylvan Vest", "Pattern: Gaea's Embrace"],
    },
}
cenarion_match = re.search(r"(?<!additional_)reputation_vendor_conditions\s*=\s*\{(.*?)\n    \},", data, re.S)
if not cenarion_match:
    errors.append("Cenarion Circle reputation_vendor_conditions table missing")
else:
    cenarion_rows = re.findall(
        r'\["([^"]+)"\]\s*=\s*\{vendor = "([^"]+)", faction = "([^"]+)", rank = "([^"]+)"',
        cenarion_match.group(1),
    )
    cenarion_actual = {}
    for item, vendor, faction, rank in cenarion_rows:
        key = (vendor, item)
        if key in cenarion_actual:
            errors.append("duplicate Cenarion Circle recipe: " + vendor + " / " + item)
        cenarion_actual[key] = (faction, rank)
    cenarion_required = {
        (vendor, item): ("Cenarion Circle", rank)
        for vendor, ranks in cenarion_expected.items()
        for rank, items in ranks.items()
        for item in items
    }
    for key, expected_value in cenarion_required.items():
        if cenarion_actual.get(key) != expected_value:
            errors.append(f"Cenarion mismatch {key}: expected {expected_value}, got {cenarion_actual.get(key)}")
    for key in cenarion_actual:
        if key not in cenarion_required:
            errors.append(f"unreviewed Cenarion Circle entry: {key}")

# Lokhtos inventory visibility verified in-game on 2026-10-28.
thorium_expected = {
    "Friendly": [
        "Plans: Dark Iron Bracers",
        "Pattern: Corehound Boots",
        "Pattern: Flarecore Gloves",
        "Pattern: Molten Helm"
    ],
    "Honored": [
        "Plans: Fiery Chain Girdle",
        "Plans: Dark Iron Helm",
        "Plans: Dark Iron Reaver",
        "Plans: Dark Iron Destroyer",
        "Pattern: Flarecore Mantle",
        "Pattern: Flarecore Robe",
        "Pattern: Black Dragonscale Boots",
        "Pattern: Lava Belt",
        "Formula: Enchant Weapon - Mighty Spirit",
        "Formula: Enchant Weapon - Strength"
    ],
    "Revered": [
        "Plans: Fiery Chain Shoulders",
        "Plans: Dark Iron Gauntlets",
        "Plans: Dark Iron Leggings",
        "Plans: Blackfury",
        "Plans: Black Amnesty",
        "Pattern: Chromatic Gauntlets",
        "Pattern: Corehound Belt",
        "Pattern: Molten Belt",
        "Pattern: Flarecore Leggings",
        "Formula: Enchant Weapon - Mighty Intellect"
    ],
    "Exalted": [
        "Plans: Ebon Hand",
        "Plans: Blackguard",
        "Plans: Nightfall",
        "Plans: Dark Iron Boots"
    ]
}
thorium_section = re.search(r"thorium_brotherhood_reputation\s*=\s*\{(.*?)\n    \},", data, re.S)
if not thorium_section:
    errors.append("Thorium Brotherhood reputation table missing")
else:
    thorium_pairs = re.findall(r'\["([^"]+)"\]\s*=\s*"([^"]+)"', thorium_section.group(1))
    thorium_actual = {}
    for item, rank in thorium_pairs:
        if item in thorium_actual:
            errors.append("duplicate Thorium Brotherhood recipe: " + item)
        thorium_actual[item] = rank
    thorium_required = {item: rank for rank, items in thorium_expected.items() for item in items}
    for item, rank in thorium_required.items():
        if thorium_actual.get(item) != rank:
            errors.append(f"Thorium mismatch: {item}: expected {rank}, got {thorium_actual.get(item)}")
    for item in thorium_actual:
        if item not in thorium_required:
            errors.append(f"unreviewed Thorium Brotherhood entry: {item}")

if errors:
    for error in errors:
        print("FAIL:", error)
    sys.exit(1)
print("PASS: 84 vendor recipes audited (11 Timbermaw, 22 Zandalar, 23 Cenarion Circle, 28 Thorium Brotherhood); no missing keys, mismatches or duplicates")
