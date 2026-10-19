#!/usr/bin/env python3
"""Local mock for releases.anaos.org metadata (engineering only).

Hosts must still match Updater allowlist when testing on-device — use
/etc/hosts or a reverse proxy. Default serves fixtures over loopback for
curl / validator checks.
"""
from __future__ import annotations

import argparse
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FIXTURE_ROOT = ROOT / "fixtures" / "ota"


class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(FIXTURE_ROOT), **kwargs)


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--port", type=int, default=8765)
    args = p.parse_args()
    httpd = ThreadingHTTPServer(("127.0.0.1", args.port), Handler)
    print(f"serving {FIXTURE_ROOT} on http://127.0.0.1:{args.port}/")
    print("example: GET /stable/emulator/metadata.json")
    httpd.serve_forever()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
