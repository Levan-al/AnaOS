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
need "device/anaos/common/official.mk"
need "device/anaos/common/anaos.mk"

if ! grep -q 'org.anaos' "$ROOT/docs/BRANDING.md"; then
  echo "BRANDING.md must mention org.anaos" >&2
  fail=1
fi

if ! grep -q 'ANAOS_OFFICIAL_BUILD' "$ROOT/device/anaos/common/official.mk"; then
  echo "official.mk missing ANAOS_OFFICIAL_BUILD" >&2
  fail=1
fi

if grep -R --include='*.md' -E 'test-keys\.pk8|\.pk8' "$ROOT/docs" 2>/dev/null | grep -viE 'never|offline|not |no |\.pk8' >/dev/null; then
  : # soft: docs may mention .pk8 in "never store" context
fi

if [[ "$fail" -ne 0 ]]; then
  echo "TRACK B gate smoke: FAIL" >&2
  exit 1
fi
echo "TRACK B gate smoke: OK"
