#!/usr/bin/env bash
# Pin reproducible release environment (TASK_017 / TRACK A).
# Usage: source scripts/release-env.sh 20261016 00 [manifest-tag]
# Example: source scripts/release-env.sh 20261016 00 android-17.0.0_r1
set -euo pipefail
DAY="${1:-$(date -u +%Y%m%d)}"
SEQ="${2:-00}"
# Default empty = bring-up tree; official releases should set AOSP 17 tag (see AOSP17_TAG_SHORTLIST.md)
export ANAOS_MANIFEST_TAG="${3:-${ANAOS_MANIFEST_TAG:-}}"
export BUILD_DATETIME="${DAY}000000"
export BUILD_NUMBER="${DAY}${SEQ}"
export ANAOS_OFFICIAL_BUILD=true
echo "BUILD_DATETIME=$BUILD_DATETIME"
echo "BUILD_NUMBER=$BUILD_NUMBER"
echo "ANAOS_OFFICIAL_BUILD=$ANAOS_OFFICIAL_BUILD"
echo "ANAOS_MANIFEST_TAG=${ANAOS_MANIFEST_TAG:-<(unset — not for official pin)>}"
