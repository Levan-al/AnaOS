#!/usr/bin/env python3
"""Unit tests for validate_update_metadata.py."""
from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from validate_update_metadata import main, validate

ROOT = Path(__file__).resolve().parents[1]
FIXTURES = ROOT / "fixtures" / "ota" / "stable" / "emulator"


class ValidateTests(unittest.TestCase):
    def test_good_fixture(self) -> None:
        data = json.loads((FIXTURES / "metadata.json").read_text(encoding="utf-8"))
        self.assertEqual(validate(data, "stable"), [])

    def test_bad_host(self) -> None:
        data = json.loads((FIXTURES / "metadata.bad-host.json").read_text(encoding="utf-8"))
        errs = validate(data, "stable")
        self.assertTrue(any("allowlist" in e for e in errs))

    def test_channel_mismatch(self) -> None:
        data = json.loads(
            (FIXTURES / "metadata.channel-mismatch.json").read_text(encoding="utf-8")
        )
        errs = validate(data, "stable")
        self.assertTrue(any("mismatch" in e for e in errs))

    def test_cli_good(self) -> None:
        self.assertEqual(main([str(FIXTURES / "metadata.json"), "--channel", "stable"]), 0)

    def test_cli_expect_fail(self) -> None:
        self.assertEqual(
            main(
                [
                    str(FIXTURES / "metadata.bad-host.json"),
                    "--channel",
                    "stable",
                    "--expect-fail",
                ]
            ),
            0,
        )

    def test_min_build_reject(self) -> None:
        with tempfile.TemporaryDirectory() as td:
            path = Path(td) / "m.json"
            path.write_text(
                json.dumps(
                    {
                        "buildNumber": "2026010100",
                        "channel": "stable",
                        "downloadUrl": "https://dl.anaos.org/ota/x.bin",
                        "sha256": "a" * 64,
                        "minBuildNumber": "2026100100",
                    }
                ),
                encoding="utf-8",
            )
            self.assertNotEqual(main([str(path), "--channel", "stable"]), 0)


if __name__ == "__main__":
    unittest.main()
