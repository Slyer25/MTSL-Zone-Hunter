# Zone Hunter changelog

Zone Hunter versions are separate from the base MissingTradeSkillsList 1.17.4 release. These are retrospective feature summaries; intermediate version snapshots are not part of the V5.1 source archive.

## V5.8.5 — 2026-10-28
- Audited all 28 Lokhtos Darkbargainer reputation-gated vendor stock recipes against direct in-game inventory observations.
- Corrected Formula: Enchant Weapon - Strength from Friendly to Honored.
- Removed unconfirmed Recipe: Transmute Elemental Fire from Lokhtos reputation stock data; investigate its source separately.
- Clarified Thorium Brotherhood unlocks gate vendor inventory visibility, not the recipe items themselves.
- Extended CI reputation audit from 56 to 84 records, preserving existing packaging/release workflow.

## V5.8.4 — 2026-10-28
- Extended automated reputation-vendor audit to all 23 current Cenarion Circle recipe records for Vargus, Kania, Mishta and Aendel Windspear, including Dreamscale Breastplate (Exalted).
- Audit now checks 56 recipe records across Cenarion Circle, Timbermaw Hold and Zandalar Tribe for missing entries, duplicate keys and incorrect tiers.
- Cenarion Circle thresholds are based on user-provided in-game vendor tooltip evidence; additional vendor inventory changes will require updating the audit expectations.
- No addon UI or acquisition display logic changed; Thorium Brotherhood audit remains pending a separate vendor review.

## V5.8.3 — 2026-10-28
- Added Pattern: Dreamscale Breastplate from Aendel Windspear at Cenarion Circle Exalted, confirmed by in-game vendor screenshot and Classic item data.
- Preserved Dragonscale Leatherworking specialization requirement in original MTSL recipe data.
- Audited user-provided screenshots for Vargus, Kania, Mishta and Aendel Windspear; displayed thresholds for pictured existing records agree with the Cenarion Circle database.
- No UI changes; some other Cenarion recipes still require full inventory comparison.

## V5.8.2 — 2026-10-28
- Added a reproducible static audit for all 11 Meilosh and 22 Rin'wosho reputation recipes, based on independently published Classic vendor inventories.
- Added the audit to GitHub Actions before packaging; omissions, duplicate entries and wrong reputation tiers now fail the build.
- Kept the tested UI, quest workflows, source data and learned-recipe tracking unchanged.
- This is a database-quality release, not a claim of full coverage for other reputation vendors.

## V5.8.1 — 2026-10-28
- Filled missing Rin'wosho the Trader reputation requirements from original Vanilla vendor reward lists.
- Added Greater Dreamless Sleep (Friendly), Bloodvine Lens (Friendly), Blood Tiger Shoulders, Bloodvine Leggings, Primal Batskin Gloves and Bloodsoul Shoulders (Honored), Blood Tiger Breastplate, Darksoul Breastplate and Mageblood Potion (Revered), and Living Action Potion (Exalted).
- Retained exact recipe/vendor matching and added Classic vendor reference links; no UI changes.
- Pending in-game verification of the new entries.

## V5.8 — 2026-10-28
- Hid Details previous/next buttons and page counter for recipes with only one details page; restored them automatically for multi-page records.
- Added documented Timbermaw Hold reputation requirements for Meilosh's profession recipes.
- Added documented Zandalar Tribe reputation requirements for Rin'wosho the Trader's profession recipes.
- Applied conditions only where recipe item and vendor names match, with source references retained.
- Data and UI changes need in-game testing in the Vanilla 1.12 client.

## V5.7.3 — 2026-10-28
- Added six more Argent Dawn recipe reputation requirements, confirmed by in-game quartermaster tooltips: Transmute Air to Fire, Dawn Treaders, Golden Mantle of the Dawn, Powerful Anti-Venom, Enchant Bracer - Mana Regeneration, and Enchant Bracer - Healing.
- Removed the redundant unverified wording for Argent Dawn reputation requirements directly checked in-game.
- Removed the global drop-chance disclaimer from acquisition details; estimated world drops retain their contextual uncertainty notes.
- Removed a trailing blank line to prevent an almost-empty detail page for vendor-only recipes.
- The new reputation entries still depend on exact recipe item names matching TradeSkillsData.

## V5.7.2 — 2026-10-28
- Removed the long Argent Dawn guide URL from the in-game detail lines to prevent a reference-only second page.
- Preserved the reference in the supplemental workflow database for traceability.
- Vendor names, reputation instructions, and acquisition logic remain unchanged.

## V5.7.1 — 2026-10-28
- Fixed repeated Argent Dawn reputation requirements when the same recipe is sold by several quartermasters.
- Deduplicated identical reputation requirements for Cenarion Circle and Thorium Brotherhood as a preventive measure.
- Preserved all vendor names and locations; this change only affects the acquisition details text.
- Pending in-game confirmation.

## V5.7 — 2026-10-28
- Expanded recipe-specific reputation vendor data for Cenarion Circle in Silithus: Vargus, Kania, Aendel Windspear and Mishta, including Friendly/Honored/Revered tiers.
- Added Argent Dawn reputation requirements for Girdle of the Dawn, Gloves of the Dawn, Argent Boots and Argent Shoulders at their quartermasters.
- Requires an exact recipe item and named vendor match: no blanket reputation locks on unrelated recipes or vendors.
- Requirements are sourced from Classic guides and not yet verified in our Vanilla 1.12 client.
- Preserved interface, dungeon mapping, saved character tracking and automated release ZIP packaging.

