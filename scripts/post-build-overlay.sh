#!/bin/bash
# After BUILD_OK: overlay AnaOS trees into the AOSP checkout and record status.
# Usage on anaos-build:
#   META=/path/to/AnaOS-meta bash /opt/anaos/post-build-overlay.sh
set -euo pipefail
export PATH="/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"

AOSP="${AOSP:-/opt/anaos/aosp}"
META="${META:-}"
LOG=/opt/anaos/overlay.log

if [[ ! -f /opt/anaos/BUILD_OK ]]; then
  echo "BUILD_OK missing — refuse overlay until first build finishes" | tee -a "$LOG"
  exit 1
fi

if [[ -z "$META" || ! -d "$META/device/anaos" ]]; then
  echo "Set META to AnaOS meta checkout containing device/anaos" | tee -a "$LOG"
  exit 1
fi

echo "[$(date -u +%H:%M:%S)] overlay start" | tee -a "$LOG"
bash "$(dirname "$0")/overlay-anaos-into-aosp.sh" "$AOSP" "$META" | tee -a "$LOG"
date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_OK
echo "[$(date -u +%H:%M:%S)] OVERLAY_OK — next: lunch anaos_emulator-userdebug && m -j4" | tee -a "$LOG"
