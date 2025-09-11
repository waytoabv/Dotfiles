#!/usr/bin/env bash
set -euo pipefail

# -------------------------------------
# Checks
# -------------------------------------
command -v brew >/dev/null 2>&1 || { echo "brew nicht gefunden"; exit 1; }
command -v jq   >/dev/null 2>&1 || { echo "jq nicht gefunden (brew install jq)"; exit 1; }

outdir="${1:-./brew-inventory}"
mkdir -p "$outdir"

# -------------------------------------
# Formeln sammeln
# -------------------------------------
echo "Sammle Formeln..."
brew info --installed --json=v2 --formula \
  | jq -r '
    def to_arr:
      if . == null then [] elif (type=="array") then . else [.] end;

    .formulae[]
    | {
        name: .name,
        version: (
          if (.installed | type) == "array" and (.installed | length) > 0
            then .installed[0].version
          else (.versions.stable // "")
          end
        ),
        deps_required: (.dependencies | to_arr),
        deps_recommended: (.recommended_dependencies | to_arr),
        deps_optional: (.optional_dependencies | to_arr),
        deps_build: (.build_dependencies | to_arr)
      }
    | [
        .name,
        .version,
        (.deps_required | join("|")),
        (.deps_recommended | join("|")),
        (.deps_optional | join("|")),
        (.deps_build | join("|"))
      ]
    | @csv
  ' > "$outdir/formula_deps.csv"

# -------------------------------------
# Reverse-Dependencies für Formeln
# -------------------------------------
echo "Berechne Reverse-Dependencies (Formeln)..."
brew info --installed --json=v2 --formula \
  | jq '
      def to_arr:
        if . == null then [] elif (type=="array") then . else [.] end;

      .formulae
      | map({
          name: .name,
          deps: ((.dependencies | to_arr)
                 + (.recommended_dependencies | to_arr)
                 + (.optional_dependencies | to_arr)
                 + (.build_dependencies | to_arr) | unique)
        }) as $list

      | $list
      | map(. as $f | {
          name: $f.name,
          used_by: ($list
                      | map(select(.name != $f.name))
                      | map(select(.deps | index($f.name)))
                      | map(.name)
                    )
        })
    ' > "$outdir/_formula_rev_tmp.json"

jq -r '
  map({name, used_by: (.used_by // [] | sort)})
  | map({name, used_by, is_leaf: ((.used_by | length) == 0)})
  | .[]
  | [ .name, (.used_by | join("|")), (if .is_leaf then "true" else "false" end) ]
  | @csv
' "$outdir/_formula_rev_tmp.json" > "$outdir/formula_reverse_deps.csv"
rm -f "$outdir/_formula_rev_tmp.json"

# Leaves
brew leaves --installed-on-request > "$outdir/formula_leaves_on_request.txt" 2>/dev/null || true
brew leaves > "$outdir/formula_leaves.txt" 2>/dev/null || true

# -------------------------------------
# Casks sammeln
# -------------------------------------
echo "Sammle Casks..."
brew info --installed --json=v2 --cask \
  | jq -r '
    def to_arr:
      if . == null then [] elif (type=="array") then . else [.] end;

    .casks[]
    | {
        name: (.token // .name),
        version: (
          if (.installed | type) == "array" then
            (.installed | map(tostring) | join("|"))
          elif (.installed == null) then ""
          else (.installed | tostring)
          end
        ),
        depends_formula: (.depends_on.formula | to_arr),
        depends_cask:    (.depends_on.cask    | to_arr)
      }
    | [
        .name,
        .version,
        (.depends_formula | join("|")),
        (.depends_cask | join("|"))
      ]
    | @csv
  ' > "$outdir/cask_deps.csv"

# -------------------------------------
# Übersicht
# -------------------------------------
echo
echo "Fertig. Dateien im Ordner: $outdir"
echo " - formula_deps.csv              name,version,required,recommended,optional,build"
echo " - formula_reverse_deps.csv      name,used_by,is_leaf"
echo " - formula_leaves.txt            Formeln ohne Abhängige"
echo " - formula_leaves_on_request.txt Explizit installierte Leaves (falls unterstützt)"
echo " - cask_deps.csv                 cask,version,formula_deps,cask_deps"
echo
echo "Tipps:"
echo " - Kandidaten: is_leaf=true und nicht in formula_leaves_on_request.txt"
echo " - Trockenlauf: brew uninstall --dry-run <paket>"
echo " - Autoremove:  brew autoremove"
echo " - Casks sauber entfernen: brew uninstall --cask --zap <cask>"

