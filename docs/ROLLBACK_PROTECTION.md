# Rollback protection (TASK_072)

Devices must not install older AnaOS builds that re-expose fixed vulnerabilities.

## Surfaces

| Surface | Mechanism |
| --- | --- |
| AVB / vbmeta | Rollback index in verified boot metadata |
| OTA package | `ota_metadata` / postinstall checks |
| Updater app | Compare `buildNumber` / security patch level before apply |
| Factory sideload | CLI/WebUSB warn or refuse older than device anti-rollback |

## Updater rules (scaffold direction)

- Reject `buildNumber` < current (unless emergency downgrade token — not in MVP).  
- Honor `minBuildNumber` on metadata (`UpdateMetadata`).  
- Hybrid PQ verify does **not** weaken classical rollback checks.  

## Release process

Each signed release bumps:

1. `BUILD_NUMBER` / datetime pins  
2. AVB rollback index when required by platform  
3. Published “minimum supported” for staged cohorts (`DISTRIBUTION.md`)  

## Testing

Automated boot/OTA/VB flow (TASK_079) must include:

- [ ] Attempt install of older OTA → fail closed  
- [ ] Same-version reinstall allowed only if policy says so  
- [ ] Locked device still enforces indexes  

Related: `FACTORY_IMAGE.md`, `UPDATE_SERVER.md`, `AVB_BOOTLOADER_LOCK.md`.
