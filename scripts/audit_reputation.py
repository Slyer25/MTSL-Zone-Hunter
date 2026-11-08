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
        pattern = rf'\[{quest_id}\]\s*=\s*\{{(.*?)(?=\n        \[\d+\]|\Z)'
        match = re.search(pattern, quest_section.group(1), re.S)
        if not match or not all(term in match.group(1) for term in (
            f'faction = "{faction}"',
            "DIRECT RECIPE LEARNING",
            "Quest completion directly teaches Restorative Potion",
            "Alchemy 210",
            "both Uldaman Reagent Run and Badlands Reagent Run II become available",
            "not a prerequisite for learning Restorative Potion",
        )):
            errors.append(f"Restorative Potion quest {quest_id} direct-learning workflow mismatch")

# Faction-specific quest routes must be sorted, not hidden.
if not all(fragment in ui for fragment in (
    "MTSL_CURRENT_PLAYER.FACTION", "table.sort(ordered",
    "YOUR FACTION", "OTHER FACTION", "for _, id in ipairs(ordered)",
)):
    errors.append("Quest detail faction prioritization must retain alternate routes")

if not all(fragment in ui for fragment in (
    'entry.name == "Restorative Potion"',
    'table.insert(ordered, 2501)',
    'table.insert(ordered, 2203)',
    'ids or {}',
)):
    errors.append("Restorative Potion must include both faction variants when upstream quest links are incomplete")

# Three separately rewarded Enchanted Thorium plans and their book halves.
thorium_books = re.search(r"enchanted_thorium_quests\s*=\s*\{(.*?)\n    \},", data, re.S)
book_expected = {
    "Enchanted Thorium Breastplate": ("I", "7649", "King Gordok", "Goraluk Anvilcrack"),
    "Enchanted Thorium Leggings": ("II", "7650", "Rattlegore", "Crimson Hammersmith"),
    "Enchanted Thorium Helm": ("III", "7651", "Urok Doomhowl", "Black Guard Swordsmith"),
}
if not thorium_books:
    errors.append("Enchanted Thorium quest acquisition data missing")
else:
    found = re.findall(r'\["(Enchanted Thorium [^"]+)"\]\s*=\s*\{(.*?)\n        \}', thorium_books.group(1), re.S)
    if len(found) != 3 or {name for name, _ in found} != set(book_expected):
        errors.append("Enchanted Thorium plan count or identity mismatch")
    for name, details in found:
        if name in book_expected and not all(term in details for term in book_expected[name]):
            errors.append("Enchanted Thorium quest volume or drop mismatch: " + name)
if not all(term in ui for term in (
    "the completed book starts the turn-in quest",
    "No earlier quest chain or reputation unlock is required.",
)) or 'add("  Reward: Plans: " .. entry.name' in ui:
    errors.append("Enchanted Thorium instructions must explain no extra prerequisites without duplicate reward")
if not all(term in ui for term in (
    "enchanted_thorium_quests", '== "Feralas"',
    'Lorekeeper Lydros (Dire Maul)', "QUEST REWARD: Enchanted Thorium Platemail",
)):
    errors.append("Enchanted Thorium quest routes must be indexed under Feralas and shown in details")

if not all(term in ui for term in (
    'book and tonumber(id) == book.quest_id',
    'entry.profession == "Blacksmithing"',
    'Quest prerequisites not verified; earlier steps may be required',
)):
    errors.append("Enchanted Thorium quest warning must be suppressed only for matching book quest IDs")

# Blackrock Depths: special quest acquisitions are not reputation vendor stock.
brd_section = re.search(r"blackrock_quest_recipes\s*=\s*\{(.*?)\n    \},", data, re.S)
if not brd_section:
    errors.append("Blackrock quest acquisition database missing")
