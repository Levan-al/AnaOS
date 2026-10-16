# Distribution pipeline (TASK_067–072)

Extends `UPDATE_SERVER.md`.

| TASK | Feature | Notes | Detail |
| --- | --- | --- | --- |
| 067 | Delta updates | bsdiff/courgette-style; fallback to full | this |
| 068 | Staged rollout | percentage / cohort in metadata | this |
| 069 | Factory + OTA automation | CI builds unsigned → offline sign → upload | `FACTORY_IMAGE.md` |
| 070 | WebUSB installer | Browser flash for supported Pixels | `WEBUSB_INSTALLER.md` |
| 071 | CLI installer | `anaos-flash` script + docs | `INSTALL_CLI.md` |
| 072 | Rollback protection | anti-rollback indexes; Updater enforces | `ROLLBACK_PROTECTION.md` |

## MVP order

1. Full OTA only (067 later)  
2. Manual upload (069 automation later)  
3. CLI install docs before WebUSB  

## Staged rollout (068)

Metadata fields (draft): `cohort`, `percent`, `minBuildNumber`.
Updater draws sticky cohort from device id hash (privacy: no server-side
PII). Emergency stop = publish empty channel manifest.

## Delta updates (067)

Ship full packages first. Deltas only when storage + CPU cost justified and
verify path covers both full and delta signatures.

## Security

Track B gate on any installer that disables AVB or uses test-keys.
CDN layout: `ARTIFACT_CDN.md`.
