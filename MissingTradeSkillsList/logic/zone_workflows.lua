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
