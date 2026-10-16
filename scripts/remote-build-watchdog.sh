#!/bin/bash
# Cost-aware build watchdog for anaos-build (TASK_018).
# - Restarts build if log stalls (wasted idle billable time)
# - Writes /opt/anaos/STATUS.txt for quick checks
# - Does NOT delete the server (human decision)
set -euo pipefail
export PATH="/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"

LOG=/opt/anaos/build.log
STATUS=/opt/anaos/STATUS.txt
STALL_MINUTES="${STALL_MINUTES:-25}"
CHECK_EVERY="${CHECK_EVERY:-120}"
BUILD_SCRIPT=/opt/anaos/remote-aosp-build.sh

write_status() {
  local state=$1
  local detail=${2:-}
  {
    echo "updated_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "state=$state"
    echo "detail=$detail"
    echo "sync_ok=$([ -f /opt/anaos/SYNC_OK ] && echo yes || echo no)"
    echo "build_ok=$([ -f /opt/anaos/BUILD_OK ] && echo yes || echo no)"
    echo "log_bytes=$(stat -c%s "$LOG" 2>/dev/null || echo 0)"
    echo "log_mtime=$(stat -c%Y "$LOG" 2>/dev/null || echo 0)"
    echo "tmux_build=$(tmux has-session -t aosp-build 2>/dev/null && echo yes || echo no)"
    echo "load=$(cut -d' ' -f1-3 /proc/loadavg)"
    echo "mem_avail_mb=$(awk '/MemAvailable/ {print int($2/1024)}' /proc/meminfo)"
    echo "swap_used_mb=$(awk '/SwapTotal/ {t=$2} /SwapFree/ {f=$2} END {print int((t-f)/1024)}' /proc/meminfo)"
    echo "disk_used=$(df -h / | awk 'NR==2{print $3 "/" $2 " (" $5 ")"}')"
    echo "--- log_tail ---"
    tail -n 5 "$LOG" 2>/dev/null || true
  } > "$STATUS"
}

build_running() {
  tmux has-session -t aosp-build 2>/dev/null || return 1
  # session exists; treat as running unless BUILD_OK
  return 0
}

start_build() {
  tmux kill-session -t aosp-build 2>/dev/null || true
  printf '\n[watchdog-restart %s]\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$LOG"
  tmux new-session -d -s aosp-build "bash -lc $BUILD_SCRIPT"
  write_status "restarted" "watchdog started/restarted aosp-build"
}

echo "[$(date -u +%H:%M:%S)] watchdog start stall=${STALL_MINUTES}m" | tee -a /opt/anaos/watchdog.log

if [[ ! -f /opt/anaos/BUILD_OK ]] && ! build_running; then
  start_build
fi

while true; do
  if [[ -f /opt/anaos/BUILD_OK ]]; then
    write_status "build_ok" "BUILD_OK present — consider deleting server to stop billing"
    echo "[$(date -u +%H:%M:%S)] BUILD_OK — watchdog idle" | tee -a /opt/anaos/watchdog.log
    # Stay alive but do not burn CPU; human deletes server
    sleep 300
    continue
  fi

  # If Soong already reported success but BUILD_OK was not written (race), seal it.
  if [[ -f "$LOG" ]] && grep -q 'build completed successfully' "$LOG"; then
    echo "[$(date -u +%H:%M:%S)] success banner in log — writing BUILD_OK" | tee -a /opt/anaos/watchdog.log
    date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/BUILD_OK
    write_status "build_ok" "recovered BUILD_OK from success banner"
    sleep "$CHECK_EVERY"
    continue
  fi

  if ! build_running; then
    echo "[$(date -u +%H:%M:%S)] build session missing — restart" | tee -a /opt/anaos/watchdog.log
    start_build
    sleep "$CHECK_EVERY"
    continue
  fi

  now=$(date +%s)
  mtime=$(stat -c%Y "$LOG" 2>/dev/null || echo 0)
  age=$(( now - mtime ))
  stall=$(( STALL_MINUTES * 60 ))

  if [[ "$mtime" -gt 0 && "$age" -gt "$stall" ]]; then
    echo "[$(date -u +%H:%M:%S)] STALL ${age}s > ${stall}s — restart" | tee -a /opt/anaos/watchdog.log
    start_build
  else
    write_status "building" "log_age_s=$age"
  fi

  sleep "$CHECK_EVERY"
done