else:
    for recipe, terms in {
        "Smelt Dark Iron": ("Mining", 'kind = "direct"', "Gloom'rel", "20 Gold Bars", "10 Truesilver Bars", "2 Star Rubies", "Black Forge"),
        "Sulfuron Hammer": ("Blacksmithing", 'kind = "item"', "Sulfuron Ingot", "Golemagg", "Lokhtos", "A Binding Contract"),
    }.items():
        rec = re.search(r'\["' + re.escape(recipe) + r'"\]\s*=\s*\{(.*?)\n        \}', brd_section.group(1), re.S)
        if not rec or not all(term in rec.group(1) for term in terms):
            errors.append("Blackrock quest acquisition incomplete: " + recipe)
if not all(term in ui for term in ("blackrock_quest_recipes", '== "Blackrock Mountain"', "Gloom'rel (BRD)", "Lokhtos Darkbargainer (BRD)", "brd_flow.steps")):
    errors.append("Blackrock quest acquisition UI must index and describe both routes")

# BRD quests are confirmed by the user's completed acquisition paths.
if not all(fragment in ui for fragment in (
    'entry.name == "Smelt Dark Iron" and tonumber(id) == 4083',
    'entry.name == "Sulfuron Hammer" and tonumber(id) == 7604',
)):
    errors.append("Known BRD quest IDs must not show an unverified prerequisite warning")

# Field Repair Bot schematic must be an in-world object, not an NPC drop.
bot = re.search(r'engineering_object_recipes\s*=\s*\{(.*?)\n    \},', data, re.S)
if not bot or not all(term in bot.group(1) for term in (
    '["Field Repair Bot 74A"]', 'profession = "Engineering"',
    'Schematic: Field Repair Bot 74A', 'Golem Lord Argelmach',
    'Engineering 300', 'interactable world object',
)):
    errors.append("Field Repair Bot 74A schematic source incomplete")
if not all(term in ui for term in (
    "engineering_object_recipes", 'object_flow.object .. " (BRD)"',
    "OBJECT SCHEMATIC:", "object_flow.steps",
)):
    errors.append("Field Repair Bot 74A source indexing or detail rendering missing")

# Dungeon/raid suffixes only use instance-zone source metadata (or Lokhtos override).
if not all(term in ui for term in (
    "function MTSLUI_ZONE_HUNTER:InstanceTag",
    'source_name == "Lokhtos Darkbargainer"',
    '["Blackrock Depths"] = "BRD"',
    '["Molten Core"] = "MC"',
    '["Ruins of Ahn\'Qiraj"] = "AQ20"',
    '["Temple of Ahn\'Qiraj"] = "AQ40"',
    'self:InstanceSourceName(self:Name(npc), self:NPCZone(npc))',
    'self:InstanceSourceName(self:Name(obj), obj.zone_id)',
    'if tag and not string.find(name, "(" .. tag .. ")", 1, true)',
)):
    errors.append("Dungeon suffixes must be source-zone-specific for NPCs, drops and objects")
if '["Molten Core"] = "Blackrock Mountain"' not in ui or '["Temple of Ahn\'Qiraj"] = "Silithus"' not in ui:
    errors.append("Raid parent-zone mapping must include MC and AQ")

# Reviewed frost source must take precedence over upstream Handbook quest labels.
get_sources = re.search(r"function MTSLUI_ZONE_HUNTER:GetSources\(skill, profession, zone_id\)(.*?)\nend", ui, re.S)
if not get_sources or not re.search(
    r'self:AddSource\(sources, "Quest", "Wilhelm / Trainer: Omarion"\).*?return sources\s*end',
    get_sources.group(1), re.S
):
    errors.append("Frost sources must return compact Wilhelm/Omarion label before upstream sources")

# Dire Maul North tribute engineering schematic: preserve possible-reward wording.
tribute = re.search(r"tribute_recipes\s*=\s*\{(.*?)\n    \},", data, re.S)
if not tribute or not all(term in tribute.group(1) for term in (
    '["Major Recombobulator"]', 'profession = "Engineering"',
    'Gordok Tribute', 'Engineering 275',
    'possible tribute reward, not a guaranteed drop',
)):
    errors.append("Major Recombobulator Gordok Tribute acquisition data missing or overstated")
