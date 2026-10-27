#!/usr/bin/env python3
"""Build an install-ready WoW 1.12 addon ZIP from the repository."""
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
import re
import sys

root = Path(__file__).resolve().parents[1]
addon = root / "MissingTradeSkillsList"
toc = addon / "MissingTradeSkillsList.toc"
if not toc.is_file():
    sys.exit("Missing addon .toc at MissingTradeSkillsList/MissingTradeSkillsList.toc")

content = toc.read_text(encoding="utf-8-sig")
match = re.search(r"^## Version:\s*(.+)$", content, re.MULTILINE)
version = match.group(1).strip() if match else "unknown"
dist = root / "dist"
dist.mkdir(exist_ok=True)
output = dist / ("MTSL-Zone-Hunter-" + version + ".zip")

# Exclude development screenshots, notes, and OS junk from the game install.
with ZipFile(output, "w", ZIP_DEFLATED, compresslevel=9) as zf:
    for path in sorted(addon.rglob("*")):
        if not path.is_file():
            continue
        relative = path.relative_to(addon)
        if "screenshots" in relative.parts or path.name in {".DS_Store", "Thumbs.db"}:
            continue
        if path.name.startswith("ZONE_HUNTER_") and path.suffix == ".txt":
            continue
        zf.write(path, (Path("MissingTradeSkillsList") / relative).as_posix())

with ZipFile(output) as check:
    bad = check.testzip()
    if bad:
        sys.exit("Invalid ZIP entry: " + bad)
    names = check.namelist()
    assert "MissingTradeSkillsList/MissingTradeSkillsList.toc" in names
print(output)
