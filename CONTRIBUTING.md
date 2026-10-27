# Contributing recipe corrections

Report the **recipe**, **zone**, **source NPC/vendor/quest**, expected behavior, observed behavior, and whether the information is **verified in-game**, **documented in a reference**, or **unverified/inferred**.

Include faction, profession skill, specialization, reputation, prerequisite quest, stock and vendor-unlock requirements when relevant. Screenshot or Vanilla-compatible reference links are useful.

Prefer keeping custom corrections and acquisition steps in `MissingTradeSkillsList/logic/zone_workflows.lua`, separate from upstream TradeSkillsData. Match conditions narrowly by recipe/source ID to prevent overgeneralization.

Before releasing, test WoW 1.12 compatibility, zone navigation, learned filtering, class restrictions, requirements, text wrapping and pagination. Update the changelog and retain original attribution.
