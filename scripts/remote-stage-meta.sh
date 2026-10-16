#!/usr/bin/env bash
# Clone / update AnaOS meta on the build host for post-BUILD_OK overlay.
# Safe to run while `m` is compiling (does not touch aosp/out).
# Usage: bash remote-stage-meta.sh
set -euo pipefail
export PATH="/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"

META="${META:-/opt/anaos/meta}"
REPO_URL="${ANAOS_META_URL:-https://github.com/Levan-al/AnaOS.git}"
BRANCH="${ANAOS_META_BRANCH:-main}"

mkdir -p /opt/anaos
if [[ -d "$META/.git" ]]; then
  echo "[stage-meta] updating $META"
  git -C "$META" fetch --depth 1 origin "$BRANCH"
  git -C "$META" checkout -B "$BRANCH" "origin/$BRANCH"
  git -C "$META" reset --hard "origin/$BRANCH"
else
  echo "[stage-meta] cloning $REPO_URL → $META"
  rm -rf "$META"
  git clone --depth 1 -b "$BRANCH" "$REPO_URL" "$META"
fi

test -d "$META/device/anaos" || { echo "missing device/anaos in $META" >&2; exit 1; }
test -d "$META/branding" || { echo "missing branding in $META" >&2; exit 1; }

# Keep host helpers in sync with meta
for f in post-build-overlay.sh overlay-anaos-into-aosp.sh remote-after-build.sh remote-stage-meta.sh; do
  if [[ -f "$META/scripts/$f" ]]; then
    cp -f "$META/scripts/$f" "/opt/anaos/$f"
    chmod +x "/opt/anaos/$f"
  fi
done

date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/META_OK
echo "[stage-meta] META_OK → $META @ $(git -C "$META" rev-parse --short HEAD)"
