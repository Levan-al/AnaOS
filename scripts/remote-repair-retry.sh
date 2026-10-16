#!/bin/bash
# Retry after HTTP 429 from googlesource (TASK_018).
set -euo pipefail
export PATH=/root/bin:$PATH
unset REPO_URL || true
SRC=/opt/anaos/aosp
LOG=/opt/anaos/sync-repair.log
cd "$SRC"

echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] rate-limit retry start" | tee -a "$LOG"
sleep 90

ok=0
for attempt in 1 2 3 4 5; do
  echo "[$(date -u +%H:%M:%S)] attempt $attempt: sync platform/prebuilts/vndk/v33" | tee -a "$LOG"
  if repo sync -c -j1 --no-tags --optimized-fetch --prune platform/prebuilts/vndk/v33 2>&1 | tee -a "$LOG"; then
    echo "[$(date -u +%H:%M:%S)] vndk ok" | tee -a "$LOG"
    ok=1
    break
  fi
  echo "[$(date -u +%H:%M:%S)] fail — sleep $((attempt * 60))s" | tee -a "$LOG"
  sleep $((attempt * 60))
done

if [[ "$ok" -ne 1 ]]; then
  echo "[$(date -u +%H:%M:%S)] vndk still failing after retries" | tee -a "$LOG"
  exit 1
fi

echo "[$(date -u +%H:%M:%S)] full catch-up -j2" | tee -a "$LOG"
repo sync -c -j2 --no-tags --optimized-fetch --prune 2>&1 | tee -a "$LOG"

if [[ -d "$SRC/build/make" && -d "$SRC/frameworks/base" ]]; then
  date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/SYNC_OK
  echo "[$(date -u +%H:%M:%S)] SYNC_OK written" | tee -a "$LOG"
  echo "[$(date -u +%H:%M:%S)] SYNC_OK" | tee -a /opt/anaos/sync.log
  bash /opt/anaos/remote-aosp-build.sh
else
  echo "incomplete tree" | tee -a "$LOG"
  exit 1
fi
