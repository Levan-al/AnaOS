# sepolicy for shiba (TASK_030)

Device-specific SELinux policy overlays for AnaOS on Pixel 8.

## Planned contents

- `private/` — device-private domains / neverallows expansions  
- `vendor/` — vendor HAL interfaces once blobs exist  
- `file_contexts` / `property_contexts` deltas as needed  

## Rules

- Base hardening stays in `platform_system_sepolicy` (TASK_045).  
- No permissive domains in official `user` builds.  
- Updater / Auditor domains land with app packaging (TASK_045 / TASK_060).  

Populate after vendor extract (TASK_029).
