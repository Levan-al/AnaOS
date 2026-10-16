#!/usr/bin/env bash
# Pin reproducible release environment (TASK_017).
# Usage: source scripts/release-env.sh 20261016 00
set -euo pipefail
DAY="${1:-$(date -u +%Y%m%d)}"
SEQ="${2:-00}"
export BUILD_DATETIME="${DAY}000000"
export BUILD_NUMBER="${DAY}${SEQ}"
export ANAOS_OFFICIAL_BUILD=true
echo "BUILD_DATETIME=$BUILD_DATETIME"
echo "BUILD_NUMBER=$BUILD_NUMBER"
echo "ANAOS_OFFICIAL_BUILD=$ANAOS_OFFICIAL_BUILD"
