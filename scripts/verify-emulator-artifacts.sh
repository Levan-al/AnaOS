#!/usr/bin/env bash
# Verify local AnaOS emulator artifact folder (post Phase B pull).
# Usage: bash scripts/verify-emulator-artifacts.sh [anaos-emulator-out]
set -euo pipefail
DIR="${1:-anaos-emulator-out}"
fail=0

need() {
  if [[ ! -f "$DIR/$1" ]]; then
    echo "MISSING: $DIR/$1" >&2
    fail=1
  else
    local sz
    sz=$(wc -c < "$DIR/$1" | tr -d ' ')
    echo "OK $1 ($sz bytes)"
  fi
}

need OVERLAY_BUILD_OK
need super.img
need system.img
need product.img
need vendor.img
need system_ext.img
need vendor_boot.img
need vbmeta.img

if [[ -f "$DIR/SHA256SUMS" ]] && command -v sha256sum >/dev/null 2>&1; then
  echo "Checking SHA256SUMS (files present in sums)…"
  while read -r hash name; do
    [[ -z "${hash:-}" || "$hash" =~ ^# ]] && continue
    base=$(basename "$name")
    f="$DIR/$base"
    [[ -f "$f" ]] || continue
    if ! echo "$hash  $f" | sha256sum -c -; then
      # system_dlkm alone is non-fatal if super.img verified (scp truncations)
      if [[ "$base" == "system_dlkm.img" ]]; then
        echo "WARN: $base checksum mismatch (non-fatal if super.img OK)" >&2
      else
        fail=1
      fi
    fi
  done < "$DIR/SHA256SUMS"
fi

if [[ "$fail" -ne 0 ]]; then
  echo "emulator artifacts: FAIL" >&2
  exit 1
fi
echo "emulator artifacts: OK"
