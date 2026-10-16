# App signing keys (TASK_022)

First-party AnaOS apps that need a stable signing identity get **dedicated**
keys, separate from `platform` / `releasekey`. Generation is air-gapped only
(`script/make_anaos_app_keys.sh`).

## Key → package map

| Key basename | Application ID | Notes |
| --- | --- | --- |
| `updater` | `org.anaos.updater` | OTA client; high integrity |
| `auditor` | `org.anaos.auditor` | Attestation identity |
| `camera` | `org.anaos.camera` | Privileged camera |
| `appstore` | `org.anaos.appstore` | App distribution trust |
| `pdfviewer` | `org.anaos.pdfviewer` | Sandboxed viewer |
| `setupwizard` | `org.anaos.setupwizard` | Optional dedicated; else platform |
| `browser` | `org.anaos.browser` | When Vanadium port lands |
| `backup` | `org.anaos.backup` | When TASK_064 ships |
| `ai_*` | `org.anaos.ai.*` | Per-capability if network ever enabled |

Other system packages may use `platform` or `releasekey` until a dedicated key
is justified.

## Ceremony notes

1. Run after platform / AVB / OTA keys (`TASK_019`–`021`).  
2. Same certificate subject as platform keys (`KEY_CEREMONY.md`).  
3. Publish only `*.x509.pem` fingerprints with the public key inventory.  
4. Never place `*.pk8` on Hetzner, CI, or day-to-day laptops.  

## Build wiring (later)

Product makefiles / `sign_target_files_apks` extras map these PEMs to APKs once
the platform tree includes AnaOS packages. Until then this doc + script are the
contract.

## Rotation

Follow `KEY_ROTATION.md`. App key rotation must not break OTA trust roots
(Updater verifies OS packages with platform/otakey, not its own app key).
