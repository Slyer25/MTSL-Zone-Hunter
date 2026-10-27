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
    -- Add conditional vendors only when source, exact item, and gating criteria are validated.
    -- Keys should use the exact recipe item name and vendor NPC name, never just a zone.
    vendor_conditions = {
        -- ["Recipe: Example"] = { ["Vendor Name"] = { status="DOCUMENTED", steps={"..."} } }
    },
    quest_conditions = {
        -- ["Badlands Reagent Run II"] = { status="DOCUMENTED", steps={"..."} }
    }
}
