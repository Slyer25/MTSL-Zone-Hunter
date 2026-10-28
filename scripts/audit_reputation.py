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

# Transmute Elemental Fire has a requirement on the recipe item, not merely
# a conditional vendor stock entry. Confirmed by Classic item records.
item_rep_match = re.search(r"thorium_item_reputation\s*=\s*\{(.*?)\}", data, re.S)
if not item_rep_match or not re.search(
    r'\["Recipe: Transmute Elemental Fire"\]\s*=\s*"Friendly"',
    item_rep_match.group(1),
):
    errors.append("Transmute Elemental Fire must retain its item-level Friendly requirement")
if thorium_section and "Recipe: Transmute Elemental Fire" in thorium_actual:
    errors.append("Transmute Elemental Fire must not be audited as an ordinary stock-only recipe")

# Argent Dawn standard quartermaster recipes, confirmed in-game.
argent_expected = {
    "Plans: Girdle of the Dawn": "Honored",
    "Plans: Gloves of the Dawn": "Revered",
    "Pattern: Argent Boots": "Honored",
    "Pattern: Argent Shoulders": "Revered",
    "Recipe: Transmute Air to Fire": "Honored",
    "Pattern: Dawn Treaders": "Honored",
    "Pattern: Golden Mantle of the Dawn": "Revered",
    "Formula: Powerful Anti-Venom": "Honored",
    "Formula: Enchant Bracer - Mana Regeneration": "Honored",
    "Formula: Enchant Bracer - Healing": "Revered",
}
argent_section = re.search(r"argent_dawn_vendor_conditions\s*=\s*\{(.*?)\n    \},", data, re.S)
if not argent_section:
    errors.append("Argent Dawn vendor table missing")
else:
    pairs = re.findall(r'\["([^"]+)"\]\s*=\s*"([^"]+)"', argent_section.group(1))
    values = {}
    for name, rank in pairs:
        if name in values:
            errors.append("duplicate Argent Dawn recipe: " + name)
        values[name] = rank
    if values != argent_expected:
        errors.append("Argent Dawn stock list or reputation ranks differ from confirmed list")

# Omarion teaches frost-resistance patterns according to profession and reputation.
omarion_expected = {
    "Glacial Wrists": ("Tailoring", "Revered"),
    "Glacial Gloves": ("Tailoring", "Revered"),
    "Glacial Vest": ("Tailoring", "Exalted"),
    "Glacial Cloak": ("Tailoring", "Exalted"),
    "Polar Bracers": ("Leatherworking", "Revered"),
    "Polar Gloves": ("Leatherworking", "Revered"),
    "Icy Scale Bracers": ("Leatherworking", "Revered"),
    "Icy Scale Gauntlets": ("Leatherworking", "Revered"),
    "Polar Tunic": ("Leatherworking", "Exalted"),
    "Icy Scale Breastplate": ("Leatherworking", "Exalted"),
    "Icebane Bracers": ("Blacksmithing", "Revered"),
    "Icebane Gauntlets": ("Blacksmithing", "Revered"),
    "Icebane Breastplate": ("Blacksmithing", "Exalted"),
}
omarion_section = re.search(r"omarion_recipes\s*=\s*\{(.*?)\n    \},", data, re.S)
if not omarion_section:
    errors.append("Omarion frost-resistance recipes table missing")
else:
    pairs = re.findall(r'\["([^"]+)"\]\s*=\s*\{profession = "([^"]+)", rank = "([^"]+)"', omarion_section.group(1))
    values = {}
    for name, profession, rank in pairs:
        if name in values:
            errors.append("duplicate Omarion recipe: " + name)
        values[name] = (profession, rank)
    if values != omarion_expected:
        errors.append("Omarion recipe profession or reputation tiers differ from checked list")

# A reputation record is only useful if the zone browser indexes it.
ui = (Path(__file__).resolve().parents[1] / "MissingTradeSkillsList/ui/mainframes/zone_hunter_frame.lua").read_text()
sources_body = re.search(r"function MTSLUI_ZONE_HUNTER:GetSources\(skill, profession, zone_id\)(.*?)\nend", ui, re.S)
if not sources_body or not all(term in sources_body.group(1) for term in (
    "omarion_recipes", "self:Name(skill)", "Eastern Plaguelands",
    'self:AddSource(sources, "Quest", "Wilhelm / Trainer: Omarion")'
)):
    errors.append("Omarion/Wilhelm recipes must be indexed with the compact source label in Eastern Plaguelands")
