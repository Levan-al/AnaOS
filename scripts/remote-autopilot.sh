#!/usr/bin/env bash
# Server-side Phase A autopilot: watch overlay, auto-fix known failures, retry once,
# seal OK/FAIL + SLEEP_REPORT. Does not delete the cloud VM (local autopilot / HCLOUD_TOKEN).
set -euo pipefail
export PATH="/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"

LOG=/opt/anaos/overlay-build.log
REPORT=/opt/anaos/SLEEP_REPORT.txt
STATE=/opt/anaos/AUTOPILOT_STATE
RETRY_FLAG=/opt/anaos/AUTOPILOT_PARTITION_RETRY
POLL=45
MAX_PARTITION_RETRIES=1

log() { echo "[$(date -u +%H:%M:%S)] $*" | tee -a /opt/anaos/autopilot.log; }

mkdir -p /opt/anaos
echo "phase=A watching" > "$STATE"
log "remote-autopilot start"

write_report() {
  {
    echo "sleep_report_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "BUILD_OK=$( [[ -f /opt/anaos/BUILD_OK ]] && cat /opt/anaos/BUILD_OK || echo no )"
    echo "OVERLAY_OK=$( [[ -f /opt/anaos/OVERLAY_OK ]] && cat /opt/anaos/OVERLAY_OK || echo no )"
    echo "OVERLAY_LUNCH_OK=$( [[ -f /opt/anaos/OVERLAY_LUNCH_OK ]] && cat /opt/anaos/OVERLAY_LUNCH_OK || echo no )"
    echo "OVERLAY_BUILD_OK=$( [[ -f /opt/anaos/OVERLAY_BUILD_OK ]] && cat /opt/anaos/OVERLAY_BUILD_OK || echo no )"
    echo "OVERLAY_BUILD_FAIL=$( [[ -f /opt/anaos/OVERLAY_BUILD_FAIL ]] && echo yes || echo no )"
    echo "autopilot=$(cat "$STATE" 2>/dev/null || true)"
    echo "last_log=$(tail -n 1 "$LOG" 2>/dev/null || true)"
    echo "next=local-autopilot Phase B pull+delete if HCLOUD_TOKEN set"
  } | tee "$REPORT"
  if [[ -x /opt/anaos/remote-record-bringup.sh ]]; then
    bash /opt/anaos/remote-record-bringup.sh || true
  fi
}

is_partition_fail() {
  [[ -f "$LOG" ]] || return 1
  grep -qE 'Not enough space on device for partition|does not have enough space free|FAILED: out/target/product/emulator/super\.img' "$LOG"
}

bump_partitions_and_retry() {
  local mk=/opt/anaos/aosp/device/anaos/emulator/anaos_emulator.mk
  local meta_mk=/opt/anaos/meta/device/anaos/emulator/anaos_emulator.mk
  local mb=4096
  log "partition fail — bumping BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE to ${mb}MiB and retrying m"
  if grep -q 'BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE' "$mk"; then
    sed -i -E "s/BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE := \\\$\(shell expr [0-9]+ \\\\* 1048576\)/BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE := \$(shell expr ${mb} \\* 1048576)/" "$mk" || true
    # portable rewrite if sed pattern missed
    if ! grep -q "expr ${mb}" "$mk"; then
      awk -v mb="$mb" '
        /BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE/ {
          print "BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE := $(shell expr " mb " \\* 1048576)"
          next
        }
        { print }
      ' "$mk" > "${mk}.new" && mv "${mk}.new" "$mk"
    fi
  else
    sed -i "1a BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE := \$(shell expr ${mb} \\* 1048576)" "$mk"
  fi
  cp -f "$mk" "$meta_mk" 2>/dev/null || true
  grep -n BOARD_EMULATOR_DYNAMIC "$mk" | tee -a /opt/anaos/autopilot.log

  rm -f /opt/anaos/OVERLAY_BUILD_FAIL /opt/anaos/OVERLAY_BUILD_OK /opt/anaos/overlay-build.rc
  if [[ -f "$LOG" ]]; then
    mv -f "$LOG" "/opt/anaos/overlay-build.log.fail-$(date -u +%Y%m%d%H%M%S)"
  fi
  : > "$LOG"
  date -u +%Y-%m-%dT%H:%M:%SZ > "$RETRY_FLAG"
  echo "phase=A retry_partition_${mb}" > "$STATE"

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
  log "retry m started in tmux aosp-overlay"
}

