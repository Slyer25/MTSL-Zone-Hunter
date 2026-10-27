-- Zone Hunter independent, editable condition database (Vanilla 1.12).
-- Only record a source-specific unlock as verified when documented or tested.
-- Comments are notes for researchers, not proof of universal game behavior.
MTSL_ZONE_WORKFLOWS = {
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
    thorium_brotherhood_reputation = {
        ["Recipe: Transmute Elemental Fire"] = "Friendly",
        ["Plans: Dark Iron Bracers"] = "Friendly",
        ["Formula: Enchant Weapon - Strength"] = "Friendly",
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
    vendor_conditions = {
        -- Magnus is visible after the Sarkhoff ghost-reveal chain; exact steps
        -- should be tested in Vanilla 1.12 before being considered verified.
        ["Plans: Ebon Shiv"] = {
            ["Magnus Frostwake"] = {
                status = "DOCUMENTED - QUEST GATED",
                steps = {
                    "Visit Eva Sarkhoff at Caer Darrow, Western Plaguelands.",
                    "Complete her Scholomance-related quest sequence to reveal the ghosts.",
                    "Once the ghosts are visible, find Magnus Frostwake near Scholomance.",
                    "Additional chain steps not individually verified in our 1.12 client."
                },
                reference = "wowhead.com/classic/guide/blacksmithing-vendor-recipes-wow-classic"
            }
        },
        ["Plans: Ornate Thorium Handaxe"] = {
            ["Magnus Frostwake"] = {
                status = "DOCUMENTED - QUEST GATED",
                steps = {"Complete Eva Sarkhoff's ghost-reveal quest sequence at Caer Darrow / Scholomance before shopping with Magnus.", "Full prerequisite chain not yet verified in-game."},
                reference = "wowhead.com/classic/guide/blacksmithing-vendor-recipes-wow-classic"
            }
        },
        ["Plans: Huge Thorium Battleaxe"] = {
            ["Magnus Frostwake"] = {
                status = "DOCUMENTED - QUEST GATED",
                steps = {"Complete Eva Sarkhoff's ghost-reveal quest sequence at Caer Darrow / Scholomance before shopping with Magnus.", "Full prerequisite chain not yet verified in-game."},
                reference = "wowhead.com/classic/guide/blacksmithing-vendor-recipes-wow-classic"
            }
        },
        ["Recipe: Transmute Water to Air"] = {
            ["Magnus Frostwake"] = {
                status = "DOCUMENTED - QUEST GATED",
                steps = {"Complete Eva Sarkhoff's ghost-reveal quest sequence before shopping with Magnus Frostwake near Scholomance.", "Full prerequisite chain not yet verified in-game."},
                reference = "wowhead.com/classic/guide/alchemy-vendor-recipes-wow-classic"
            }
        },
        ["Recipe: Major Mana Potion"] = {
            ["Magnus Frostwake"] = {
                status = "DOCUMENTED - QUEST GATED",
                steps = {"Complete Eva Sarkhoff's ghost-reveal quest sequence before shopping with Magnus Frostwake near Scholomance.", "Full prerequisite chain not yet verified in-game."},
                reference = "wowhead.com/classic/guide/alchemy-vendor-recipes-wow-classic"
            }
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
            status = "DOCUMENTED (Classic quest database and Uldaman guide)",
            faction = "Alliance",
            steps = {
                "Start Badlands Reagent Run from Ghak Healtouch in Thelsamar, Loch Modan.",
                "Complete Uldaman Reagent Run: collect 12 Magenta Fungus Caps in Uldaman; return to Ghak.",
                "Accept Badlands Reagent Run II from Ghak Healtouch.",
                "In Badlands, use three provided vessels on Scorched Guardians to obtain 3 Vessels of Dragon's Blood.",
                "Return to Ghak Healtouch in Thelsamar to learn Restorative Potion.",
                "The final quest may require Alchemy 210; verify the profession prerequisite in-game."
            },
            reference = "wowhead.com/classic/quest=2501/badlands-reagent-run-ii"
        },
        [2203] = {
            status = "DOCUMENTED (Classic quest database)",
            faction = "Horde",
            steps = {
                "Start Badlands Reagent Run from Jarkal Mossmeld in Kargath, Badlands.",
                "Complete Uldaman Reagent Run: collect 12 Magenta Fungus Caps in Uldaman; return to Jarkal.",
                "Accept Badlands Reagent Run II from Jarkal Mossmeld.",
                "In Badlands, use three provided vessels on Scorched Guardians to obtain 3 Vessels of Dragon's Blood.",
                "Return to Jarkal Mossmeld in Kargath to learn Restorative Potion.",
                "The final quest may require Alchemy 210; verify the profession prerequisite in-game."
            },
            reference = "classicdb.ch/?quest=2203"
        }
    }
}
