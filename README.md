# Zone Hunter for MissingTradeSkillsList (Vanilla 1.12)

A zone-first recipe-hunting extension for **MissingTradeSkillsList**, maintained as a community modification. Browse recipes available or potentially farmable in the selected zone, across professions, and inspect their acquisition methods.

**Current tested build: V5.8.6 (2026-10-28).** The original addon still reports version 1.17.4 in its TOC; Zone Hunter uses separate version numbering.

## Installation
1. Install the compatible **TradeSkillsData** dependency. This project targets official-style Vanilla WoW 1.12 (no Turtle-specific recipes).
2. Back up `Interface/AddOns/MissingTradeSkillsList`.
3. Copy the `MissingTradeSkillsList` addon directory into `Interface/AddOns/`.
4. Enter **`/mtsl zone`** in game. The regular MTSL interface remains available.

## Features
- Cross-profession recipe checklist organized **by zone** with local acquisition sources.
- Clickable recipes with details for vendors, trainers, quests, mobs, objects, and recorded coordinates.
- Approximate world-drop matches based on mob/zone-level overlap (**not confirmed mob drops**).
- Learned status, class eligibility, skill-level warnings, specialization locks.
- Sources in the selected zone prioritized, with local quest NPCs marked `[HERE]`.
- Documented specialization workflows for Leatherworking, Blacksmithing (including master branches), and Engineering; long instruction wrapping and detail pagination.
- Separate `logic/zone_workflows.lua` correction and workflow data layer.

## Limitations
- Vendor offerings may require quests, reputation, or other conditions not yet documented.
- Specialization workflow steps are documented but not yet tested in-game; some introductory prerequisites remain incomplete.
- Added a documented Alliance/Horde Restorative Potion quest chain, keyed to quest IDs. Other prerequisite quest chains remain incomplete unless explicitly verified.
- The current build was manually tested in-game, but no automated WoW 1.12 tests exist.

## Upstream credits
Derived from **MissingTradeSkillsList** by Thumbkin and the Vanilla port by Refaim. Preserve the upstream `MissingTradeSkillsList/README.md` and `VERSION_HISTORY.md` credit files. This is an independent modification.

See [CHANGELOG.md](CHANGELOG.md) and [CONTRIBUTING.md](CONTRIBUTING.md).

## Downloading and packaging

**For players:** use a ZIP from [GitHub Releases](https://github.com/Slyer25/MTSL-Zone-Hunter/releases) when available. Its only top-level folder is `MissingTradeSkillsList/`. Extract it directly to `Interface/AddOns/`.

**Current development builds:** on GitHub, open **Actions → Package Zone Hunter addon**, choose the latest successful run and download the `Zone-Hunter-install-ready` artifact. GitHub may wrap the artifact in a download ZIP; open that outer archive to find the install-ready `MTSL-Zone-Hunter-<version>.zip`. For release tags (`v*`), the workflow also attaches the install-ready ZIP to a GitHub Release.

**Maintainers:** locally run `python3 scripts/package.py`; the resulting `dist/MTSL-Zone-Hunter-<version>.zip` is ready to extract into the WoW addons directory. Do not install the entire repository downloaded via **Code → Download ZIP**; that source archive includes an extra repository directory and development files.

### Release publishing

Publishing a GitHub Release triggers the packaging workflow, which attaches an **install-ready** `MTSL-Zone-Hunter-*.zip` and uses the matching `CHANGELOG.md` section as release notes. GitHub also displays unavoidable automatic **Source code (zip/tar.gz)** entries; those are repository snapshots, **not** addon installers.

To repair the existing `5.4` release: open **Actions → Package Zone Hunter addon → Run workflow**, choose branch `main`, enter `5.4` in **release_tag**, and run. This packages the current `main` source and attaches the result to that existing release. Use the repair option only when main still matches the version being repaired.

**Saved recipe tracking:** WoW 1.12 cannot reliably inspect unopened profession recipe books. Open each profession once to initialize or update known skills; subsequent sessions should load preserved SavedVariables. V5.4.1 prevents two early Lua assignments from clearing MTSL_PLAYERS. Back up `WTF/Account/<account>/SavedVariables/MissingTradeSkillsList.lua` before updating; already overwritten records cannot be reconstructed without rescanning.

**V5.4.2 login fix:** removed destructive profession-unlearn reconciliation from `PLAYER_LOGIN` because WoW's skill lines may not be initialized then. Cached learned recipes should survive relogging once scanned; test with a normal logout/login. The V5.4.1 initialization guard alone did not resolve this issue.

**V5.5 acquisition improvements:** documented Thorium Brotherhood vendor recipe reputation thresholds are shown in acquisition details only when the matching recipe item is sold by Lokhtos Darkbargainer. Reputation is not read live and the data must still be checked against our target Vanilla 1.12 client. Other vendor prerequisites remain unverified.

**V5.5.1 navigation:** the next/previous zone controls skip zones with no recipes matching the learned toggle. Blackrock Depths acquisition sources are grouped into Blackrock Mountain; the details panel still shows the actual dungeon location. These updates are not yet verified in-game.

**V5.6 dungeon coverage:** dungeon-only sources are grouped beneath their surrounding outdoor zones (e.g. Dire Maul → Feralas, Uldaman → Badlands), while retaining the instance location in details. Magnus Frostwake vendor recipes now include documented quest-gating notes. Dungeon and vendor additions still require testing against the installed 1.12 data.

**V5.6.1:** added source access notes for Annora (Uldaman scorpids) and Shen'dralar Provisioner (Dire Maul Athenaeum). These explain reaching NPCs, not extra recipe-learning restrictions. Unverified source behavior is not presented as tested.

**V5.7:** added documented Cenarion Circle and Argent Dawn recipe-specific vendor reputation requirements. The display checks both recipe and vendor, without requiring live reputation tracking. Acquisition instructions are documented, not yet tested in-game.

**V5.8:** expands reputation recipes for Timbermaw Hold and Zandalar Tribe and automatically hides the Details navigation when a recipe fits one page. Unverified in game.

**Database quality checks:** `python3 scripts/audit_reputation.py` validates researched Meilosh, Rin'wosho and Cenarion Circle and Thorium Brotherhood vendor recipe coverage against independent Classic vendor lists. GitHub Actions runs this audit before packaging releases. This does not validate every other vendor or confirm behavior on custom servers.