if not all(term in ui for term in (
    "MTSL_ZONE_WORKFLOWS.tribute_recipes",
    'self:AddSource(sources, "Tribute chest", "Gordok Tribute (DM)")',
    'TRIBUTE REWARD:', 'tribute.steps',
)):
    errors.append("Major Recombobulator tribute source/details must render in Feralas")

# Dungeon drops: avoid inventing separate quests or guaranteed rewards.
guidance = re.search(r"dungeon_drop_guidance\s*=\s*\{(.*?)\n    \},", data, re.S)
if not guidance or not all(part in guidance.group(1) for part in (
    '["Goblin Jumper Cables XL"]', 'profession = "Engineering"',
    'Plugger Spazzring', 'Blackrock Depths', 'Engineering 265',
    'Goblin Engineering', 'not a guaranteed reward',
    'Requires Engineering 265 and Goblin Engineering to learn the schematic.',
)):
    errors.append("Goblin Jumper Cables XL dungeon guidance missing or incomplete")
if not all(part in ui for part in (
    "MTSL_ZONE_WORKFLOWS.dungeon_drop_guidance",
    "DUNGEON SCHEMATIC:", "dungeon_guide.steps",
)):
    errors.append("Goblin Jumper Cables XL acquisition details not wired")

# Keep the actual MTSL mob drop ahead of the custom Goblin Jumper Cables XL
# workflow, and avoid duplicating the drop on a subsequent details page.
if not all(part in ui for part in (
    'local promote_jumper_drops = entry.name == "Goblin Jumper Cables XL"',
    'if (promote_jumper_drops or promote_pusillin_drops) and entry.skill.items then',
    'if not promote_jumper_drops and not promote_pusillin_drops then',
)):
    errors.append("Jumper Cables XL known mob drop must be promoted without duplication")
if 'Loot and use the schematic item to learn the recipe; defeating Plugger' in data:
    errors.append("Jumper Cables XL redundant fourth instruction must stay removed")

# Goblin Jumper Cables XL must not repeat the mob source or leave a
# standalone generic progress reminder after the specialization workflow.
if not all(fragment in ui for fragment in (
    'if not promote_jumper_drops and not promote_pusillin_drops then',
    'add("  Source: " .. dungeon_guide.source .. " - " .. dungeon_guide.dungeon)',
    'promote_jumper_drops and string.find(line, "Progress is not automatically verified", 1, true)',
)):
    errors.append("Goblin Jumper Cables XL source deduplication or orphan-page fix missing")

# Specialization lock stays visible in the list when unknown, and the
# requirement stays visible when known; only unknown specs get walkthroughs.
if not all(part in ui for part in (
    '[Requires: " .. spec .. "]',
    '[Locked: " .. spec .. "]',
    'if spec and not known then',
)):
    errors.append("Specialization requirement/guide visibility must depend on character specialization")

# Original Classic Dirge recipe: quest reward in Gadgetzan, with full chain.
epic = re.search(r"epic_quest_recipes\s*=\s*\{(.*?)\n    \},", data, re.S)
if not epic or not all(term in epic.group(1) for term in (
    """["Dirge's Kickin' Chimaerok Chops"]""",
    'profession = "Cooking"', 'zone = "Tanaris"',
    'quest_id = 8586', 'Narain Soothfancy',
    'The Isle of Dread!', 'Lord Lakmaeran',
    '20 Chimaerok Tenderloins', '20 Goblin Rocket Fuel',
    '20 Deeprock Salt', 'recipe ITEM (not direct learning)',
    'tradeable',
)):
    errors.append("Dirge recipe must record complete Scepter chain and item reward")
if not all(term in ui for term in (
    'MTSL_ZONE_WORKFLOWS.epic_quest_recipes',
    'self:AddSource(sources, "Quest", epic.giver .. " (Gadgetzan)")',
    'QUEST REWARD: " .. epic.item',
    'epic.steps',
)):
    errors.append("Dirge's Cooking quest must be indexed in Tanaris and explained in details")

