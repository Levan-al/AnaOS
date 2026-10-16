# App signing keys (TASK_022)

First-party AnaOS apps that need a stable signing identity get **dedicated** keys, separate from `platform` / `releasekey`. Generation is air-gapped only (`script/make_anaos_app_keys.sh`).

## Key → package map

| Key basename | Application ID | Notes |
| --- | --- | --- |
| `updater` | `org.anaos.updater` | OTA client; high integrity |
| `auditor` | `org.anaos.auditor` | Attestation identity |
| `camera` | `org.anaos.camera` | Privileged camera |
| `appstore` | `org.anaos.appstore` | App distribution trust |
| `pdfviewer` | `org.anaos.pdfviewer` | Sandboxed viewer |

Other system packages may use `platform` or `releasekey` until a dedicated key is justified.

## Ceremony notes

1. Run after platform / AVB / OTA keys (`TASK_019`–`021`).
2. Same certificate subject as platform keys (see `KEY_CEREMONY.md`).
3. Publish only `*.x509.pem` fingerprints with the public key inventory (TASK_073).
4. Never place `*.pk8` on Hetzner, CI, or developer workstations used for day-to-day coding.

## Build wiring (later)

Product makefiles / `sign_target_files_apks` extras map these PEMs to APKs once the platform tree includes AnaOS packages. Until then this doc + script are the contract.