details_body = re.search(r"function MTSLUI_ZONE_HUNTER:DetailLines\(entry\)(.*?)\nend", ui, re.S)
if not details_body or not all(term in details_body.group(1) for term in (
    "TRAINING: Master Craftsman Omarion",
    "QUEST ROUTE: Craftsman Wilhelm",
    "Omarion's Handbook",
)):
    errors.append("Omarion/Wilhelm acquisition details must retain complete names and handbook prerequisite")

# Magnus Frostwake: six Classic vendor recipes share the Spectral Essence gate.
magnus_expected = {
    "Plans: Ebon Shiv", "Plans: Ornate Thorium Handaxe",
    "Plans: Huge Thorium Battleaxe", "Plans: Storm Gauntlets",
    "Recipe: Transmute Water to Air", "Recipe: Major Mana Potion",
}
magnus_section = re.search(r"vendor_conditions\s*=\s*\{(.*?)\n    \},", data, re.S)
if not magnus_section:
    errors.append("Magnus vendor_conditions table missing")
else:
    magnus_pairs = re.findall(
        r'\["([^"]+)"\]\s*=\s*\{\s*\["Magnus Frostwake"\]\s*=\s*\{\s*shared_access\s*=\s*"([^"]+)"',
        magnus_section.group(1),
    )
    magnus_actual = {}
    for item, access in magnus_pairs:
        if item in magnus_actual:
            errors.append("duplicate Magnus recipe: " + item)
        magnus_actual[item] = access
    if set(magnus_actual) != magnus_expected or any(access != "magnus_frostwake_access" for access in magnus_actual.values()):
        errors.append("Magnus vendor inventory or shared Spectral Essence gate mismatch")
magnus_access = re.search(r"magnus_frostwake_access\s*=\s*\{(.*?)\n    \},", data, re.S)
if not magnus_access or not all(word in magnus_access.group(1) for word in ("Spectral Essence", "Eva Sarkhoff", "Kirtonos", "Equip")):
    errors.append("Magnus access workflow must explain obtaining and equipping Spectral Essence")
if "cond.shared_access" not in ui or "workflows[cond.shared_access]" not in ui:
    errors.append("Zone Hunter UI must resolve Magnus shared access workflow")

# Verify coordinate fixes are narrow, sourced, and applied only in the matching zone.
coords_section = re.search(r"npc_coordinate_overrides\s*=\s*\{(.*?)\n    \},", data, re.S)
if not coords_section or not re.search(
    r'\["Magnus Frostwake"\]\s*=\s*\{zone = "Western Plaguelands", x = 68\.1, y = 77\.6, reference = "wowhead.com/classic/npc=11278/magnus-frostwake"\}',
    coords_section.group(1),
):
    errors.append("Magnus coordinate correction must be 68.1, 77.6 in Western Plaguelands")
if not all(fragment in ui for fragment in (
    "npc_coordinate_overrides", "correction and z == correction.zone",
    "tostring(correction.x)", "tostring(correction.y)", "elseif record.location",
)):
    errors.append("NPC coordinate overrides must be zone-scoped and retain upstream fallback")

# Restorative Potion is taught directly by the faction-specific final quest.
quest_section = re.search(r"quest_conditions\s*=\s*\{(.*?)\n    \}\n\}", data, re.S)
if not quest_section:
    errors.append("Restorative Potion quest workflows missing")
else:
    for quest_id, faction in ((2501, "Alliance"), (2203, "Horde")):
        pattern = rf'\[{quest_id}\]\s*=\s*\{{(.*?)(?=\n        \[\d+\]|\n    \}})'
        match = re.search(pattern, quest_section.group(1), re.S)
        if not match or not all(term in match.group(1) for term in (
            f'faction = "{faction}"',
            "DOCUMENTED - DIRECT RECIPE LEARNING",
            "Quest completion directly teaches Restorative Potion",
            "Alchemy 210",
        )):
            errors.append(f"Restorative Potion quest {quest_id} direct-learning workflow mismatch")

if errors:
    for error in errors:
        print("FAIL:", error)
    sys.exit(1)
print("PASS: 115 acquisition records audited (107 reputation-based, 6 Magnus quest-gated, 2 Restorative Potion quest variants); no missing keys, mismatches or duplicates")
