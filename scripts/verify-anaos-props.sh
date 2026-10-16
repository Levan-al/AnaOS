#!/usr/bin/env bash
# After emulator/device boot: check AnaOS branding props via adb.
# Usage: bash scripts/verify-anaos-props.sh [serial]
set -euo pipefail
ADB=(adb)
if [[ "${1:-}" != "" ]]; then ADB=(adb -s "$1"); fi

fail=0
need_prop() {
  local key="$1" expect="$2"
  local got
  got="$("${ADB[@]}" shell getprop "$key" | tr -d '\r')"
  if [[ "$got" != *"$expect"* ]]; then
    echo "FAIL $key: got='$got' want~='$expect'" >&2
    fail=1
  else
    echo "OK   $key=$got"
  fi
}

"${ADB[@]}" get-state >/dev/null

need_prop ro.product.brand Ana
need_prop ro.product.manufacturer AnaOS
# official may be 0 on eng; brand still required
fp="$("${ADB[@]}" shell getprop ro.build.fingerprint | tr -d '\r')"
echo "fingerprint=$fp"
if echo "$fp" | grep -qi graphene; then
  echo "FAIL fingerprint mentions GrapheneOS" >&2
  fail=1
fi

if [[ "$fail" -ne 0 ]]; then
  echo "verify-anaos-props: FAIL" >&2
  exit 1
fi
echo "verify-anaos-props: OK"
