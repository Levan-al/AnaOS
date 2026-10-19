#!/usr/bin/env python3
"""Validate AnaOS OTA metadata JSON (mirror of Updater allowlist rules)."""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from urllib.parse import urlparse

ALLOWED_HOSTS = frozenset({"releases.anaos.org", "dl.anaos.org"})
ALLOWED_CHANNELS = frozenset({"stable", "beta"})


def is_allowed_url(url: str) -> bool:
    try:
        uri = urlparse(url)
    except Exception:
        return False
    return uri.scheme.lower() == "https" and (uri.hostname or "").lower() in ALLOWED_HOSTS


def build_number_ge(a: str, b: str) -> bool:
    """Lexicographic compare for AnaOS YYYYMMDDNN build numbers."""
    return a >= b


def validate(data: dict, expected_channel: str | None = None) -> list[str]:
    errors: list[str] = []
    for key in ("buildNumber", "channel", "downloadUrl", "sha256"):
        if key not in data or data[key] in (None, ""):
            errors.append(f"missing required field: {key}")
    channel = str(data.get("channel", "")).lower()
    if channel and channel not in ALLOWED_CHANNELS:
        errors.append(f"unknown channel: {channel}")
    if expected_channel and channel and channel != expected_channel.lower():
        errors.append(f"channel mismatch: got {channel} expected {expected_channel}")
    url = data.get("downloadUrl")
    if isinstance(url, str) and url and not is_allowed_url(url):
        errors.append(f"downloadUrl host not in AnaOS allowlist: {url}")
    sha = data.get("sha256")
    if isinstance(sha, str) and sha and len(sha) != 64:
        errors.append("sha256 must be 64 hex chars")
    min_bn = data.get("minBuildNumber")
    bn = data.get("buildNumber")
    if isinstance(min_bn, str) and isinstance(bn, str) and min_bn and bn:
        if not build_number_ge(bn, min_bn):
            errors.append(f"buildNumber {bn} older than minBuildNumber {min_bn}")
    return errors


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("path", type=Path, help="metadata.json path")
    p.add_argument("--channel", default=None, help="expected channel")
    p.add_argument("--expect-fail", action="store_true", help="invert exit (for bad fixtures)")
    args = p.parse_args(argv)
    data = json.loads(args.path.read_text(encoding="utf-8"))
    errors = validate(data, args.channel)
    ok = not errors
    if args.expect_fail:
        if ok:
            print(f"FAIL: expected validation errors for {args.path}", file=sys.stderr)
            return 1
        print(f"OK (rejected as expected): {args.path}")
        for e in errors:
            print(f"  - {e}")
        return 0
    if not ok:
        print(f"INVALID: {args.path}", file=sys.stderr)
        for e in errors:
            print(f"  - {e}", file=sys.stderr)
        return 1
    print(f"OK: {args.path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
