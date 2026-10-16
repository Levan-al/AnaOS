#!/bin/bash
# First AOSP sync on anaos-build (TASK_017/018 path)
set -euo pipefail
export PATH=/root/bin:$PATH
unset REPO_URL || true
SRC=/opt/anaos/aosp
BRANCH=android-latest-release
LOG=/opt/anaos/sync.log
mkdir -p "$SRC" /opt/anaos
cd "$SRC"
rm -rf .repo 2>/dev/null || true

echo "[$(date -u +%H:%M:%S)] repo init -b $BRANCH" | tee -a "$LOG"
repo init --partial-clone --no-use-superproject \
  -u https://android.googlesource.com/platform/manifest \
  -b "$BRANCH" \
  2>&1 | tee -a "$LOG"

echo "[$(date -u +%H:%M:%S)] repo sync start" | tee -a "$LOG"
# -c current branch only; -j4 safer on 32GB / shared CPU
repo sync -c -j4 --no-tags --optimized-fetch --prune 2>&1 | tee -a "$LOG"
echo "[$(date -u +%H:%M:%S)] SYNC_OK" | tee -a "$LOG"
df -h / | tee -a "$LOG"