## V5.6.1 — 2026-10-27
- Added source-access instructions for Annora in Uldaman (clear scorpids in her room) under Badlands.
- Added Dire Maul Athenaeum access notes for Pattern: Mooncloth Robe, without mislabeling it as quest-gated.
- Added source-specific access rendering alongside trainers and vendors, retaining source references and explicitly separating access from learning requirements.
- Both records are documented but not yet tested in the Vanilla 1.12 client.

## V5.6 — 2026-10-27
- Group recorded dungeon NPC and object sources under their outdoor zones, including Dire Maul to Feralas and Uldaman to Badlands; preserve dungeon names in details.
- Additional mapping for Scholomance, Stratholme, and other Vanilla dungeons based on zone names.
- Added documented quest-gated purchase notes for Magnus Frostwake's blacksmithing and alchemy recipes at Scholomance; full prerequisite chain still requires in-game verification.
- Vendor acquisition details now render external reference text where supplied.
- No automatic completion checks; dungeon mapping depends on exact zone names in TradeSkillsData and needs in-game testing.

## V5.5.3 — 2026-10-27
- Moved specialization unlocking workflows after trainer, vendor, quest and drop acquisition sources in the details panel.
- Confirmed unlock steps only display when the specialization is not recorded as learned; learned specializations now show a compact confirmation.
- Left recipe list and other acquisition data unchanged.

## V5.5.2 — 2026-10-27
- Moved the selected-zone label to the top of acquisition details, ahead of profession and skill requirements, so it appears on the first details page.
- Removed the duplicate zone label from the end of the details.

## V5.5.1 — 2026-10-27
- Zone navigation now skips zones with no recipes in the active missing/all display mode.
- When showing learned recipes, completed zones reappear; zones without any recipes remain hidden.
- Clicking Current zone while in an empty zone navigates to the next zone containing matching recipes.
- Group NPC, vendor, mob and object sources recorded in Blackrock Depths under Blackrock Mountain while preserving their dungeon location in details.
- In-game verification is required for Blackrock Depths source mapping and navigation.

## V5.5 — 2026-10-27
- Added source-specific reputation requirements for documented Thorium Brotherhood recipes sold by Lokhtos Darkbargainer.
- Display requirement and reputation acquisition route within the existing acquisition details panel.
- Improved vendor condition rendering to avoid losing conditions when other vendors on the same item lack records.
- Unverified vendor unlocks remain clearly identified, and recipe availability remains visible regardless of reputation.
- No automatic quest completion or reputation detection; manual acquisition verification pending.

## V5.4.2 — 2026-10-27
- Fixed startup deletion of saved primary professions: `LoadPlayer()` no longer calls `RemoveUnlearnedProfessions()` before the skill lines are ready.
- Added a safeguard against running profession removal on an empty skill-line snapshot.
- The V5.4.1 initializer fix was insufficient; this revision addresses the observed relogging symptom more directly.
- Needs in-game relog testing; previously lost cache data must be refreshed once by opening profession windows.

## V5.4.1 — 2026-10-27
- Fixed two unconditional `MTSL_PLAYERS = {}` initializers in the original addon code so existing SavedVariables are preserved.
- Does not automatically scan unopened professions; open each profession once to populate learned recipes, then verify persistence after relogging.
- This release requires in-game validation.

## V5.4 — 2026-10-27
- Added faction-specific, documented Restorative Potion prerequisite quest chains (IDs 2501 and 2203).
- Changed quest-workflow lookup to prefer quest ID over shared localized quest names.
- Show workflow reference links as plain text in acquisition details.
- Conditional vendor prerequisites remain unverified and will be added only with source-specific evidence.

## V5.3 — 2026-10-27
- Fixed Engineering workflow name mismatch (Gnomish Engineer / Goblin Engineer vs Engineering).
- Added cautiously documented Master Axesmith, Master Hammersmith and Master Swordsmith paths, with explicit Vanilla 1.12 verification warnings.
- Matched workflow lookups using a separate alias table.

## V5.2 — 2026-10-27
- Updated the addon TOC version to `1.17.4-ZH5.2`.
- Added documented acquisition steps for Armorsmith, Weaponsmith, Elemental Leatherworking, Dragonscale Leatherworking, Gnomish Engineering and Goblin Engineering.
- Marked unverified/possibly incomplete introductory quest steps explicitly; excluded Season of Discovery-only quests.
- Vendor-specific unlock data still needs independent verification.

## V5.1 — 2026-10-27
- Wrapped long acquisition workflow text in the details panel.
- Paginated based on the resulting visible display lines.

## V5 — 2026-10-27
- Added an initial Tribal Leatherworking acquisition workflow.
- Introduced `logic/zone_workflows.lua` for corrections and source gating.
- Explicit uncertainty notes for incomplete prerequisite chains.

## V4 — 2026-10-27
- Class-eligibility filtering (including hiding Rogue poisons on non-Rogues).
- Profession skill requirements and specialization locks.
- Local source ordering and `[HERE]` markers.
- Caryssia Moonhunter zone correction to Feralas.
- Improved tooltip positioning.

## V3 — 2026-10-27
- Restored compact local acquisition source beneath recipe names on the left.

## V2 — 2026-10-27
- Introduced split-pane recipe list/acquisition details.
- Added source location, quest and recorded mob details.
- Visually distinguished learned and missing recipes.

## V1 — 2026-10-27
- First cross-profession zone browser at `/mtsl zone`.
- Zone navigation, missing/learned toggle, pagination.
- World-drop estimates via mob-level range overlap.

## Original addon
Original MissingTradeSkillsList history and attribution remain in its distribution.
