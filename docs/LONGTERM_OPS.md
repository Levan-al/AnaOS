# Long-term operations (TASK_090–093)

| TASK | Process | Detail |
| --- | --- | --- |
| 090 | Monthly security bulletin merge | `MONTHLY_SECURITY_PATCHES.md` |
| 091 | New Android version port | `ANDROID_VERSION_PORT.md`, `AOSP17_ADAPTATION.md` |
| 092 | New Pixel / hardware generation | `HARDWARE_GENERATION.md` |
| 093 | Community + enterprise channels | `COMMUNITY_SUPPORT.md` |

Cadence owned by maintainers; Track B veto remains on every promote.

## Calendar (steady state)

| Rhythm | Work |
| --- | --- |
| Monthly | ASP pipeline + staged OTA |
| Per major Android | Full port playbook |
| Per Pixel gen | Hardware generation checklist |
| Continuous | Issues / security@ / Discussions |

## Hosting cost

Ephemeral build hosts; tear down after release (`COST_OPS.md`).
Do not keep CPX62 idle “just in case.”

## Metrics to track (later)

- Days bulletin → signed OTA  
- Open critical vulns age  
- Reproducible build match rate  
