#!/usr/bin/env bash
# Copy AnaOS meta overlays into a synced AOSP tree (post TASK_018 sync).
# Usage: ./scripts/overlay-anaos-into-aosp.sh /opt/anaos/aosp [/path/to/AnaOS-meta]
set -euo pipefail
AOSP="${1:?AOSP tree root}"
META="${2:-$(cd "$(dirname "$0")/.." && pwd)}"

test -d "$AOSP/build" || { echo "Not an AOSP tree: $AOSP" >&2; exit 1; }
test -d "$META/device/anaos" || { echo "Missing device/anaos in $META" >&2; exit 1; }

mkdir -p "$AOSP/device/anaos" "$AOSP/branding"
rsync -a --delete "$META/device/anaos/" "$AOSP/device/anaos/"
if [[ -d "$META/branding" ]]; then
  rsync -a --delete "$META/branding/" "$AOSP/branding/"
fi

echo "Overlaid device/anaos and branding into $AOSP"
echo "Next: source build/envsetup.sh && lunch anaos_emulator-userdebug"