# Scope-check acquisition blocks: a previous release accidentally inserted
# a DetailLines-only block into GetSources, crashing on undefined 'entry'.
source_scope = re.search(
    r"function MTSLUI_ZONE_HUNTER:GetSources\(skill, profession, zone_id\)(.*?)\nend",
    ui, re.S
)
detail_scope = re.search(
    r"function MTSLUI_ZONE_HUNTER:DetailLines\(entry\)(.*?)\nend",
    ui, re.S
)
if not source_scope or not detail_scope:
    errors.append("GetSources or DetailLines not found for scope audit")
else:
    if "entry.name" in source_scope.group(1) or "entry.profession" in source_scope.group(1):
        errors.append("GetSources must not reference the DetailLines-only entry variable")
    if 'add("QUEST REWARD: " .. epic.item' in source_scope.group(1):
        errors.append("Dirge's detail display must not be in GetSources")
    if not all(part in detail_scope.group(1) for part in (
        'local epic = epic_recipes and epic_recipes[entry.name]',
        'add("QUEST REWARD: " .. epic.item',
        'for n, step in ipairs(epic.steps)',
    )):
        errors.append("Dirge's reviewed acquisition workflow missing from DetailLines")

# MTSL's stored specialization IDs can be incomplete; use only exact known
# spellbook names (with an alias), not approximate name matching.
if not all(part in ui for part in (
    'if not spec_known and GetNumSpellTabs and GetSpellTabInfo and GetSpellName then',
    'GetSpellTabInfo(tab)',
    'GetSpellName(slot, BOOKTYPE_SPELL or "spell")',
    'spell_name == spec_name or spell_name == alternate',
    'if spec and not known then',
)):
    errors.append("Known specialization spellbook fallback or conditional details missing")

# The fully documented Dirge quest must not inherit the generic
# unknown-prerequisites warning, while unrelated quests retain it.
if not all(x in ui for x in (
    'entry.profession == "Cooking"',
    'entry.name == "Dirge\'s Kickin\' Chimaerok Chops" and tonumber(id) == 8586',
    'Quest prerequisites not verified; earlier steps may be required',
)):
    errors.append("Dirge quest 8586 must suppress only its generic prerequisite warning")

# Silithus quest: Sharing the Knowledge teaches the recipe directly.
# The later Kitchen Assistance quest must not be asserted as a prerequisite.
direct = re.search(r"direct_quest_recipes\s*=\s*\{(.*?)\n    \},", data, re.S)
if not direct or not all(part in direct.group(1) for part in (
    '["Smoked Desert Dumplings"]', 'profession = "Cooking"',
    'zone = "Silithus"', 'quest_id = 8313', 'Cooking 285',
    'Desert Recipe', 'Sandy Cookbook', 'Torn Recipe Page',
    'Calandrath', 'Completion teaches Smoked Desert Dumplings directly',
    'Kitchen Assistance is a follow-up quest, not a prerequisite',
)):
    errors.append("Smoked Desert Dumplings direct learning workflow missing or incomplete")
if not all(part in ui for part in (
    'MTSL_ZONE_WORKFLOWS.direct_quest_recipes',
    'self:AddSource(sources, "Quest", "Sharing the Knowledge: Calandrath")',
    'add("QUEST LEARNING: Sharing the Knowledge [ID " .. direct.quest_id',
    'direct.steps',
    'entry.name == "Smoked Desert Dumplings" and tonumber(id) == 8313',
)):
    errors.append("Silithus Cooking quest source/details or targeted warning exemption missing")
if source_scope and "direct_db and direct_db[entry.name]" in source_scope.group(1):
    errors.append("Direct quest detail lookup must never reference entry inside GetSources")
if detail_scope and 'direct_db and direct_db[entry.name]' not in detail_scope.group(1):
    errors.append("Smoked Desert Dumplings instructions must be in DetailLines")

