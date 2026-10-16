#!/usr/bin/env bash
# Snapshot bring-up facts on the build host (cheap; safe anytime).
# Usage: bash remote-record-bringup.sh
set -euo pipefail
export PATH="/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"

OUT=/opt/anaos/BRINGUP.txt
{
  echo "recorded_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "hostname=$(hostname)"
  echo "uptime=$(uptime)"
  df -h / | tail -1 | awk '{print "disk_avail="$4" disk_use="$5}'
  free -h | awk '/Mem:/{print "mem_total="$2" mem_avail="$7}'
  for m in SYNC_OK BUILD_OK META_OK OVERLAY_OK OVERLAY_LUNCH_OK OVERLAY_LUNCH_FAIL OVERLAY_BUILD_OK; do
    if [[ -f /opt/anaos/$m ]]; then
      echo "${m}=$(cat /opt/anaos/$m)"
    else
      echo "${m}=no"
    fi
  done
  if [[ -f /opt/anaos/build.log ]]; then
    echo "lunch_chosen=$(grep -E 'BUILD start target=' /opt/anaos/build.log | tail -1 || true)"
    echo "build_log_tail=$(tail -n 1 /opt/anaos/build.log)"
  fi
  tmux has-session -t aosp-build 2>/dev/null && echo "tmux_aosp_build=yes" || echo "tmux_aosp_build=no"
  tmux has-session -t aosp-after 2>/dev/null && echo "tmux_aosp_after=yes" || echo "tmux_aosp_after=no"
  tmux has-session -t aosp-watchdog 2>/dev/null && echo "tmux_aosp_watchdog=yes" || echo "tmux_aosp_watchdog=no"
  if [[ -d /opt/anaos/meta/.git ]]; then
    echo "meta_sha=$(git -C /opt/anaos/meta rev-parse --short HEAD)"
  fi
} | tee "$OUT"
echo "wrote $OUT"
