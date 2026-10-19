# Away / sleep mode (unattended bring-up)

Aligned with [`ROADMAP_NOW.md`](ROADMAP_NOW.md) Phase A.

## Active automation

| Piece | Where | Role |
| --- | --- | --- |
| `aosp-overlay` | Hetzner tmux | `anaos_emulator` `m -j4` (retry after partition fix) |
| `aosp-overlay-finish` | Hetzner tmux | Seals `OVERLAY_BUILD_OK` / `FAIL`, writes `SLEEP_REPORT.txt` |
| `aosp-watchdog` | Hetzner tmux | Stall watchdog (stock path; leave alone) |

## Will do alone

- Finish overlay compile if it succeeds  
- Write `/opt/anaos/SLEEP_REPORT.txt` + `BRINGUP.txt`  

## Will NOT do alone

- Delete Hetzner server (you — `COST_OPS.md`)  
- Air-gap key ceremony  
- Device flash / AVB lock  
- Second AOSP sync  

## When you return

1. `ssh anaos-build 'cat /opt/anaos/SLEEP_REPORT.txt; ls /opt/anaos/OVERLAY_BUILD_*'`  
2. If OK → [`ARTIFACT_PULL.md`](ARTIFACT_PULL.md) → delete CPX62  
3. If FAIL → log tail; one retry only if clear fix; else delete same day  
