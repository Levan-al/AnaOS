#!/usr/bin/env bash
# After BUILD_OK: refresh meta, overlay AnaOS trees, optionally rebuild.
# Safe to start while first `m` still runs — waits for /opt/anaos/BUILD_OK.
# Usage:
#   tmux new -d -s aosp-after 'bash /opt/anaos/remote-after-build.sh'
set -euo pipefail
export PATH="/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"

AOSP="${AOSP:-/opt/anaos/aosp}"
META="${META:-/opt/anaos/meta}"
LOG=/opt/anaos/after-build.log
AUTO_REBUILD="${ANAOS_AUTO_REBUILD:-1}"
JOBS="${ANAOS_BUILD_JOBS:-4}"

log() { echo "[$(date -u +%H:%M:%S)] $*" | tee -a "$LOG"; }

log "waiting for BUILD_OK"
while [[ ! -f /opt/anaos/BUILD_OK ]]; do
  sleep 30
done
log "BUILD_OK present: $(cat /opt/anaos/BUILD_OK)"

if [[ -x /opt/anaos/remote-stage-meta.sh ]]; then
  bash /opt/anaos/remote-stage-meta.sh 2>&1 | tee -a "$LOG"
elif [[ -x "$META/scripts/remote-stage-meta.sh" ]]; then
  bash "$META/scripts/remote-stage-meta.sh" 2>&1 | tee -a "$LOG"
fi

export META AOSP
bash /opt/anaos/post-build-overlay.sh 2>&1 | tee -a "$LOG"
test -f /opt/anaos/OVERLAY_OK
log "OVERLAY_OK"

cd "$AOSP"
set +e
set +u
# shellcheck disable=SC1091
source build/envsetup.sh
set -e

LUNCH_OUT=/tmp/anaos-lunch.txt
LUNCH_TARGETS=(
  "anaos_emulator-trunk_staging-userdebug"
  "anaos_emulator-trunk_staging-user"
  "anaos_emulator-userdebug"
  "anaos_emulator-user"
)
chosen_lunch=""
lunch_rc=1
for t in "${LUNCH_TARGETS[@]}"; do
  log "trying lunch $t"
  set +e
  lunch "$t" >"$LUNCH_OUT" 2>&1
  lunch_rc=$?
  set -e
  cat "$LUNCH_OUT" | tee -a "$LOG" || true
  if [[ "$lunch_rc" -eq 0 ]]; then
    chosen_lunch=$t
    break
  fi
done

if [[ -z "$chosen_lunch" ]]; then
  log "all anaos_emulator lunch targets failed — record for pin fix; no auto rebuild"
  date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_LUNCH_FAIL
  exit 0
fi
echo "lunch=$chosen_lunch" > /opt/anaos/OVERLAY_LUNCH_META

date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_LUNCH_OK
log "lunch OK"

if [[ "$AUTO_REBUILD" != "1" ]]; then
  log "ANAOS_AUTO_REBUILD!=1 — stop after lunch OK"
  exit 0
fi

log "AnaOS rebuild m -j${JOBS}"
set +e
if command -v stdbuf >/dev/null 2>&1; then
  stdbuf -oL -eL m -j"${JOBS}" 2>&1 | tee -a /opt/anaos/overlay-build.log
else
  m -j"${JOBS}" 2>&1 | tee -a /opt/anaos/overlay-build.log
fi
m_rc=${PIPESTATUS[0]}
set -e
if [[ "$m_rc" -ne 0 ]]; then
  log "OVERLAY_BUILD_FAIL rc=$m_rc"
  exit "$m_rc"
fi
date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_OK
log "OVERLAY_BUILD_OK"
