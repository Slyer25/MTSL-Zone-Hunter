-- Zone Hunter independent, editable condition database (Vanilla 1.12).
-- Only record a source-specific unlock as verified when documented or tested.
-- Comments are notes for researchers, not proof of universal game behavior.
MTSL_ZONE_WORKFLOWS = {
    -- Reviewed Vanilla Cooking vendors: preserve any additional MTSL sources.
    tanaris_cooking_vendors = {
        ["Undermine Clam Chowder"] = {profession = "Cooking", skill = 225, zone = "Tanaris",
            sellers = {"Jabbey"}, location = "Steamwheedle Port", limited = true},
        ["Spotted Yellowtail"] = {profession = "Cooking", skill = 225, zone = "Tanaris",
            sellers = {"Gikkix"}, location = "Steamwheedle Port"},
        ["Grilled Squid"] = {profession = "Cooking", skill = 240, zone = "Tanaris",
            sellers = {"Gikkix"}, location = "Steamwheedle Port"},
        ["Nightfin Soup"] = {profession = "Cooking", skill = 250, zone = "Tanaris",
            sellers = {"Gikkix"}, location = "Steamwheedle Port"},
        ["Poached Sunscale Salmon"] = {profession = "Cooking", skill = 250, zone = "Tanaris",
            sellers = {"Gikkix"}, location = "Steamwheedle Port"},
        ["Tender Wolf Steak"] = {profession = "Cooking", skill = 225, zone = "Tanaris",
            sellers = {"Dirge Quikcleave", "Innkeeper Fizzgrimble"}, location = "Gadgetzan"}
    },
    -- Reviewed neutral Cooking vendor in Booty Bay, Stranglethorn Vale.
    -- Preserve other sellers from the original MTSL recipe-item records.
    booty_bay_cooking_vendors = {
        ["Smoked Sagefish"] = {profession = "Cooking", skill = 80,
            zone = "Stranglethorn Vale", sellers = {"Kelsey Yance"}, location = "Booty Bay"},
        ["Giant Clam Scorcho"] = {profession = "Cooking", skill = 175,
            zone = "Stranglethorn Vale", sellers = {"Kelsey Yance"}, location = "Booty Bay"},
        ["Mithril Headed Trout"] = {profession = "Cooking", skill = 175,
            zone = "Stranglethorn Vale", sellers = {"Kelsey Yance"}, location = "Booty Bay"},
        ["Rockscale Cod"] = {profession = "Cooking", skill = 175,
            zone = "Stranglethorn Vale", sellers = {"Kelsey Yance"}, location = "Booty Bay"},
        ["Sagefish Delight"] = {profession = "Cooking", skill = 175,
            zone = "Stranglethorn Vale", sellers = {"Kelsey Yance"}, location = "Booty Bay"},
        ["Cooked Glossy Mightfish"] = {profession = "Cooking", skill = 225,
            zone = "Stranglethorn Vale", sellers = {"Kelsey Yance"}, location = "Booty Bay"},
        ["Filet of Redgill"] = {profession = "Cooking", skill = 225,
            zone = "Stranglethorn Vale", sellers = {"Kelsey Yance"}, location = "Booty Bay"},
        ["Hot Smoked Bass"] = {profession = "Cooking", skill = 240,
            zone = "Stranglethorn Vale", sellers = {"Kelsey Yance"}, location = "Booty Bay"}
    },
    -- Additional Classic Stranglethorn Vale recipes sold at the Rebel Camp
    -- and Grom'gol. Vendor faction determines who can purchase locally.
    stranglethorn_cooking_vendors = {
        ["Jungle Stew"] = {profession = "Cooking", skill = 175,
            zone = "Stranglethorn Vale", sellers = {"Corporal Bluth", "Nerrist"},
            location = "Rebel Camp / Grom'gol Base Camp"},
        ["Roast Raptor"] = {profession = "Cooking", skill = 175,
            zone = "Stranglethorn Vale", sellers = {"Corporal Bluth", "Nerrist"},
            location = "Rebel Camp / Grom'gol Base Camp"},
        ["Spiced Chili Crab"] = {profession = "Cooking", skill = 225,
            zone = "Stranglethorn Vale", sellers = {"Uthok"},
            location = "Grom'gol Base Camp"}
    },
    -- Source: wowhead.com/classic/guide/cooking-vendor-recipes-wow-classic
    -- Sources: wowhead.com/classic/npc=2664/kelsey-yance
    --          wow-professions.com/classic/npc/kelsey-yance
    -- Vendor records sourced from wowhead.com/classic/guide/cooking-vendor-recipes-wow-classic
    -- Original Vanilla zone-specific recipe drop. This is not a confirmed
    -- individual NPC loot table, and no modern post-Cataclysm rate is used.
    zone_drop_recipes = {
        ["Savory Deviate Delight"] = {
            profession = "Cooking", zone = "The Barrens", skill = 85,
            source = "Rare zone drop",
            steps = {
                "Rare random drop from creatures outdoors in The Barrens; no named mob is guaranteed.",
                "Alternatively, trade for Recipe: Savory Deviate Delight or check the Auction House.",
                "Use the recipe item with Cooking 85 to learn it."
            },
            reference = "wowclassicdatabase.com/item/recipe-savory-deviate-delight"
        }
    },
    specialisations = {
        ["Tribal Leatherworking"] = {
            confidence = "DOCUMENTED (Classic guides; not yet tested in this addon)",
            steps = {
                "Requires Leatherworking 225 and character level 40 for final Tribal quest.",
                "FERALAS: Start Wild Leather Armor with Pratt McGrubben (Alliance) or Jangdor Swiftstrider (Horde).",
                "Finish the five Wild Leather pattern quests: Vest, Shoulders, Leggings, Helmet, Boots.",
                "Finish Master of the Wild Leather: turn in at Telonis (Darnassus) or Una (Thunder Bluff).",
                "Prepare 1 Wild Leather Vest and 1 Wild Leather Helmet.",
                "Complete Tribal Leatherworking with Caryssia (Feralas, Alliance) or Se'Jib (STV, Horde).",
                "Return to a Tribal Leatherworking trainer to learn the recipe."
            },
            reference = "wowhead.com/classic/guide/leatherworking-leveling-1-300-wow-classic"
        }

        ,["Armorsmith"] = {
            confidence = "DOCUMENTED (Classic quest sources; Mithril Order chain may have additional steps)",
            steps = {
                "Reach character level 40 and Blacksmithing 225.",
                "Complete the Mithril Order crafting questline to obtain Ornate Mithril plans; check earlier prerequisites.",
                "Craft 4 Ornate Mithril Helms, 2 Ornate Mithril Boots, and 1 Ornate Mithril Breastplate.",
                "Alliance: The Art of the Armorsmith with Grumnus Steelshaper in Ironforge.",
                "Horde: The Art of the Armorsmith with Okothos Ironrager in Orgrimmar.",
                "Complete the quest to gain Armorsmith specialization; competing Weaponsmith path is exclusive."
            },
            reference = "wowhead.com/classic/quest=5283/the-art-of-the-armorsmith"
        },
        ["Weaponsmith"] = {
            confidence = "DOCUMENTED (Classic quests; earlier introduction steps may vary)",
            steps = {
                "Reach character level 40 and Blacksmithing 200 or higher.",
                "Ask the Blacksmithing specialization contact about the Weaponsmith path.",
                "Obtain 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes, and 2 Big Black Maces.",
                "Alliance: The Way of the Weaponsmith with Ironus Coldsteel in Ironforge.",
                "Horde: The Way of the Weaponsmith with Borgosh Corebender in Orgrimmar.",
                "Complete the quest to unlock Weaponsmith; Armorsmith is the competing path."
            },
            reference = "wowhead.com/classic/quest=5284/the-way-of-the-weaponsmith"
        },
        ["Elemental Leatherworking"] = {
            confidence = "DOCUMENTED (Classic specialization quest)",
            steps = {
                "Reach Leatherworking 225 and character level 40; choose this instead of Tribal or Dragonscale.",
                "Collect 2 Heart of Fire, 2 Globe of Water, 2 Core of Earth, and 2 Breath of Wind.",
                "Alliance: speak to Sarah Tanner in Searing Gorge.",
                "Horde: speak to Brumn Winterhoof in Arathi Highlands.",
                "Turn in the Elemental Leatherworking quest to unlock specialty training."
            },
            reference = "wowhead.com/classic/quest=5146/elemental-leatherworking"
        },
        ["Dragonscale Leatherworking"] = {
            confidence = "DOCUMENTED (Classic specialization quests)",
            steps = {
                "Reach Leatherworking 225 and character level 40; choose this instead of Tribal or Elemental.",
                "Obtain 2 Tough Scorpid Breastplates, 2 Tough Scorpid Gloves, and 10 Worn Dragonscales.",
                "Tough Scorpid recipes may require drops or purchase; verify availability before traveling.",
                "Alliance: complete Dragonscale Leatherworking with Peter Galen in Azshara.",
                "Horde: complete Dragonscale Leatherworking with Thorkaf Dragoneye in Badlands."
            },
            reference = "wowhead.com/classic/quest=5141/dragonscale-leatherworking"
        },
        ["Master Axesmith"] = {
            confidence = "DOCUMENTED trainer/location; Vanilla 1.12 unlock quest requirements not fully verified",
            steps = {
                "First become a Weaponsmith through The Way of the Weaponsmith.",
                "Reach the advanced Blacksmithing/character-level requirement (commonly reported as Blacksmithing 300, level 50).",
                "Find Kilram at Everlook in Winterspring; select the Master Axesmith branch.",
                "IMPORTANT: Modern Classic databases include Snakestone of the Shadow Huntress (LBRS). Do not assume that quest exists or is required in the 1.12 client.",
                "Confirm any quest or dialogue requirement with the actual in-game trainer."
            },
            reference = "wow-professions.com/classic/weaponsmith-specialization-wow-classic"
        },
        ["Master Hammersmith"] = {
            confidence = "DOCUMENTED trainer/location; Vanilla 1.12 unlock quest requirements not fully verified",
            steps = {
                "First become a Weaponsmith through The Way of the Weaponsmith.",
                "Reach the advanced Blacksmithing/character-level requirement (commonly reported as Blacksmithing 300, level 50).",
                "Find Lilith the Lithe at Everlook in Winterspring; select the Master Hammersmith branch.",
                "IMPORTANT: Modern Classic databases include Sweet Serenity (Stratholme). Do not assume that quest exists or is required in 1.12.",
                "Confirm any quest or dialogue requirement with the actual in-game trainer."
            },
            reference = "wow-professions.com/classic/weaponsmith-specialization-wow-classic"
        },
        ["Master Swordsmith"] = {
            confidence = "DOCUMENTED trainer/location; Vanilla 1.12 unlock quest requirements not fully verified",
            steps = {
                "First become a Weaponsmith through The Way of the Weaponsmith.",
                "Reach the advanced Blacksmithing/character-level requirement (commonly reported as Blacksmithing 300, level 50).",
                "Find Seril Scourgebane at Everlook in Winterspring; select the Master Swordsmith branch.",
                "IMPORTANT: Modern Classic databases include Corruption (Stratholme). Do not assume that quest exists or is required in 1.12.",
                "Confirm any quest or dialogue requirement with the actual in-game trainer."
            },
            reference = "wow-professions.com/classic/weaponsmith-specialization-wow-classic"
        },
        ["Gnomish Engineering"] = {
            confidence = "DOCUMENTED (Classic guide; verify faction-specific introductory quests)",
            steps = {
                "Reach Engineering 200 and character level 30; select Gnomish rather than Goblin Engineering.",
                "Alliance: obtain Gnome Engineering in Ironforge, then visit Tinkmaster Overspark.",
                "Horde: begin with Tinkerwiz in Ratchet; follow the referral to your Gnomish instructor.",
                "Complete The Pledge of Secrecy, then Show Your Work.",
                "Turn in 6 Mithril Tubes, 2 Advanced Target Dummies, and 1 Accurate Scope.",
                "Complete the specialization before buying Gnomish-only schematics."
            },
            reference = "wow-professions.com/classic/gnomish-and-goblin-engineering-specialization-guide-wow-classic"
        },
        ["Goblin Engineering"] = {
            confidence = "DOCUMENTED (Classic guide; verify faction-specific introductory quests)",
            steps = {
                "Reach Engineering 200 and character level 30; select Goblin rather than Gnomish Engineering.",
                "Start Goblin Engineering through a specialization referral; Tinkerwiz in Ratchet is one contact.",
                "Visit Nixx Sprocketspring in Gadgetzan, Tanaris.",
                "Complete The Pledge of Secrecy, then Show Your Work.",
                "Turn in 20 Big Iron Bombs, 20 Solid Dynamites, and 5 Explosive Sheep.",
                "Complete specialization before buying Goblin-only schematics."
            },
            reference = "wow-professions.com/classic/gnomish-and-goblin-engineering-specialization-guide-wow-classic"
        }
    },
    -- Aliases match profession names returned by TradeSkillsData in Vanilla 1.12.
    aliases = {
        ["Gnomish Engineer"] = "Gnomish Engineering",
        ["Goblin Engineer"] = "Goblin Engineering",
        ["Master Axesmith"] = "Master Axesmith",
        ["Master Hammersmith"] = "Master Hammersmith",
        ["Master Swordsmith"] = "Master Swordsmith"
    },
    -- Thorium Brotherhood vendor, conditional on reputation.
    -- Match BOTH the recipe item name and vendor name; no global vendor-wide lock.
    -- Source: WoW Classic Thorium Brotherhood reputation reward tables.
    -- These values have not yet been tested in our Vanilla 1.12 client.
    thorium_brotherhood_vendor = "Lokhtos Darkbargainer",
    -- Vendor inventory visibility thresholds, not requirements on the recipe item itself.
    -- Confirmed in-game with Lokhtos, 2026-10-28.
    thorium_item_reputation = { ["Recipe: Transmute Elemental Fire"] = "Friendly" },
    thorium_brotherhood_reputation = {

        ["Plans: Dark Iron Bracers"] = "Friendly",
        ["Formula: Enchant Weapon - Strength"] = "Honored",
        ["Pattern: Molten Helm"] = "Friendly",
        ["Pattern: Corehound Boots"] = "Friendly",
        ["Pattern: Flarecore Gloves"] = "Friendly",
        ["Plans: Dark Iron Helm"] = "Honored",
        ["Plans: Dark Iron Destroyer"] = "Honored",
        ["Plans: Dark Iron Reaver"] = "Honored",
        ["Plans: Fiery Chain Girdle"] = "Honored",
        ["Formula: Enchant Weapon - Mighty Spirit"] = "Honored",
        ["Pattern: Lava Belt"] = "Honored",
        ["Pattern: Black Dragonscale Boots"] = "Honored",
        ["Pattern: Flarecore Mantle"] = "Honored",
        ["Pattern: Flarecore Robe"] = "Honored",
        ["Plans: Black Amnesty"] = "Revered",
        ["Plans: Blackfury"] = "Revered",
        ["Plans: Fiery Chain Shoulders"] = "Revered",
        ["Plans: Dark Iron Gauntlets"] = "Revered",
        ["Plans: Dark Iron Leggings"] = "Revered",
        ["Formula: Enchant Weapon - Mighty Intellect"] = "Revered",
        ["Pattern: Molten Belt"] = "Revered",
        ["Pattern: Corehound Belt"] = "Revered",
        ["Pattern: Chromatic Gauntlets"] = "Revered",
        ["Pattern: Flarecore Leggings"] = "Revered",
        ["Plans: Nightfall"] = "Exalted",
        ["Plans: Ebon Hand"] = "Exalted",
        ["Plans: Blackguard"] = "Exalted",
        ["Plans: Dark Iron Boots"] = "Exalted"
    },
    -- Add conditional vendors only when source, exact item, and gating criteria are validated.
    -- Keys should use the exact recipe item name and vendor NPC name, never just a zone.
    -- All six Classic Magnus Frostwake stock recipes share one access condition.
    -- Spectral Essence is a trinket that must be equipped to see and interact
    -- with Caer Darrow ghosts; this does not grant or teach a recipe directly.
    -- Corrections apply only to NPCs whose positions were independently verified.
    -- Never globally reverse MTSL's x/y coordinates.
    npc_coordinate_overrides = {
        ["Magnus Frostwake"] = {zone = "Western Plaguelands", x = 68.1, y = 77.6, reference = "wowhead.com/classic/npc=11278/magnus-frostwake"}
    },
    magnus_frostwake_access = {
        status = "DOCUMENTED - SPECTRAL ESSENCE REQUIRED",
        steps = {
            "Speak with Eva Sarkhoff outside Scholomance at Caer Darrow, Western Plaguelands.",
            "Complete her Scholomance chain starting with Doctor Theolen Krastinov, the Butcher.",
            "Complete the Kirtonos the Herald quest to obtain Spectral Essence.",
            "Equip the Spectral Essence trinket to see and interact with Caer Darrow ghosts.",
            "Find Magnus Frostwake inside the blacksmith building at Caer Darrow (around 68, 77)."
        },
        reference = "wow-professions.com/classic/npc/magnus-frostwake"
    },
    vendor_conditions = {
        ["Plans: Ebon Shiv"] = {
            ["Magnus Frostwake"] = { shared_access = "magnus_frostwake_access" }
        },
        ["Plans: Ornate Thorium Handaxe"] = {
            ["Magnus Frostwake"] = { shared_access = "magnus_frostwake_access" }
        },
        ["Plans: Huge Thorium Battleaxe"] = {
            ["Magnus Frostwake"] = { shared_access = "magnus_frostwake_access" }
        },
        ["Plans: Storm Gauntlets"] = {
            ["Magnus Frostwake"] = { shared_access = "magnus_frostwake_access" }
        },
        ["Recipe: Transmute Water to Air"] = {
            ["Magnus Frostwake"] = { shared_access = "magnus_frostwake_access" }
        },
        ["Recipe: Major Mana Potion"] = {
            ["Magnus Frostwake"] = { shared_access = "magnus_frostwake_access" }
        }
    },
    -- Exact recipe item -> vendor reputation condition; no universal zone-based gating.
    -- Source: Classic Cenarion Circle reputation profession reward tables.
    reputation_vendor_conditions = {
        ["Plans: Heavy Obsidian Belt"] = {vendor = "Vargus", faction = "Cenarion Circle", rank = "Friendly", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Plans: Ironvine Belt"] = {vendor = "Vargus", faction = "Cenarion Circle", rank = "Friendly", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Plans: Light Obsidian Belt"] = {vendor = "Vargus", faction = "Cenarion Circle", rank = "Honored", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Plans: Ironvine Gloves"] = {vendor = "Vargus", faction = "Cenarion Circle", rank = "Honored", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Plans: Ironvine Breastplate"] = {vendor = "Vargus", faction = "Cenarion Circle", rank = "Revered", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Formula: Enchant Cloak - Greater Fire Resistance"] = {vendor = "Kania", faction = "Cenarion Circle", rank = "Friendly", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Formula: Enchant Cloak - Greater Nature Resistance"] = {vendor = "Kania", faction = "Cenarion Circle", rank = "Honored", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Dreamscale Breastplate"] = {vendor = "Aendel Windspear", faction = "Cenarion Circle", rank = "Exalted", reference = "wowhead.com/classic/item=20382/pattern-dreamscale-breastplate"},
        ["Pattern: Sandstalker Bracers"] = {vendor = "Aendel Windspear", faction = "Cenarion Circle", rank = "Friendly", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Spitfire Bracers"] = {vendor = "Aendel Windspear", faction = "Cenarion Circle", rank = "Friendly", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Bramblewood Belt"] = {vendor = "Aendel Windspear", faction = "Cenarion Circle", rank = "Friendly", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Sandstalker Gauntlets"] = {vendor = "Aendel Windspear", faction = "Cenarion Circle", rank = "Honored", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Spitfire Gauntlets"] = {vendor = "Aendel Windspear", faction = "Cenarion Circle", rank = "Honored", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Bramblewood Boots"] = {vendor = "Aendel Windspear", faction = "Cenarion Circle", rank = "Honored", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Sandstalker Breastplate"] = {vendor = "Aendel Windspear", faction = "Cenarion Circle", rank = "Revered", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Spitfire Breastplate"] = {vendor = "Aendel Windspear", faction = "Cenarion Circle", rank = "Revered", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Bramblewood Helm"] = {vendor = "Aendel Windspear", faction = "Cenarion Circle", rank = "Revered", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Cenarion Herb Bag"] = {vendor = "Mishta", faction = "Cenarion Circle", rank = "Friendly", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Sylvan Shoulders"] = {vendor = "Mishta", faction = "Cenarion Circle", rank = "Friendly", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Sylvan Crown"] = {vendor = "Mishta", faction = "Cenarion Circle", rank = "Honored", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Satchel of Cenarius"] = {vendor = "Mishta", faction = "Cenarion Circle", rank = "Revered", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Sylvan Vest"] = {vendor = "Mishta", faction = "Cenarion Circle", rank = "Revered", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
        ["Pattern: Gaea's Embrace"] = {vendor = "Mishta", faction = "Cenarion Circle", rank = "Revered", reference = "wowhead.com/classic/guide/cenarion-circle-reputation-wow-classic"},
    },
    argent_dawn_reference = "wowhead.com/classic/guide/blacksmithing-vendor-recipes-wow-classic",
    argent_dawn_vendor_conditions = {
        ["Plans: Girdle of the Dawn"] = "Honored",
        ["Plans: Gloves of the Dawn"] = "Revered",
        ["Pattern: Argent Boots"] = "Honored",
        ["Pattern: Argent Shoulders"] = "Revered",
        ["Recipe: Transmute Air to Fire"] = "Honored",
        ["Pattern: Dawn Treaders"] = "Honored",
        ["Pattern: Golden Mantle of the Dawn"] = "Revered",
        ["Formula: Powerful Anti-Venom"] = "Honored",
        ["Formula: Enchant Bracer - Mana Regeneration"] = "Honored",
        ["Formula: Enchant Bracer - Healing"] = "Revered"
    },
    argent_dawn_vendors = {
        ["Argent Quartermaster Hasana"] = true,
        ["Argent Quartermaster Lightspark"] = true,
        ["Quartermaster Miranda Breechlock"] = true
    },
    additional_reputation_vendors = {
        ["Recipe: Transmute Earth to Water"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Friendly", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Formula: Enchant 2H Weapon - Agility"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Friendly", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Pattern: Warbear Harness"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Friendly", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Pattern: Warbear Woolies"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Friendly", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Formula: Enchant Weapon - Agility"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Honored", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Pattern: Might of the Timbermaw"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Honored", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Pattern: Wisdom of the Timbermaw"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Honored", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Plans: Heavy Timbermaw Belt"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Honored", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Pattern: Mantle of the Timbermaw"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Revered", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Pattern: Timbermaw Brawlers"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Revered", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Plans: Heavy Timbermaw Boots"] = {vendor = "Meilosh", faction = "Timbermaw Hold", rank = "Revered", reference = "wowhead.com/classic/guide/timbermaw-hold-reputation-wow-classic"},
        ["Recipe: Greater Dreamless Sleep"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Friendly", reference = "wowhead.com/classic/npc=14921/rinwosho-the-trader"},
        ["Schematic: Bloodvine Lens"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Friendly", reference = "wowhead.com/classic/npc=14921/rinwosho-the-trader"},
        ["Pattern: Blood Tiger Shoulders"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Honored", reference = "wowhead.com/classic/npc=14921/rinwosho-the-trader"},
        ["Pattern: Bloodvine Leggings"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Honored", reference = "wowhead.com/classic/npc=14921/rinwosho-the-trader"},
        ["Pattern: Primal Batskin Gloves"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Honored", reference = "wowhead.com/classic/npc=14921/rinwosho-the-trader"},
        ["Plans: Bloodsoul Shoulders"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Honored", reference = "wowhead.com/classic/npc=14921/rinwosho-the-trader"},
        ["Pattern: Blood Tiger Breastplate"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Revered", reference = "wowhead.com/classic/npc=14921/rinwosho-the-trader"},
        ["Plans: Darksoul Breastplate"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Revered", reference = "wowhead.com/classic/npc=14921/rinwosho-the-trader"},
        ["Recipe: Mageblood Potion"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Revered", reference = "wowhead.com/classic/npc=14921/rinwosho-the-trader"},
        ["Recipe: Living Action Potion"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Exalted", reference = "wowhead.com/classic/npc=14921/rinwosho-the-trader"},
        ["Pattern: Bloodvine Boots"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Friendly", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Pattern: Primal Batskin Bracers"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Friendly", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Plans: Bloodsoul Gauntlets"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Friendly", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Plans: Darksoul Shoulders"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Friendly", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Formula: Brilliant Mana Oil"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Friendly", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Plans: Darksoul Leggings"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Honored", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Schematic: Bloodvine Goggles"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Honored", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Recipe: Major Troll's Blood Potion"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Honored", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Formula: Brilliant Wizard Oil"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Honored", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Pattern: Bloodvine Vest"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Revered", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Pattern: Primal Batskin Jerkin"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Revered", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
        ["Plans: Bloodsoul Breastplate"] = {vendor = "Rin'wosho the Trader", faction = "Zandalar Tribe", rank = "Revered", reference = "wowhead.com/classic/guide/zandalar-tribe-reputation-wow-classic"},
    },
    -- In-game profession/reputation breakdown supplied for Master Craftsman Omarion.
    -- Separate from Wilhelm's handbook-gated crafting quests.
    omarion_recipes = {
        ["Glacial Wrists"] = {profession = "Tailoring", rank = "Revered"},
        ["Glacial Gloves"] = {profession = "Tailoring", rank = "Revered"},
        ["Glacial Vest"] = {profession = "Tailoring", rank = "Exalted"},
        ["Glacial Cloak"] = {profession = "Tailoring", rank = "Exalted"},
        ["Polar Bracers"] = {profession = "Leatherworking", rank = "Revered"},
        ["Polar Gloves"] = {profession = "Leatherworking", rank = "Revered"},
        ["Icy Scale Bracers"] = {profession = "Leatherworking", rank = "Revered"},
        ["Icy Scale Gauntlets"] = {profession = "Leatherworking", rank = "Revered"},
        ["Polar Tunic"] = {profession = "Leatherworking", rank = "Exalted"},
        ["Icy Scale Breastplate"] = {profession = "Leatherworking", rank = "Exalted"},
        ["Icebane Bracers"] = {profession = "Blacksmithing", rank = "Revered"},
        ["Icebane Gauntlets"] = {profession = "Blacksmithing", rank = "Revered"},
        ["Icebane Breastplate"] = {profession = "Blacksmithing", rank = "Exalted"},
    },
    -- Quest-reward plans: combine both book halves and hand in the tome at
    -- Lorekeeper Lydros, Athenaeum (Dire Maul). The completed book starts
    -- the turn-in quest, without a separate prerequisite quest chain or reputation unlock.
    -- User confirmed across all three volumes from prior in-game experience.
    enchanted_thorium_quests = {
        ["Enchanted Thorium Breastplate"] = {
            volume = "I", quest_id = 7649,
            first = "King Gordok - Dire Maul North",
            second = "Goraluk Anvilcrack - Lower Blackrock Spire"
        },
        ["Enchanted Thorium Leggings"] = {
            volume = "II", quest_id = 7650,
            first = "Rattlegore - Scholomance",
            second = "Crimson Hammersmith - Stratholme (live side)"
        },
        ["Enchanted Thorium Helm"] = {
            volume = "III", quest_id = 7651,
            first = "Urok Doomhowl - Lower Blackrock Spire",
            second = "Black Guard Swordsmith - Stratholme (undead side)"
        }
    },
    -- BRD direct-learning and quest-item acquisition, distinct from reputation stock.
    blackrock_quest_recipes = {
        ["Smelt Dark Iron"] = {
            profession = "Mining",
            kind = "direct",
            steps = {
                "Requires Mining 230. Enter Blackrock Depths, Summoners' Tomb (the Seven).",
                "Speak with Gloom'rel BEFORE starting Doom'rel's encounter.",
                "Accept The Spectral Chalice and offer 20 Gold Bars, 10 Truesilver Bars and 2 Star Rubies.",
                "Speak with Gloom'rel again to learn Smelt Dark Iron directly.",
                "Smelting requires the Black Forge in Blackrock Depths; 8 Dark Iron Ore make 1 bar."
            },
            reference = "wowhead.com/classic/guide/blackrock-depths-shadowforge-city-dungeon-strategy-wow-classic"
        },
        ["Sulfuron Hammer"] = {
            profession = "Blacksmithing",
            kind = "item",
            steps = {
                "Obtain 1 Sulfuron Ingot from Golemagg the Incinerator in Molten Core.",
                "Take the ingot to Lokhtos Darkbargainer in the Grim Guzzler, Blackrock Depths.",
                "Accept and complete A Binding Contract to receive Plans: Sulfuron Hammer.",
                "This is an ingot-triggered quest reward, not a Thorium Brotherhood reputation-stock unlock."
            },
            reference = "zockify.com/classic/dungeons/blackrock-depths/"
        }
    },
    -- In-world interactable schematic; not a dropped inventory recipe item.
    engineering_object_recipes = {
        ["Field Repair Bot 74A"] = {
            profession = "Engineering",
            object = "Schematic: Field Repair Bot 74A",
            steps = {
                "Enter Blackrock Depths and reach the Manufactory.",
                "Find the schematic on the floor near Golem Lord Argelmach.",
                "Read the schematic in place with Engineering 300 to learn Field Repair Bot 74A.",
                "This is an interactable world object, not loot from Argelmach or a vendor purchase."
            },
            reference = "warcraft.wiki.gg/wiki/Repair_Bot"
        }
    },
    -- Additional dungeon loot instructions. The base MTSL drop remains the
    -- source of truth for zone placement and the left-panel drop label.
    dungeon_drop_guidance = {
        ["Runn Tum Tuber Surprise"] = {
            profession = "Cooking",
            kind = "recipe",
            source = "Pusillin",
            dungeon = "Dire Maul East",
            item = "Recipe: Runn Tum Tuber Surprise",
            steps = {
                "Enter Dire Maul East; no Crescent Key is needed. Talk to Pusillin and follow him.",
                "Speak at each stop; defeat him when he turns hostile to loot the Bind-on-Pickup recipe.",
                "Learn it with Cooking 275. Find Runn Tum Tubers in Warpwood Pods in Dire Maul East."
            },
            reference = "wowhead.com/classic/spell=22761/runn-tum-tuber-surprise"
        },
        ["Goblin Jumper Cables XL"] = {
            profession = "Engineering",
            source = "Plugger Spazzring",
            dungeon = "Blackrock Depths",
            item = "Schematic: Goblin Jumper Cables XL",
            steps = {
                "Defeat Plugger Spazzring in the Grim Guzzler, Blackrock Depths.",
                "The schematic is a possible drop, not a guaranteed reward.",
                "Requires Engineering 265 and Goblin Engineering to learn the schematic."
            },
            reference = "wowhead.com/classic/item=18653/schematic-goblin-jumper-cables-xl"
        }
    },
    -- Dire Maul North tribute acquisition; alternate loot records may exist.
    tribute_recipes = {
        ["Major Recombobulator"] = {
            profession = "Engineering",
            item = "Schematic: Major Recombobulator",
            steps = {
                "Enter Dire Maul North in Feralas and complete a Gordok Tribute run.",
                "Keep the named Gordok guards alive to preserve the tribute reward.",
                "After defeating King Gordok, check the Gordok Tribute chest in Gordok Commons.",
                "The schematic is a possible tribute reward, not a guaranteed drop.",
                "Requires Engineering 275 to learn the schematic."
            },
            reference = "warcraft.wiki.gg/wiki/Schematic:Major_Recombobulator"
        }
    },
    -- The original Cooking 300 recipe is an item reward from the Scepter
    -- of the Shifting Sands (Blue Shard) business fork, not a trainer skill.
    epic_quest_recipes = {
        ["Dirge's Kickin' Chimaerok Chops"] = {
            profession = "Cooking",
            zone = "Tanaris",
            giver = "Dirge Quikcleave",
            item = "Recipe: Dirge's Kickin' Chimaerok Chops",
            quest_id = 8586,
            steps = {
                "Unlock the Blue Scepter Shard questline; finish Azuregos's Magical Ledger and Translating the Ledger with Narain Soothfancy.",
                "In Gadgetzan, talk to Dirge Quikcleave for Never Ask Me About My Business.",
                "Complete The Isle of Dread! in Feralas: defeat Lord Lakmaeran and gather 20 Chimaerok Tenderloins.",
                "Return to Dirge in Gadgetzan and complete Dirge's Kickin' Chimaerok Chops with 20 Goblin Rocket Fuel and 20 Deeprock Salt.",
                "The quest awards the recipe ITEM (not direct learning); use it with Cooking 300.",
                "The recipe item is tradeable, so acquiring it from another player may be an alternative."
            },
            reference = "wowhead.com/classic/quest=8586/dirges-kickin-chimaerok-chops"
        }
    },
    -- Silithus quest-granted Cooking skill; no inventory recipe item exists.
    direct_quest_recipes = {
        ["Smoked Desert Dumplings"] = {
            profession = "Cooking",
            zone = "Silithus",
            npc = "Calandrath",
            quest_id = 8313,
            steps = {
                "Requires Cooking 285 to learn the recipe; both factions follow the same quest route.",
                "At Cenarion Hold, accept Desert Recipe from Calandrath.",
                "Find the Sandy Cookbook at the Twilight's Hammer camp in Silithus and accept Sharing the Knowledge.",
                "Return the Torn Recipe Page to Calandrath at Cenarion Hold to complete Sharing the Knowledge.",
                "Completion teaches Smoked Desert Dumplings directly; there is no recipe item to use.",
                "Kitchen Assistance is a follow-up quest, not a prerequisite for learning the recipe."
            },
            reference = "wowhead.com/classic/quest=8313/sharing-the-knowledge"
        }
    },
    -- Vanilla 1.12: dialogue-only Cooking lesson in Razorfen Downs.
    dungeon_npc_lessons = {
        ["Goldthorn Tea"] = {
            profession = "Cooking",
            zone = "The Barrens",
            dungeon = "Razorfen Downs",
            npc = "Henry Stern",
            skill = 175,
            location = "Razorfen Downs (79.86, 10.74)",
            steps = {
                "Enter Razorfen Downs in the southern Barrens and head to the Murder Pens.",
                "Open the wooden barriers to free Henry Stern.",
                "With Cooking 175, speak to him to learn Goldthorn Tea directly for free."
            },
            reference = "wowhead.com/classic/spell=13028/goldthorn-tea"
        },
        ["Mighty Troll's Blood Potion"] = {
            profession = "Alchemy",
            zone = "The Barrens",
            dungeon = "Razorfen Downs",
            npc = "Henry Stern",
            skill = 180,
            steps = {
                "Enter Razorfen Downs from the southern Barrens and locate the Murder Pens.",
                "Open Henry Stern's holding pen and speak with him.",
                "At Alchemy 180, use Henry's alchemy dialogue to learn the potion directly for free.",
                "Alternatively, Recipe: Mighty Troll\'s Blood Potion can drop from level-appropriate enemies; that route is not specific to Razorfen Downs."
            },
            reference = "wowhead.com/classic/npc=8696/henry-stern"
        }
    },
    -- Original Vanilla Dire Maul North crafting training, available to two
    -- different professions after Knot Thimblejack's Ogre Suit quest.
    dungeon_crafting_unlocks = {
        ["Gordok Ogre Suit"] = {
            zone = "Feralas",
            dungeon = "Dire Maul North",
            npc = "Knot Thimblejack",
            skill = 275,
            professions = { Tailoring = true, Leatherworking = true },
            quest_id = 5518,
            steps = {
                "Find Knot Thimblejack captive in Dire Maul North, Gordok Commons.",
                "Before using a Gordok Shackle Key to free him, complete The Gordok Ogre Suit quest.",
                "Bring him 8 Rugged Leather, 4 Bolts of Runecloth, 2 Rune Thread and 1 Ogre Tannin.",
                "Find Ogre Tannin in a basket upstairs; looting it summons a Gordok Bushwacker.",
                "After turning in the suit quest, speak to Knot again with Tailoring or Leatherworking 275.",
                "Select his profession dialogue to learn the suit directly; no pattern item is required.",
                "The learned recipe uses half the leather, cloth and thread: 4 Leather, 2 Bolts, 1 Thread and 1 Tannin."
            },
            reference = "warcraft.wiki.gg/wiki/Gordok_Ogre_Suit"
        }
    },
    -- Knot Thimblejack's Cache is the optional loot from Free Knot!
    -- after supplying a Gordok Shackle Key. It is not Gordok Tribute.
    knot_cache_recipes = {
        ["Chromatic Cloak"] = "Leatherworking",
        ["Hide of the Wild"] = "Leatherworking",
        ["Shifting Cloak"] = "Leatherworking",
        ["Girdle of Insight"] = "Leatherworking",
        ["Mongoose Boots"] = "Leatherworking",
        ["Swift Flight Bracers"] = "Leatherworking",
        ["Belt of the Archmage"] = "Tailoring",
        ["Cloak of Warding"] = "Tailoring",
        ["Inferno Gloves"] = "Tailoring",
        ["Felcloth Gloves"] = "Tailoring",
        ["Mooncloth Gloves"] = "Tailoring"
    },
    knot_cache_access = {
        zone = "Feralas",
        dungeon = "Dire Maul North",
        source = "Knot Thimblejack's Cache",
        steps = {
            "In Dire Maul North, find captive Knot and obtain a Gordok Shackle Key from an ogre.",
            "Finish any Gordok Ogre Suit quest and crafting lesson BEFORE freeing Knot.",
            "Turn in Free Knot! with the key, then open Knot's Cache for a chance at this pattern.",
            "No pattern is guaranteed. Knot's Cache is NOT the Gordok Tribute chest."
        },
        reference = "warcraft.wiki.gg/wiki/Knot_Thimblejack's_Cache"
    },
    -- Original Vanilla Rogue-only Thistle Tea quest rewards. These routes
    -- are intentionally indexed in the objective zones, with the other
    -- faction's route kept visible as an alternative in acquisition details.
    rogue_thistle_tea = {
        profession = "Cooking",
        skill = 60,
        item = "Recipe: Thistle Tea",
        routes = {
            Alliance = {
                zone = "Duskwood",
                quest_id = 2359,
                title = "Klaven's Tower",
                steps = {
                    "Rogue level 20+: take Mathias and the Defias from Mathias Shaw in Stormwind.",
                    "Speak to Agent Kearnen in Westfall and accept Klaven's Tower.",
                    "Pick Pocket the Defias Tower Key from a Malformed Defias Drone.",
                    "Retrieve Klaven Mortwake's Journal from the Duskwood Chest in the tower.",
                    "Return to Mathias Shaw in Stormwind for Recipe: Thistle Tea; use it with Cooking 60."
                }
            },
            Horde = {
                zone = "The Barrens",
                quest_id = 2478,
                title = "Mission: Possible But Not Probable",
                steps = {
                    "Rogue level 20+: complete the Rogue poison quest introductions, including Deep Cover.",
                    "In the Sludge Fen, complete Mission: Possible But Not Probable for Taskmaster Fizzule.",
                    "Obtain Silixiz's Tower Key, Gallywix's Head and the cache of altered mixture.",
                    "Return to Shenthul in Orgrimmar for Recipe: Thistle Tea; use it with Cooking 60."
                }
            }
        },
        reference = "wowhead.com/classic/guide/rogue-class-quests-classic-wow"
    },
    -- Access notes describe reaching the source, not learning prerequisites.
    source_access = {
        ["Annora"] = {
            kind = "Trainer",
            status = "DOCUMENTED - INSTANCE ACCESS",
            steps = {
                "Enter Uldaman in Badlands and find Annora's scorpid room.",
                "Defeat all scorpids in her room to make Annora appear.",
                "You do not need to clear the entire dungeon to make her appear."
            },
            reference = "warcraft.wiki.gg/wiki/Annora"
        }
    },
    item_vendor_access = {
        ["Pattern: Mooncloth Robe"] = {
            ["Shen'dralar Provisioner"] = {
                status = "DOCUMENTED - INSTANCE ACCESS",
                steps = {
                    "Find the Shen'dralar Provisioner inside Dire Maul's Athenaeum (library), Feralas.",
                    "The pattern is a vendor purchase; no prerequisite quest is documented.",
                    "Reaching the library may require opening locked doors or taking another route.",
                    "Vendor stock may be limited; availability can vary."
                },
                reference = "wowhead.com/classic/npc=14371/shendralar-provisioner"
            }
        }
    },
    quest_conditions = {
        -- Quest IDs are used to distinguish Alliance and Horde versions with identical names.
        [2501] = {
            status = "IN-GAME VERIFIED - DIRECT RECIPE LEARNING",
            faction = "Alliance",
            steps = {
                "Start Badlands Reagent Run from Ghak Healtouch in Thelsamar, Loch Modan.",
                "After completing Badlands Reagent Run, both Uldaman Reagent Run and Badlands Reagent Run II become available.",
                "Uldaman Reagent Run is a separate follow-up, not a prerequisite for learning Restorative Potion.",
                "Accept Badlands Reagent Run II from Ghak Healtouch.",
                "In Badlands, use three provided vessels on Scorched Guardians to obtain 3 Vessels of Dragon's Blood.",
                "Return to Ghak Healtouch in Thelsamar to learn Restorative Potion.",
                "Quest completion directly teaches Restorative Potion (no recipe item to purchase).",
                "Alchemy 210 is required to craft the potion; verify quest eligibility in-game."
            },
            reference = "wowhead.com/classic/quest=2501/badlands-reagent-run-ii"
        },
        [2203] = {
            status = "DOCUMENTED - DIRECT RECIPE LEARNING",
            faction = "Horde",
            steps = {
                "Start Badlands Reagent Run from Jarkal Mossmeld in Kargath, Badlands.",
                "After completing Badlands Reagent Run, both Uldaman Reagent Run and Badlands Reagent Run II become available.",
                "Uldaman Reagent Run is a separate follow-up, not a prerequisite for learning Restorative Potion.",
                "Accept Badlands Reagent Run II from Jarkal Mossmeld.",
                "In Badlands, use three provided vessels on Scorched Guardians to obtain 3 Vessels of Dragon's Blood.",
                "Return to Jarkal Mossmeld in Kargath to learn Restorative Potion.",
                "Quest completion directly teaches Restorative Potion (no recipe item to purchase).",
                "Alchemy 210 is required to craft the potion; verify quest eligibility in-game."
            },
            reference = "classicdb.ch/?quest=2203"
        }
    }
}
