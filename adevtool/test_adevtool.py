#!/usr/bin/env python3
from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

import adevtool as ad


class AdevtoolTests(unittest.TestCase):
    def test_list_devices(self) -> None:
        self.assertEqual(ad.main(["list-devices"]), 0)

    def test_fetch_refuse_http(self) -> None:
        self.assertNotEqual(ad.main(["fetch", "http://dl.google.com/x.zip"]), 0)

    def test_fetch_refuse_evil(self) -> None:
        self.assertNotEqual(ad.main(["fetch", "https://evil.example/x.zip"]), 0)

    def test_fetch_ok(self) -> None:
        self.assertEqual(
            ad.main(["fetch", "https://dl.google.com/dl/android/aosp/shiba-factory.zip"]),
            0,
        )

    def test_verify_hashes(self) -> None:
        with tempfile.TemporaryDirectory() as td:
            base = Path(td)
            f = base / "blob.bin"
            f.write_bytes(b"anaos")
            digest = __import__("hashlib").sha256(b"anaos").hexdigest()
            manifest = base / "m.json"
            manifest.write_text(
                json.dumps({"files": [{"path": "blob.bin", "sha256": digest}]}),
                encoding="utf-8",
            )
            self.assertEqual(
                ad.main(["verify-hashes", str(manifest), "--base", str(base)]),
                0,
            )

    def test_extract_missing_image(self) -> None:
        self.assertEqual(
            ad.main(
                [
                    "extract",
                    "--device",
                    "shiba",
                    "--factory-image",
                    "/nonexistent/factory.zip",
                    "--out",
                    "/tmp/adevtool-test-out",
                ]
            ),
            2,
        )


if __name__ == "__main__":
    unittest.main()
