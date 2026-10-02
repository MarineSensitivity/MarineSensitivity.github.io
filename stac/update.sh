#!/usr/bin/env bash
# stac/update.sh — regenerate the alias of the STAC root catalog served at
# https://marinesensitivity.org/stac/catalog.json.
#
# The catalog itself is built by msens::stac_build() and lives at
# https://file.marinesensitivity.org/stac/ (one Collection tree per release). This site is a
# different origin (GitHub Pages), and the stac-sdm extension's examples name THIS address, so
# the root is published here too: the same Catalog, with every child link made absolute so a
# client that starts here walks straight into the canonical tree. Nothing else is copied, so
# nothing else can drift. Re-run after a release is added to the root catalog, then commit:
#   stac/update.sh && git add stac/catalog.json
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
SRC="${STAC_SRC:-https://file.marinesensitivity.org/stac}"
SELF="${STAC_SELF:-https://marinesensitivity.org/stac/catalog.json}"
curl -sf -m 60 "$SRC/catalog.json" | python3 -c '
import json, sys
src, self_url = sys.argv[1], sys.argv[2]
cat = json.load(sys.stdin)
assert cat.get("type") == "Catalog", "not a STAC Catalog"
links = []
for l in cat["links"]:
    h = l["href"]
    if l["rel"] in ("root", "self"):
        continue
    if not h.startswith("http"):
        h = src + "/" + h.lstrip("./")
    links.append({**l, "href": h, "type": l.get("type", "application/json")})
assert any(l["rel"] == "child" for l in links), "no child collections"
cat["links"] = [
    {"rel": "root", "href": self_url, "type": "application/json"},
    {"rel": "self", "href": self_url, "type": "application/json"},
    {"rel": "canonical", "href": src + "/catalog.json", "type": "application/json"},
    {"rel": "service-desc", "href": "https://stac-api.marinesensitivity.org/", "type": "application/json",
     "title": "searchable STAC API (one Item per model)"},
] + links
print(json.dumps(cat, indent=2))
' "$SRC" "$SELF" > "$here/catalog.json.tmp"
mv "$here/catalog.json.tmp" "$here/catalog.json"
echo "wrote $here/catalog.json: $(grep -c '"rel": "child"' "$here/catalog.json") child collections"
