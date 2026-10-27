# Zone Hunter for MissingTradeSkillsList (Vanilla 1.12)

A zone-first recipe-hunting extension for **MissingTradeSkillsList**, maintained as a community modification. Browse recipes available or potentially farmable in the selected zone, across professions, and inspect their acquisition methods.

**Current tested build: V5.3 (2026-10-27).** The original addon still reports version 1.17.4 in its TOC; Zone Hunter uses separate version numbering.

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
- Prerequisite quest chains are incomplete unless explicitly verified.
- The current build was manually tested in-game, but no automated WoW 1.12 tests exist.

## Upstream credits
Derived from **MissingTradeSkillsList** by Thumbkin and the Vanilla port by Refaim. Preserve the upstream `MissingTradeSkillsList/README.md` and `VERSION_HISTORY.md` credit files. This is an independent modification.

See [CHANGELOG.md](CHANGELOG.md) and [CONTRIBUTING.md](CONTRIBUTING.md).

## Downloading and packaging

**For players:** use a ZIP from [GitHub Releases](https://github.com/Slyer25/MTSL-Zone-Hunter/releases) when available. Its only top-level folder is `MissingTradeSkillsList/`. Extract it directly to `Interface/AddOns/`.

**Current development builds:** on GitHub, open **Actions → Package Zone Hunter addon**, choose the latest successful run and download the `Zone-Hunter-install-ready` artifact. GitHub may wrap the artifact in a download ZIP; open that outer archive to find the install-ready `MTSL-Zone-Hunter-<version>.zip`. For release tags (`v*`), the workflow also attaches the install-ready ZIP to a GitHub Release.

**Maintainers:** locally run `python3 scripts/package.py`; the resulting `dist/MTSL-Zone-Hunter-<version>.zip` is ready to extract into the WoW addons directory. Do not install the entire repository downloaded via **Code → Download ZIP**; that source archive includes an extra repository directory and development files.
