#!/bin/bash
# Replace GitHub Pages URLs with Unbounce CDN URLs in all unbounce files.
#
# Usage:
#   1. Upload each asset to Unbounce (see README)
#   2. Fill in the Unbounce CDN URLs below
#   3. Run: bash replace-urls.sh

# === PASTE YOUR UNBOUNCE CDN URLs HERE ===
LOGO_URL=""
AERIAL_URL=""
TENNIS_TEXTURE_URL=""
VIDEO_MP4_URL=""
BRITANNIA_LOGO_URL=""
# ==========================================

FILES="unbounce-html.html unbounce-css.html"

replace() {
  local old="$1" new="$2"
  if [ -z "$new" ]; then
    echo "SKIPPED (no URL provided): $old"
    return
  fi
  for f in $FILES; do
    sed -i '' "s|${old}|${new}|g" "$f"
  done
  echo "REPLACED: $old -> $new"
}

replace "https://pnz1990.github.io/britannia-skateboard/logo.png" "$LOGO_URL"
replace "https://pnz1990.github.io/britannia-skateboard/aerial.jpg" "$AERIAL_URL"
replace "https://pnz1990.github.io/britannia-skateboard/tennis-texture.jpeg" "$TENNIS_TEXTURE_URL"
replace "https://pnz1990.github.io/britannia-skateboard/videoplayback.mp4" "$VIDEO_MP4_URL"
replace "https://www.britanniacentre.org/database/images/layouts/britannia_logo(1).png" "$BRITANNIA_LOGO_URL"

echo ""
echo "Done! Re-paste the updated files into Unbounce."
