# device/anaos

AnaOS product and device makefiles.

| Path | Purpose |
| --- | --- |
| `common/` | Shared product/board fragments |
| `emulator/` | Emulator lunch target (first user build — TASK_018) |
| `shiba/` | Pixel 8 — first official device stub (TASK_028) |
| `<codename>/` | Additional devices (TASK_028+) |

Full inheritance requires a synced AOSP tree (`repo sync` via `platform_manifest`).
