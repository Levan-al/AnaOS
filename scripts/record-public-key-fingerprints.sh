#!/usr/bin/env bash
# Hash public PEMs / AVB public blob only (TASK_023 / ceremony after-step).
# Usage: ./scripts/record-public-key-fingerprints.sh /path/to/public-only-dir
# Never point this at a directory that still contains .pk8 on a networked host.
set -euo pipefail
DIR="${1:?public keys directory}"
OUT="${2:-$DIR/FINGERPRINTS.sha256}"

if find "$DIR" -type f \( -name '*.pk8' -o -name 'avb.pem' \) | grep -q .; then
  echo "REFUSE: private material present under $DIR — use USB A (public only)" >&2
  exit 1
fi

{
  echo "# AnaOS public key fingerprints — $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "# Directory: $DIR"
  find "$DIR" -type f \( -name '*.x509.pem' -o -name 'avb_pkmd.bin' \) -print0 \
    | sort -z | xargs -0 sha256sum
} | tee "$OUT"

echo "Wrote $OUT"