pack_artifacts() {
  local dest=/opt/anaos/artifacts-ready
  local prod=/opt/anaos/aosp/out/target/product/emulator
  mkdir -p "$dest"
  log "packing artifacts into $dest"
  for f in system.img product.img vendor.img system_ext.img system_dlkm.img \
           vendor_boot.img vbmeta.img ramdisk.img super.img dtb.img; do
    [[ -f "$prod/$f" ]] && cp -f "$prod/$f" "$dest/$f" || true
  done
  cp -f "$LOG" "$dest/overlay-build.log" 2>/dev/null || true
  cp -f /opt/anaos/OVERLAY_BUILD_OK "$dest/" 2>/dev/null || true
  cp -f /opt/anaos/BRINGUP.txt "$dest/" 2>/dev/null || true
  cp -f "$REPORT" "$dest/" 2>/dev/null || true
  (cd "$dest" && sha256sum ./* > SHA256SUMS 2>/dev/null || true)
  date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/ARTIFACTS_READY
  echo "phase=B_ready artifacts=$dest" > "$STATE"
  log "ARTIFACTS_READY"
}

# Main watch loop
retries_done=0
[[ -f "$RETRY_FLAG" ]] && retries_done=1

while true; do
  if [[ -f /opt/anaos/OVERLAY_BUILD_OK ]]; then
    log "OVERLAY_BUILD_OK present"
    echo "phase=A_ok" > "$STATE"
    write_report
    pack_artifacts
    break
  fi

  if [[ -f /opt/anaos/OVERLAY_BUILD_FAIL ]]; then
    log "OVERLAY_BUILD_FAIL present"
    if is_partition_fail && [[ "$retries_done" -lt "$MAX_PARTITION_RETRIES" ]]; then
      retries_done=$((retries_done + 1))
      rm -f /opt/anaos/OVERLAY_BUILD_FAIL
      bump_partitions_and_retry
      continue
    fi
    echo "phase=A_fail no_more_retries" > "$STATE"
    write_report
    date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/PHASE_B_ABORT
    break
  fi

  # Success banner before rc file
  if [[ -f "$LOG" ]] && grep -q 'build completed successfully' "$LOG"; then
    date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_OK
    continue
  fi

  if [[ -f /opt/anaos/overlay-build.rc ]]; then
    rc=$(cat /opt/anaos/overlay-build.rc || echo 1)
    if [[ "$rc" == "0" ]]; then
      date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_OK
    else
      date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_FAIL
      echo "rc=$rc" >> /opt/anaos/OVERLAY_BUILD_FAIL
    fi
    continue
  fi

  if ! tmux has-session -t aosp-overlay 2>/dev/null; then
    sleep 60
    if ! tmux has-session -t aosp-overlay 2>/dev/null; then
      if [[ -f "$LOG" ]] && grep -q 'build completed successfully' "$LOG"; then
        date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_OK
        continue
      fi
      if [[ ! -f /opt/anaos/OVERLAY_BUILD_FAIL && ! -f /opt/anaos/OVERLAY_BUILD_OK ]]; then
        date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_BUILD_FAIL
        echo "reason=aosp-overlay session ended without success" >> /opt/anaos/OVERLAY_BUILD_FAIL
      fi
      continue
    fi
  fi

  sleep "$POLL"
done

log "remote-autopilot idle"
while true; do sleep 3600; done