# Razorfen Downs: original Classic training is direct, with the separate
# Alchemy item-drop record preserved rather than replaced.
lessons = re.search(r"dungeon_npc_lessons\s*=\s*\{(.*?)\n    \},", data, re.S)
if not lessons or not all(term in lessons.group(1) for term in (
    '["Goldthorn Tea"]', 'profession = "Cooking"', 'skill = 175',
    '["Mighty Troll\'s Blood Potion"]', 'profession = "Alchemy"',
    'skill = 180', 'Henry Stern', 'Razorfen Downs', 'Murder Pens',
    'directly for free', 'not specific to Razorfen Downs',
)):
    errors.append("Razorfen Downs Henry Stern direct lessons missing or inaccurate")
if not all(term in ui for term in (
    'MTSL_ZONE_WORKFLOWS.dungeon_npc_lessons',
    'self:AddSource(sources, "Trainer", lesson.npc .. " (RFD)")',
    'if profession == "Cooking" then return sources end',
    'add("DUNGEON TRAINER: " .. lesson.npc',
    'for n, step in ipairs(lesson.steps)',
)):
    errors.append("Henry Stern source indexing or detail rendering missing")
if source_scope and ("lesson_db and lesson_db[entry.name]" in source_scope.group(1)):
    errors.append("Henry Stern details must not use entry in GetSources")
if detail_scope and "lesson_db and lesson_db[entry.name]" not in detail_scope.group(1):
    errors.append("Henry Stern lessons must render in DetailLines")

# Henry Stern's original Goldthorn Tea training threshold is 175; an
# upstream recipe record may instead list 125. The UI and lock status must
# agree without globally modifying MTSL's source data.
if not all(term in ui for term in (
    'if profession == "Cooking" and self:Name(skill) == "Goldthorn Tea" then',
    'needed = 175',
    '(profession == "Cooking" and self:Name(skill) == "Goldthorn Tea") and 175',
)):
    errors.append("Goldthorn Tea's required Cooking 175 must match header and skill checks")
if 'preserve other recorded MTSL sources' in data:
    errors.append("Henry Stern source notes must not expose internal MTSL instructions")
if "that route is not specific to Razorfen Downs" not in data:
    errors.append("Mighty Troll's Blood Potion alternative drop note missing")

# Goldthorn Tea: keep Henry's precise location inside the main acquisition
# instructions and avoid a detached, single-line trainer page.
if not all(term in data for term in (
    'location = "Razorfen Downs (79.86, 10.74)"',
    'With Cooking 175, speak to him to learn Goldthorn Tea directly for free.',
)):
    errors.append("Goldthorn Tea compact route or Henry Stern location missing")
if not all(term in ui for term in (
    'entry.name == "Goldthorn Tea" then',
    'lesson.npc .. " - " .. lesson.location',
    'entry.name ~= "Goldthorn Tea" then',
)):
    errors.append("Goldthorn Tea must inline the Henry Stern location and hide duplicate trainer footer")
if not all(term in data for term in (
    '["Runn Tum Tuber Surprise"]', 'profession = "Cooking"',
    'kind = "recipe"', 'source = "Pusillin"',
    'dungeon = "Dire Maul East"', 'Cooking 275',
    'Crescent Key', 'Warpwood Pods', 'Bind-on-Pickup',
)):
    errors.append("Runn Tum Tuber Surprise acquisition data incomplete")
if not all(term in ui for term in (
    'self:Name(skill) == "Runn Tum Tuber Surprise"',
    'self:AddSource(sources, "Mob drop", "Pusillin (DM)")',
    'dungeon_guide.kind == "recipe"',
    'DUNGEON RECIPE: ',
)):
    errors.append("Runn Tum Tuber Surprise source or recipe-specific detail header missing")
if source_scope and "entry.name" in source_scope.group(1):
    errors.append("GetSources must never reference entry (undefined in its scope)")

# Pusillin: move the already-recorded mob into the first details section,
# and do not repeat its location or recipe item later in the same panel.
if not all(part in ui for part in (
    'local promote_pusillin_drops = entry.name == "Runn Tum Tuber Surprise"',
    'promote_jumper_drops or promote_pusillin_drops',
    'not promote_jumper_drops and not promote_pusillin_drops',
    'if not promote_pusillin_drops then',
)):
    errors.append("Pusillin mob-drop promotion or duplicate suppression missing")
