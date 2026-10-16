#!/bin/bash
# First AnaOS/AOSP emulator user build after sync (TASK_018)
set -euo pipefail
export PATH=/root/bin:/usr/lib/ccache:$PATH
export USE_CCACHE=1
export CCACHE_DIR=/root/.ccache
SRC=/opt/anaos/aosp
LOG=/opt/anaos/build.log
cd "$SRC"

echo "[$(date -u +%H:%M:%S)] sourcing envsetup" | tee -a "$LOG"
set +u
# shellcheck disable=SC1091
source build/envsetup.sh
set -u

# Try modern lunch targets in order
TARGETS=(
  "sdk_phone64_x86_64-user"
  "sdk_phone64_x86_64-trunk_staging-user"
  "aosp_cf_x86_64_phone-user"
  "aosp_x86_64-user"
)

chosen=""
for t in "${TARGETS[@]}"; do
  if lunch "$t" >/tmp/lunch.out 2>&1; then
    chosen=$t
    cat /tmp/lunch.out | tee -a "$LOG"
    break
  fi
done

if [[ -z "$chosen" ]]; then
  echo "ERROR: no lunch target worked; dumping lunch help" | tee -a "$LOG"
  lunch 2>&1 | head -100 | tee -a "$LOG" || true
  exit 1
fi

echo "[$(date -u +%H:%M:%S)] BUILD start target=$chosen -j8" | tee -a "$LOG"
# 32GB host: keep parallelism moderate
m -j8 2>&1 | tee -a "$LOG"
echo "[$(date -u +%H:%M:%S)] BUILD_OK target=$chosen" | tee -a "$LOG"
