#!/usr/bin/env bash
# AnaOS build-host bootstrap (TASK_004) — Ubuntu 24.04
# Safe to run on under-spec machines for tooling only; do NOT start full
# AOSP sync unless RAM>=64G and free disk>=800G.
set -euo pipefail

MIN_RAM_GB=64
MIN_DISK_GB=800
ANAOS_HOME="${ANAOS_HOME:-$HOME/anaos}"
BUILD_USER="${BUILD_USER:-$USER}"

ram_gb=$(awk '/MemTotal/ {printf "%.0f", $2/1024/1024}' /proc/meminfo)
disk_gb=$(df -BG --output=avail "$HOME" | tail -1 | tr -dc '0-9')

echo "Host: $(hostname)"
echo "RAM:  ${ram_gb}G (recommended >= ${MIN_RAM_GB}G)"
echo "Free disk on \$HOME: ${disk_gb}G (recommended >= ${MIN_DISK_GB}G)"

if [[ "${FORCE_WEAK_HOST:-}" != "1" ]]; then
  if (( ram_gb < MIN_RAM_GB )) || (( disk_gb < MIN_DISK_GB )); then
    echo "WARNING: host below AnaOS full-build requirements."
    echo "Continuing with tooling install only. Set FORCE_WEAK_HOST=1 to silence."
  fi
fi

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git-core gnupg flex bison build-essential zip curl zlib1g-dev \
  libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev \
  libxml2-utils xsltproc unzip fontconfig python3 python3-pip python-is-python3 \
  rsync ccache openjdk-17-jdk wget

mkdir -p "$HOME/bin" "$ANAOS_HOME" "$HOME/.ccache"
if [[ ! -x "$HOME/bin/repo" ]]; then
  curl -fsSL https://storage.googleapis.com/git-repo-downloads/repo -o "$HOME/bin/repo"
  chmod a+x "$HOME/bin/repo"
fi
grep -q 'HOME/bin' "$HOME/.bashrc" 2>/dev/null || echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
export PATH="$HOME/bin:$PATH"

git config --global user.name "${GIT_AUTHOR_NAME:-AnaOS Maintainers Levani}"
git config --global user.email "${GIT_AUTHOR_EMAIL:-Levan.alughishvili92@gmail.com}"
git config --global color.ui true

ccache -M 50G || true

cat > "$ANAOS_HOME/HOST_STATUS.md" <<EOF
# AnaOS host status

- hostname: $(hostname)
- ram_gb: ${ram_gb}
- disk_free_gb: ${disk_gb}
- date: $(date -u +%Y-%m-%dT%H:%M:%SZ)
- full_sync_allowed: $([[ $ram_gb -ge $MIN_RAM_GB && $disk_gb -ge $MIN_DISK_GB ]] && echo yes || echo no)
EOF

echo "Bootstrap complete. AnaOS home: $ANAOS_HOME"
echo "repo: $(command -v repo)"
repo version || true
