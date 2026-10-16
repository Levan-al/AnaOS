# device/anaos

AnaOS product and device makefiles.

| Path | Purpose |
| --- | --- |
| `common/` | Shared product/board fragments |
| `emulator/` | Emulator lunch target (first user build — TASK_018) |
| `<codename>/` | Real devices (TASK_028+) |

Full inheritance requires a synced AOSP tree (`repo sync` via `platform_manifest`).
