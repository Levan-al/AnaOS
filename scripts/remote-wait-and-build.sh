#!/bin/bash
set -euo pipefail
LOG=/opt/anaos/watch.log
SYNC_LOG=/opt/anaos/sync.log
echo "[$(date -u +%H:%M:%S)] watching for SYNC_OK" | tee -a "$LOG"
while true; do
  if grep -q 'SYNC_OK' "$SYNC_LOG" 2>/dev/null || [[ -f /opt/anaos/SYNC_OK ]]; then
    echo "[$(date -u +%H:%M:%S)] sync finished — starting build" | tee -a "$LOG"
    bash /opt/anaos/remote-aosp-build.sh
    exit $?
  fi
  if ! pgrep -f 'repo/main.py.*sync' >/dev/null 2>&1; then
    if grep -q 'SYNC_OK' "$SYNC_LOG" 2>/dev/null || [[ -f /opt/anaos/SYNC_OK ]]; then
      continue
    fi
    echo "[$(date -u +%H:%M:%S)] sync ended without SYNC_OK — running repair" | tee -a "$LOG"
    if bash /opt/anaos/remote-repair-sync.sh; then
      echo "[$(date -u +%H:%M:%S)] repair OK — starting build" | tee -a "$LOG"
      bash /opt/anaos/remote-aosp-build.sh
      exit $?
    fi
    echo "[$(date -u +%H:%M:%S)] ERROR: repair failed" | tee -a "$LOG"
    tail -n 50 "$SYNC_LOG" | tee -a "$LOG"
    exit 1
  fi
  sleep 60
done
