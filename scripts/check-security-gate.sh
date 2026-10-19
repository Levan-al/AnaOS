#!/usr/bin/env bash
# Lightweight TRACK B gate smoke (TASK_097). Does not replace device tests.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
fail=0

need() {
  if [[ ! -f "$ROOT/$1" ]]; then
    echo "MISSING: $1" >&2
    fail=1
  fi
}

need "docs/STRATEGY.md"
need "docs/SECURITY_MERGE_GATE.md"
need "docs/BRANDING.md"
need "docs/ROADMAP_NOW.md"
need "docs/PHASE_C.md"
need "docs/PHASE_D.md"
need "docs/POST_BUILD_OVERLAY.md"
need "docs/PRODUCT_PROPERTIES.md"
need "docs/AIRGAP_PRACTICAL.md"
need "device/anaos/common/official.mk"
need "device/anaos/common/anaos.mk"
need "apps/Updater/app/src/main/java/org/anaos/updater/HostAllowlist.kt"
need "apps/Updater/app/src/main/java/org/anaos/updater/BuildNumber.kt"
need "dns/anaos.org.zone.example"
need "fixtures/ota/stable/emulator/metadata.json"
need "adevtool/adevtool.py"
need "device/anaos/shiba/sepolicy/private/anaos_updater.te"
need "device/anaos/shiba/init/init.anaos.rc"
need "website/index.html"

if ! grep -q 'org.anaos' "$ROOT/docs/BRANDING.md"; then
  echo "BRANDING.md must mention org.anaos" >&2
  fail=1
fi

if ! grep -q 'ANAOS_OFFICIAL_BUILD' "$ROOT/device/anaos/common/official.mk"; then
  echo "official.mk missing ANAOS_OFFICIAL_BUILD" >&2
  fail=1
fi

if ! grep -q 'releases.anaos.org' "$ROOT/device/anaos/common/official.mk"; then
  echo "official.mk must pin releases.anaos.org" >&2
  fail=1
fi

# Updater scaffold must not point at GrapheneOS hosts
UPDATER_EP="$ROOT/apps/Updater/app/src/main/java/org/anaos/updater/UpdateEndpoints.kt"
if [[ -f "$UPDATER_EP" ]]; then
  if grep -qiE 'grapheneos\.org|releases\.grapheneos' "$UPDATER_EP"; then
    echo "Updater endpoints must not use GrapheneOS hosts" >&2
    fail=1
  fi
  if ! grep -q 'releases.anaos.org' "$UPDATER_EP"; then
    echo "Updater endpoints must include releases.anaos.org" >&2
    fail=1
  fi
fi

# Refuse accidental private key material in the meta tree
if find "$ROOT" \( -name '*.pk8' -o -name 'avb.pem' \) \
  -not -path '*/.git/*' 2>/dev/null | grep -q .; then
  echo "REFUSE: private key material present in meta tree" >&2
  fail=1
fi

# Emulator product must not inherit GrapheneOS update hosts
if grep -RniE 'releases\.grapheneos|grapheneos\.org/releases' \
  "$ROOT/device/anaos" 2>/dev/null | grep -q .; then
  echo "device/anaos must not reference GrapheneOS release hosts" >&2
  fail=1
fi

if [[ "$fail" -ne 0 ]]; then
  echo "TRACK B gate smoke: FAIL" >&2
  exit 1
fi
echo "TRACK B gate smoke: OK"
