#!/usr/bin/env python3
"""Audit researched reputation-vendor entries against independent Classic lists.

This is a static database check, not a guarantee the NPC exists on every 1.12 realm.
Sources:
https://www.wow-professions.com/classic/npc/meilosh
https://www.wow-professions.com/classic/npc/rinwosho-the-trader
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
if errors:
    for error in errors:
        print("FAIL:", error)
    sys.exit(1)
print("PASS: 33 vendor recipes audited (11 Timbermaw, 22 Zandalar), no missing keys, mismatches or duplicates")
