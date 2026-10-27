#!/usr/bin/env python3
"""Extract the current version's notes from CHANGELOG.md for GitHub Releases."""
from pathlib import Path
import re
import sys

root = Path(__file__).resolve().parents[1]
changelog = (root / "CHANGELOG.md").read_text(encoding="utf-8")
toc = (root / "MissingTradeSkillsList" / "MissingTradeSkillsList.toc").read_text(encoding="utf-8-sig")
match = re.search(r"^## Version:\s*1\.17\.4-ZH(\d+(?:\.\d+)+)\s*$", toc, re.M)
if not match:
    sys.exit("Unable to find Zone Hunter version in TOC")
version = match.group(1)
pattern = r"(?ms)^## V" + re.escape(version) + r"\s*[^\n]*\n(.*?)(?=^## V|\Z)"
section = re.search(pattern, changelog)
if not section:
    sys.exit("No changelog section for V" + version)
notes = ("## Zone Hunter V" + version + "\n\n"
         "Download the **MTSL-Zone-Hunter-1.17.4-ZH" + version + ".zip** release asset below. "
         "Do **not** choose GitHub's automatic Source code ZIP: that contains the development repository and extra directories.\n\n"
         "### Changes\n" + section.group(1).strip() + "\n\n"
         "Requires TradeSkillsData for Vanilla WoW 1.12. Extract the archive directly into Interface/AddOns/.\n")
out = root / "dist" / "release-notes.md"
out.parent.mkdir(exist_ok=True)
out.write_text(notes, encoding="utf-8")
print(out)