pusillin = re.search(r'\["Runn Tum Tuber Surprise"\]\s*=\s*\{(.*?)\n        \},', data, re.S)
if not pusillin or not all(k in pusillin.group(1) for k in (
    'no Crescent Key', 'Bind-on-Pickup', 'Cooking 275', 'Warpwood Pods',
)):
    errors.append("Pusillin concise quest guidance missing")
if pusillin and pusillin.group(1).count('".') > 3:
    errors.append("Pusillin instructions should stay concise")

# Knot's Vanilla Dire Maul suit teaches Tailoring and Leatherworking directly,
# and the suit quest must be finished before freeing Knot with the shackle key.
craft = re.search(r'dungeon_crafting_unlocks\s*=\s*\{(.*?)\n    \},', data, re.S)
if not craft or not all(part in craft.group(1) for part in (
    '["Gordok Ogre Suit"]', 'professions = { Tailoring = true, Leatherworking = true }',
    'quest_id = 5518', 'skill = 275', 'Gordok Shackle Key',
    '8 Rugged Leather', '4 Bolts of Runecloth', '2 Rune Thread',
    '1 Ogre Tannin', 'Gordok Bushwacker', 'no pattern item',
)):
    errors.append("Gordok Ogre Suit dungeon crafting unlock incomplete")
if not all(part in ui for part in (
    'MTSL_ZONE_WORKFLOWS.dungeon_crafting_unlocks',
    'self:AddSource(sources, "Quest / trainer", "Knot Thimblejack (DM)")',
    'local crafting = crafting_db and crafting_db[entry.name]',
    'crafting.professions[entry.profession]',
    'DUNGEON CRAFTING UNLOCK:',
)):
    errors.append("Gordok Ogre Suit source or acquisition details not integrated")
if source_scope and ("crafting_db and crafting_db[entry.name]" in source_scope.group(1)):
    errors.append("Knot recipe detail code must not be inserted into GetSources")
if detail_scope and "crafting_db and crafting_db[entry.name]" not in detail_scope.group(1):
    errors.append("Knot crafting unlock not in DetailLines")

# Gordok has two distinct thresholds: 275 for Knot's dialogue and the
# upstream MTSL crafting skill displayed for each profession (e.g. 285).
if not all(x in ui for x in (
    'local is_gordok = entry.name == "Gordok Ogre Suit"',
    'is_gordok and "  |  Crafting skill: "',
    'local skill_label = is_gordok and "CRAFTING SKILL" or "SKILL"',
    'LEARNING FROM KNOT: ',
    'CRAFTING REQUIREMENT (MTSL): ',
    'tostring(crafting.skill)', 'tostring(entry.min_skill)',
)):
    errors.append("Gordok learning-versus-crafting skill distinction missing")

# Original Classic Knot Thimblejack's Cache: NOT the tribute chest, and
# no specific pattern is guaranteed. Only reviewed pattern names are matched.
cache_map = re.search(r'knot_cache_recipes\s*=\s*\{(.*?)\n    \},', data, re.S)
cache_flow = re.search(r'knot_cache_access\s*=\s*\{(.*?)\n    \},', data, re.S)
cache_expected = (
    'Chromatic Cloak', 'Hide of the Wild', 'Shifting Cloak',
    'Girdle of Insight', 'Mongoose Boots', 'Swift Flight Bracers',
    'Belt of the Archmage', 'Cloak of Warding', 'Inferno Gloves',
    'Felcloth Gloves', 'Mooncloth Gloves',
)
if not cache_map or not all('["' + name + '"]' in cache_map.group(1) for name in cache_expected):
    errors.append("Knot cache's 11 classic pattern mappings missing")
