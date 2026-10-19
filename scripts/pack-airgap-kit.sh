#!/usr/bin/env bash
# Pack public ceremony materials for USB-A (prep only).
# NEVER includes .pk8 / private keys. Safe to run on a networked machine.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:-$ROOT/out/airgap-kit}"
STAMP="$(date -u +%Y%m%d)"
DEST="$OUT/anaos-airgap-public-$STAMP"

rm -rf "$DEST"
mkdir -p "$DEST/script" "$DEST/scripts" "$DEST/docs"

copy() {
  local src="$1" dst="$2"
  if [[ -e "$ROOT/$src" ]]; then
    mkdir -p "$(dirname "$DEST/$dst")"
    cp -a "$ROOT/$src" "$DEST/$dst"
  else
    echo "WARN: missing $src" >&2
  fi
}

copy script/make_anaos_keys.sh script/
copy script/make_anaos_avb_key.sh script/
copy script/make_anaos_app_keys.sh script/
copy scripts/record-public-key-fingerprints.sh scripts/
copy scripts/pack-airgap-kit.sh scripts/

for f in \
  AIRGAP_PRACTICAL.md AIRGAP_DAY.md KEY_CEREMONY.md KEY_CEREMONY_CHECKLIST.md \
  KEY_RECOVERY.md APP_SIGNING.md SECURITY_MERGE_GATE.md PHASE_C.md; do
  copy "docs/$f" "docs/$f"
done

cat > "$DEST/README.txt" <<EOF
AnaOS air-gap PUBLIC kit ($STAMP)
=================================
Copy this folder to USB-A only.
Do NOT put private keys on this stick.
Ceremony day: follow docs/AIRGAP_PRACTICAL.md offline.
EOF

# Refuse to pack secrets if present by mistake
if find "$DEST" \( -name '*.pk8' -o -name 'avb.pem' -o -name '*_password*' \) | grep -q .; then
  echo "REFUSING: private material found under $DEST" >&2
  exit 1
fi

(
  cd "$OUT"
  if command -v tar >/dev/null 2>&1; then
    tar -czf "anaos-airgap-public-$STAMP.tar.gz" "anaos-airgap-public-$STAMP"
    echo "Wrote $OUT/anaos-airgap-public-$STAMP.tar.gz"
  fi
)
echo "Kit directory: $DEST"
