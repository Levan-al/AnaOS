#!/usr/bin/env bash
# Unattended finish for anaos_emulator overlay rebuild (sleep / away mode).
# - Watches overlay-build.log / aosp-overlay tmux
# - Writes OVERLAY_BUILD_OK or OVERLAY_BUILD_FAIL
# - Records BRINGUP + SLEEP_REPORT for morning
# - Does NOT delete the Hetzner server (human COST_OPS)
set -euo pipefail
export PATH="/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"

LOG=/opt/anaos/overlay-build.log
REPORT=/opt/anaos/SLEEP_REPORT.txt
POLL=60

log() { echo "[$(date -u +%H:%M:%S)] $*" | tee -a /opt/anaos/overlay-finish.log; }

log "overlay-finish watcher start"

while true; do
  if [[ -f /opt/anaos/OVERLAY_BUILD_OK || -f /opt/anaos/OVERLAY_BUILD_FAIL ]]; then
    log "terminal marker already present — writing report and idle"
    break
  fi

  running=0
  tmux has-session -t aosp-overlay 2>/dev/null && running=1

  if [[ -f "$LOG" ]] && grep -q 'build completed successfully' "$LOG"; then
    date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_OK
    log "OVERLAY_BUILD_OK (success banner)"
    break
  fi

  if [[ -f /opt/anaos/overlay-build.rc ]]; then
    rc=$(cat /opt/anaos/overlay-build.rc || echo 1)
    if [[ "$rc" == "0" ]]; then
      date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_OK
      log "OVERLAY_BUILD_OK (rc=0)"
      break
    else
      date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_FAIL
      echo "rc=$rc" >> /opt/anaos/OVERLAY_BUILD_FAIL
      log "OVERLAY_BUILD_FAIL rc=$rc"
      break
    fi
  fi

  # Session gone without success banner / rc → fail closed
  if [[ "$running" -eq 0 ]]; then
    sleep 90
    if ! tmux has-session -t aosp-overlay 2>/dev/null; then
      if [[ -f "$LOG" ]] && grep -q 'build completed successfully' "$LOG"; then
        date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_OK
        log "OVERLAY_BUILD_OK (late banner)"
        break
      fi
      date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_FAIL
      echo "reason=aosp-overlay session ended without success" >> /opt/anaos/OVERLAY_BUILD_FAIL
      log "OVERLAY_BUILD_FAIL session ended"
      break
    fi
  fi

  sleep "$POLL"
done

if [[ -x /opt/anaos/remote-record-bringup.sh ]]; then
  bash /opt/anaos/remote-record-bringup.sh || true
elif [[ -x /opt/anaos/meta/scripts/remote-record-bringup.sh ]]; then
  bash /opt/anaos/meta/scripts/remote-record-bringup.sh || true
fi

{
  echo "sleep_report_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "BUILD_OK=$( [[ -f /opt/anaos/BUILD_OK ]] && cat /opt/anaos/BUILD_OK || echo no )"
  echo "OVERLAY_OK=$( [[ -f /opt/anaos/OVERLAY_OK ]] && cat /opt/anaos/OVERLAY_OK || echo no )"
  echo "OVERLAY_LUNCH_OK=$( [[ -f /opt/anaos/OVERLAY_LUNCH_OK ]] && cat /opt/anaos/OVERLAY_LUNCH_OK || echo no )"
  echo "OVERLAY_BUILD_OK=$( [[ -f /opt/anaos/OVERLAY_BUILD_OK ]] && cat /opt/anaos/OVERLAY_BUILD_OK || echo no )"
  echo "OVERLAY_BUILD_FAIL=$( [[ -f /opt/anaos/OVERLAY_BUILD_FAIL ]] && echo yes || echo no )"
  echo "last_log=$(tail -n 1 "$LOG" 2>/dev/null || true)"
  echo "next_human=Read COST_OPS.md — delete anaos-build CPX62 to stop billing after you review SLEEP_REPORT/BRINGUP"
  echo "not_done_auto=server delete, key ceremony, device flash"
} | tee "$REPORT"

log "wrote $REPORT — watcher idle (will not delete server)"
# Stay alive lightly so tmux session remains inspectable
while true; do sleep 3600; done
