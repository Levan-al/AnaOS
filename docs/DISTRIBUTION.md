# Distribution pipeline (TASK_067–072)

Extends `UPDATE_SERVER.md`.

| TASK | Feature | Notes |
| --- | --- | --- |
| 067 | Delta updates | bsdiff/courgette-style; fallback to full |
| 068 | Staged rollout | percentage / cohort in metadata |
| 069 | Factory + OTA automation | CI builds unsigned → offline sign → upload |
| 070 | WebUSB installer | Browser flash for supported Pixels |
| 071 | CLI installer | `anaos-flash` script + docs |
| 072 | Rollback protection | anti-rollback indexes; Updater enforces |

## MVP order

1. Full OTA only (067 later)  
2. Manual upload (069 automation later)  
3. CLI install docs before WebUSB  

## Security

Track B gate on any installer that disables AVB or uses test-keys.
