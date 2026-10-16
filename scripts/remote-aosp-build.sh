#!/bin/bash
# First AnaOS/AOSP emulator user build after sync (TASK_018)
set -eo pipefail
export PATH="/root/bin:/usr/lib/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"
export USE_CCACHE=1
export CCACHE_DIR=/root/.ccache
SRC=/opt/anaos/aosp
LOG=/opt/anaos/build.log
cd "$SRC"

echo "[$(date -u +%H:%M:%S)] sourcing envsetup" | tee -a "$LOG"
# envsetup is not nounset-safe and may return non-zero
set +e
set +u
# shellcheck disable=SC1091
source build/envsetup.sh
set -e

# Try modern lunch targets in order
TARGETS=(
  "sdk_phone64_x86_64-user"
  "sdk_phone64_x86_64-trunk_staging-user"
  "aosp_cf_x86_64_phone-user"
  "aosp_x86_64-user"
)

chosen=""
for t in "${TARGETS[@]}"; do
  echo "[$(date -u +%H:%M:%S)] trying lunch $t" | tee -a "$LOG"
  set +e
  lunch "$t" >/tmp/lunch.out 2>&1
  lunch_rc=$?
  set -e
  cat /tmp/lunch.out | tee -a "$LOG" || true
  if [[ "$lunch_rc" -eq 0 ]]; then
    chosen=$t
    break
  fi
done

if [[ -z "$chosen" ]]; then
  echo "ERROR: no lunch target worked; dumping lunch help" | tee -a "$LOG"
  set +e
  lunch 2>&1 | head -100 | tee -a "$LOG"
  set -e
  exit 1
fi

# 32GB host + swap: -j4 reduces OOM/stall risk (wasted billable hours)
JOBS="${ANAOS_BUILD_JOBS:-4}"
echo "[$(date -u +%H:%M:%S)] BUILD start target=$chosen -j${JOBS}" | tee -a "$LOG"
set +e
# stdbuf helps log mtime advance for the watchdog
if command -v stdbuf >/dev/null 2>&1; then
  stdbuf -oL -eL m -j"${JOBS}" 2>&1 | tee -a "$LOG"
else
  m -j"${JOBS}" 2>&1 | tee -a "$LOG"
fi
m_rc=${PIPESTATUS[0]}
set -e

# Prefer Soong success banner — some hosts return odd pipe statuses after success.
if grep -q 'build completed successfully' "$LOG"; then
  m_rc=0
fi

if [[ "$m_rc" -ne 0 ]]; then
  echo "[$(date -u +%H:%M:%S)] BUILD_FAIL rc=$m_rc target=$chosen" | tee -a "$LOG"
  exit "$m_rc"
fi

# Write marker immediately so watchdog cannot race-restart this session.
echo "[$(date -u +%H:%M:%S)] BUILD_OK target=$chosen" | tee -a "$LOG"
date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/BUILD_OK
echo "target=$chosen" > /opt/anaos/BUILD_OK_META