if not cache_flow or not all(x in cache_flow.group(1) for x in (
    'Dire Maul North', 'Gordok Shackle Key', 'Free Knot!',
    'BEFORE freeing Knot', 'chance at this pattern', 'NOT the Gordok Tribute chest',
)):
    errors.append("Knot cache unlock instructions or chance distinction missing")
if not all(x in ui for x in (
    'MTSL_ZONE_WORKFLOWS.knot_cache_recipes',
    'MTSL_ZONE_WORKFLOWS.knot_cache_access',
    'cache_map[entry.name] == entry.profession',
    'DUNGEON CACHE: ',
)):
    errors.append("Knot cache recipe detail matching missing")
if source_scope and ('cache_map[entry.name]' in source_scope.group(1)):
    errors.append("Knot cache acquisition details must not be inserted into GetSources")
if detail_scope and ('cache_map[entry.name]' not in detail_scope.group(1)):
    errors.append("Knot cache acquisition details missing from DetailLines")

# Knot's cache-specific cleanup: avoid the duplicate object entry, keep
# recipe item, and show the documented 5518 -> 5519 repeatable requirement.
if not all(x in ui for x in (
    'if not is_knot_cache then object_list(skill.objects) end',
    'REPEATABLE QUEST: First complete The Gordok Ogre Suit [ID 5518].',
    'tonumber(id) == 5518 or tonumber(id) == 5519',
)):
    errors.append("Knot cache deduplication or explicit repeatable quest requirement missing")
if not all(x in data for x in (
    'No pattern is guaranteed. Knot\'s Cache is NOT the Gordok Tribute chest.',
    'BEFORE freeing Knot',
)):
    errors.append("Knot concise cache instructions missing")

# Both Vanilla faction quest rewards produce Recipe: Thistle Tea, rather
# than granting the Cooking skill directly; source zones are quest objectives.
thistle = re.search(r'rogue_thistle_tea\s*=\s*\{(.*?)\n    \},', data, re.S)
if not thistle or not all(x in thistle.group(1) for x in (
    'profession = "Cooking"', 'skill = 60', 'Recipe: Thistle Tea',
    'Alliance = {', 'zone = "Duskwood"', 'quest_id = 2359',
    'Klaven\'s Tower', 'Defias Tower Key', 'Klaven Mortwake\'s Journal',
    'Horde = {', 'zone = "The Barrens"', 'quest_id = 2478',
    'Mission: Possible But Not Probable', 'Shenthul', 'Gallywix\'s Head',
)):
    errors.append("Thistle Tea faction-specific Rogue quest routes incomplete")
if not all(x in ui for x in (
    'MTSL_ZONE_WORKFLOWS.rogue_thistle_tea',
    'self:AddSource(sources, "Rogue quest", route.title',
    'entry.name == "Thistle Tea"',
    'ROGUE QUEST REWARD:',
    'MTSL_CURRENT_PLAYER and MTSL_CURRENT_PLAYER.FACTION',
    'Other faction: ',
)):
    errors.append("Thistle Tea source indexing, faction ordering or acquisition details missing")
if source_scope and ('entry.name == "Thistle Tea"' in source_scope.group(1)):
    errors.append("Thistle Tea details must not reference entry in GetSources")
if detail_scope and 'ROGUE QUEST REWARD:' not in detail_scope.group(1):
    errors.append("Thistle Tea quest workflow missing from DetailLines")

if errors:
    for error in errors:
        print("FAIL:", error)
    sys.exit(1)
print("PASS: 142 acquisition records audited (107 reputation-based, 6 Magnus quest-gated, 2 Restorative Potion quest variants, 3 Enchanted Thorium quests, 2 Blackrock quest acquisitions, 1 BRD object schematic, 1 Dire Maul tribute schematic, 1 BRD schematic drop, 1 Tanaris epic Cooking quest, 1 Silithus direct-learning Cooking quest, 2 RFD NPC-taught recipes, 1 Dire Maul East recipe drop, 1 Dire Maul North two-profession crafting unlock, 11 Knot cache patterns, 2 Rogue faction quest routes); no missing keys, mismatches or duplicates")
