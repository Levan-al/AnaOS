#!/usr/bin/env python3
"""
AnaOS adevtool scaffold (TASK_027 / TASK_029).

Runnable in the meta repo without factory blobs. Extract requires a local
Pixel factory image path supplied by the operator — never committed.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path
from urllib.parse import urlparse

ALLOWED_DOWNLOAD_HOSTS = frozenset(
    {
        "dl.google.com",
        "developers.google.com",
        "dl.anaos.org",
    }
)

DEVICES = {
    "shiba": {
        "codename": "shiba",
        "product": "ana_shiba",
        "pixel": "Pixel 8",
        "board": "zuma",
    }
}


def cmd_list_devices(_: argparse.Namespace) -> int:
    for name, meta in DEVICES.items():
        print(f"{name}\t{meta['pixel']}\tboard={meta['board']}\tproduct={meta['product']}")
    return 0


def cmd_verify_hashes(args: argparse.Namespace) -> int:
    manifest = Path(args.manifest)
    if not manifest.is_file():
        print(f"missing manifest: {manifest}", file=sys.stderr)
        return 1
    data = json.loads(manifest.read_text(encoding="utf-8"))
    base = Path(args.base) if args.base else manifest.parent
    fail = 0
    for entry in data.get("files", []):
        rel = entry["path"]
        expected = entry["sha256"].lower()
        path = base / rel
        if not path.is_file():
            print(f"MISSING {rel}", file=sys.stderr)
            fail = 1
            continue
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        if digest != expected:
            print(f"MISMATCH {rel}: got {digest} expected {expected}", file=sys.stderr)
            fail = 1
        else:
            print(f"OK {rel}")
    return fail


def cmd_fetch_dry_run(args: argparse.Namespace) -> int:
    url = args.url
    uri = urlparse(url)
    if uri.scheme != "https":
        print("REFUSE: only https URLs", file=sys.stderr)
        return 1
    host = (uri.hostname or "").lower()
    if host not in ALLOWED_DOWNLOAD_HOSTS:
        print(f"REFUSE: host not allowlisted: {host}", file=sys.stderr)
        return 1
    print(f"DRY-RUN OK would fetch: {url}")
    print("(adevtool does not download in meta scaffold — use local factory image)")
    return 0


def cmd_extract(args: argparse.Namespace) -> int:
    image = Path(args.factory_image)
    out = Path(args.out)
    device = args.device
    if device not in DEVICES:
        print(f"unknown device: {device}", file=sys.stderr)
        return 1
    if not image.is_file():
        print(
            f"factory image not found: {image}\n"
            "Download Pixel factory image locally, then re-run.\n"
            "Do not commit proprietary blobs to the AnaOS meta git tree.",
            file=sys.stderr,
        )
        return 2
    out.mkdir(parents=True, exist_ok=True)
    plan = {
        "device": device,
        "source": str(image.resolve()),
        "out": str(out.resolve()),
        "steps": [
            "unzip factory image",
            "extract vendor*.img / radio / bootloader",
            "generate proprietary-files.txt hashes",
            "emit device/anaos/<codename> BoardConfig fragments",
        ],
        "status": "planned_only",
        "note": "Full extract lands when AOSP17 host + GrapheneOS adevtool fork are synced",
    }
    plan_path = out / "extract-plan.json"
    plan_path.write_text(json.dumps(plan, indent=2) + "\n", encoding="utf-8")
    print(f"wrote {plan_path} (scaffold — no blobs extracted)")
    return 0


def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(prog="adevtool", description=__doc__)
    sub = p.add_subparsers(dest="cmd", required=True)

    s = sub.add_parser("list-devices", help="list supported codenames")
    s.set_defaults(func=cmd_list_devices)

    s = sub.add_parser("verify-hashes", help="verify sha256 manifest against files")
    s.add_argument("manifest", help="JSON with files[].path + files[].sha256")
    s.add_argument("--base", default=None, help="base directory for paths")
    s.set_defaults(func=cmd_verify_hashes)

    s = sub.add_parser("fetch", help="dry-run validate factory image URL")
    s.add_argument("url")
    s.set_defaults(func=cmd_fetch_dry_run)

    s = sub.add_parser("extract", help="scaffold extract plan (needs local factory zip)")
    s.add_argument("--device", default="shiba")
    s.add_argument("--factory-image", required=True)
    s.add_argument("--out", default="out/adevtool-extract")
    s.set_defaults(func=cmd_extract)

    return p


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    return int(args.func(args))


if __name__ == "__main__":
    raise SystemExit(main())
