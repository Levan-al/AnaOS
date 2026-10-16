#!/bin/bash
# Re-fetch projects that failed checkout during the first AOSP sync.
# Safe to run after the main `repo sync` process exits (TASK_018).
set -euo pipefail
export PATH=/root/bin:$PATH
unset REPO_URL || true
SRC="${SRC:-/opt/anaos/aosp}"
LOG="${LOG:-/opt/anaos/sync-repair.log}"
cd "$SRC"

echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] repair sync start" | tee -a "$LOG"

# Known flaky checkouts observed on anaos-build first pass:
PROJECTS=(
  platform/external/ltp
  platform/external/mbedtls
  platform/external/python/enum34
)

for p in "${PROJECTS[@]}"; do
  echo "[$(date -u +%H:%M:%S)] retry $p" | tee -a "$LOG"
  # Drop empty / broken work trees then force sync that path
  rel="${p#platform/}"
  if [[ -d "$SRC/$rel" ]] && [[ -z "$(ls -A "$SRC/$rel" 2>/dev/null || true)" ]]; then
    rm -rf "$SRC/$rel"
  fi
  repo sync -c -j2 --no-tags --optimized-fetch --prune "$p" 2>&1 | tee -a "$LOG" || true
done

echo "[$(date -u +%H:%M:%S)] full catch-up sync" | tee -a "$LOG"
repo sync -c -j4 --no-tags --optimized-fetch --prune 2>&1 | tee -a "$LOG"

if [[ -d "$SRC/build/make" ]] && [[ -d "$SRC/frameworks/base" ]]; then
  date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/SYNC_OK
  echo "[$(date -u +%H:%M:%S)] SYNC_OK written" | tee -a "$LOG"
else
  echo "[$(date -u +%H:%M:%S)] tree still incomplete — inspect $LOG" | tee -a "$LOG"
  exit 1
fi
