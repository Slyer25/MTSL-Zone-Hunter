# Zone Hunter changelog

Zone Hunter versions are separate from the base MissingTradeSkillsList 1.17.4 release. These are retrospective feature summaries; intermediate version snapshots are not part of the V5.1 source archive.

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
