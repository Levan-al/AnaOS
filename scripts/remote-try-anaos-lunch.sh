#!/usr/bin/env bash
set -euo pipefail
export PATH="/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"
bash /opt/anaos/remote-stage-meta.sh
META=/opt/anaos/meta bash /opt/anaos/post-build-overlay.sh
cd /opt/anaos/aosp
set +u
# shellcheck disable=SC1091
source build/envsetup.sh
set +e
lunch anaos_emulator-trunk_staging-userdebug >/tmp/anaos-lunch.out 2>&1
rc=$?
set -e
echo "lunch_rc=$rc"
tail -n 40 /tmp/anaos-lunch.out
if grep -q 'error:' /tmp/anaos-lunch.out; then
  echo LUNCH_HAS_ERRORS
  exit 1
fi
echo LUNCH_CLEAN
date -u +%Y-%m-%dT%H:%M:%SZ > /opt/anaos/OVERLAY_LUNCH_OK
echo "lunch=anaos_emulator-trunk_staging-userdebug" > /opt/anaos/OVERLAY_LUNCH_META
