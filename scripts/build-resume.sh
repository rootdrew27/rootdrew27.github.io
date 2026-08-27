#!/usr/bin/env bash
# Compile the LaTeX resumes in assets/ to PDF with Tectonic.
#
# Each assets/Resume___*/ directory is a self-contained variant: resume.tex pulls
# in sections/*.tex via \import, so the compile has to run with that directory as
# the working directory. Tectonic writes resume.pdf beside the source.
#
#   ./scripts/build-resume.sh                 # build every variant
#   ./scripts/build-resume.sh cekura          # build variants matching "cekura"
#   ./scripts/build-resume.sh --publish       # build all, copy the published variant to public/
#   ./scripts/build-resume.sh blue --open     # build and open the PDF
#   ./scripts/build-resume.sh cekura --watch  # rebuild on every save

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ASSETS="$ROOT/assets"

# The variant the website serves, and where it lands. Keep PUBLISH_DEST in sync
# with pdfPath in src/content/resume/andrew-root.yaml.
#
# The published variant is the ZIPLINE one as of 2026-08-26 (Andrew's call), and
# was the FDE one before that. Despite the name it is not narrowly Zipline-
# specific: its summary names no company, its skills rows are general, and its
# Daentra bullets are the most current and most technical set of any variant
# (the insurance-claims inference pipeline and the 1200p/55fps edge
# optimization appear on no other page). It also has two claims removed that
# Andrew judged overstated or not worth the space, so it is the most honest
# version as well as the strongest.
PUBLISH_VARIANT="Resume___Andrew_Root___Zipline"
PUBLISH_DEST="$ROOT/public/andrew-root-resume.pdf"

TECTONIC="${TECTONIC:-$(command -v tectonic || echo "$HOME/.local/bin/tectonic")}"

lower() { printf '%s' "$1" | tr '[:upper:]' '[:lower:]'; }

publish=false
open_pdf=false
watch=false
patterns=()

for arg in "$@"; do
  case "$arg" in
    --publish) publish=true ;;
    --open)    open_pdf=true ;;
    --watch)   watch=true ;;
    --all)     patterns=() ;;
    -h|--help) sed -n '2,13p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*)        echo "unknown flag: $arg" >&2; exit 2 ;;
    *)         patterns+=("$arg") ;;
  esac
done

if [[ ! -x "$TECTONIC" ]]; then
  echo "tectonic not found (looked for '$TECTONIC')." >&2
  echo "Install it with: curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh" >&2
  exit 1
fi

# Resolve the variant directories to build. With no patterns, that's all of them;
# otherwise every directory whose name case-insensitively contains a pattern.
variants=()
while IFS= read -r dir; do
  [[ -f "$dir/resume.tex" ]] || continue
  if [[ ${#patterns[@]} -eq 0 ]]; then
    variants+=("$dir")
  else
    name="$(lower "$(basename "$dir")")"
    for p in "${patterns[@]}"; do
      if [[ "$name" == *"$(lower "$p")"* ]]; then variants+=("$dir"); break; fi
    done
  fi
done < <(find "$ASSETS" -mindepth 1 -maxdepth 1 -type d | sort)

if [[ ${#variants[@]} -eq 0 ]]; then
  echo "no resume variants matched: ${patterns[*]-}" >&2
  echo "available:" >&2
  find "$ASSETS" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort | sed 's/^/  /' >&2
  exit 1
fi

build_one() {
  local dir="$1" name out pages overfull
  name="$(basename "$dir")"

  # Tectonic is chatty: package downloads, rerun notices, and box warnings all go
  # to stderr even on a clean build. Capture everything, print our own one-line
  # summary on success, and dump the raw log only when the compile actually fails.
  if ! out="$(cd "$dir" && "$TECTONIC" resume.tex 2>&1)"; then
    echo "  ✗ $name failed:" >&2
    echo "$out" | sed 's/^/      /' >&2
    return 1
  fi

  pages="$(python3 "$ROOT/scripts/pdfpages.py" "$dir/resume.pdf" 2>/dev/null || echo '?')"

  # Overfull boxes mean text is running past the margin, so they are worth seeing.
  overfull="$(echo "$out" | grep -c 'Overfull' || true)"
  if [[ "$overfull" -gt 0 ]]; then
    # The same warnings repeat once per TeX pass; report the distinct sources.
    local srcs
    srcs="$(echo "$out" | grep 'Overfull' | sed -E 's/^warning: ([^:]+:[0-9]+).*/\1/' | sort -u | tr '\n' ' ')"
    echo "  ✓ $name → resume.pdf (${pages}p, overfull: $srcs)"
  else
    echo "  ✓ $name → resume.pdf (${pages}p)"
  fi
}

build_all() {
  echo "Building ${#variants[@]} variant(s) with $("$TECTONIC" --version)"
  local rc=0
  for dir in "${variants[@]}"; do build_one "$dir" || rc=1; done

  if $publish; then
    local src="$ASSETS/$PUBLISH_VARIANT/resume.pdf"
    if [[ -f "$src" ]]; then
      cp "$src" "$PUBLISH_DEST"
      echo "  → published $PUBLISH_VARIANT to ${PUBLISH_DEST#$ROOT/}"
    else
      echo "  ✗ cannot publish: $PUBLISH_VARIANT was not built" >&2
      rc=1
    fi
  fi
  return $rc
}

if ! $watch; then
  build_all
  if $open_pdf; then
    for dir in "${variants[@]}"; do open "$dir/resume.pdf"; done
  fi
  exit 0
fi

# Watch mode: poll the .tex sources for changes. Polling rather than fswatch so
# the script has no dependency beyond tectonic itself.
echo "Watching ${#variants[@]} variant(s) for changes. Ctrl-C to stop."
build_all || true
$open_pdf && for dir in "${variants[@]}"; do open "$dir/resume.pdf"; done
prev=""
while true; do
  curr="$(find "${variants[@]}" -name '*.tex' -o -name '*.cls' | sort | xargs stat -f '%m %N' 2>/dev/null)"
  if [[ -n "$prev" && "$curr" != "$prev" ]]; then
    echo "--- change detected $(date '+%H:%M:%S') ---"
    build_all || true
  fi
  prev="$curr"
  sleep 1
done
