#!/usr/bin/env bash
# Retry anaos_emulator overlay after enlarging BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE.
# Expects fixed mk files already at /tmp/anaos_emulator.mk and /tmp/BoardConfig.mk
set -euo pipefail
export PATH="/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"

cp -f /tmp/anaos_emulator.mk /opt/anaos/meta/device/anaos/emulator/anaos_emulator.mk
cp -f /tmp/BoardConfig.mk /opt/anaos/meta/device/anaos/emulator/BoardConfig.mk
mkdir -p /opt/anaos/aosp/device/anaos/emulator
cp -f /tmp/anaos_emulator.mk /opt/anaos/aosp/device/anaos/emulator/anaos_emulator.mk
cp -f /tmp/BoardConfig.mk /opt/anaos/aosp/device/anaos/emulator/BoardConfig.mk
grep -n "BOARD_EMULATOR_DYNAMIC" /opt/anaos/aosp/device/anaos/emulator/anaos_emulator.mk

rm -f /opt/anaos/OVERLAY_BUILD_FAIL /opt/anaos/OVERLAY_BUILD_OK \
  /opt/anaos/overlay-build.rc /opt/anaos/SLEEP_REPORT.txt /opt/anaos/SLEEP_REPORT

if [[ -f /opt/anaos/overlay-build.log ]]; then
  mv -f /opt/anaos/overlay-build.log "/opt/anaos/overlay-build.log.fail-$(date -u +%Y%m%d%H%M%S)"
fi
: > /opt/anaos/overlay-build.log

tmux kill-session -t aosp-overlay-finish 2>/dev/null || true
tmux kill-session -t aosp-overlay 2>/dev/null || true

tmux new-session -d -s aosp-overlay bash -lc '
set -euo pipefail
cd /opt/anaos/aosp
source build/envsetup.sh
lunch anaos_emulator-trunk_staging-userdebug
set +e
if command -v stdbuf >/dev/null 2>&1; then
  stdbuf -oL -eL m -j4 2>&1 | tee /opt/anaos/overlay-build.log
else
  m -j4 2>&1 | tee /opt/anaos/overlay-build.log
fi
rc=${PIPESTATUS[0]}
echo "$rc" > /opt/anaos/overlay-build.rc
if [[ "$rc" -eq 0 ]]; then
  date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_OK
else
  date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_FAIL
  echo "rc=$rc" >> /opt/anaos/OVERLAY_BUILD_FAIL
fi
exit "$rc"
'

tmux new-session -d -s aosp-overlay-finish bash /opt/anaos/remote-overlay-finish.sh
sleep 4
tmux ls
echo "--- log head ---"
head -n 25 /opt/anaos/overlay-build.log || true
echo "RETRY_STARTED"
