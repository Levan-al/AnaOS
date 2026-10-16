# Away / sleep mode (unattended bring-up)

What runs without you at the keyboard.

## Active automation

| Piece | Where | Role |
| --- | --- | --- |
| `aosp-overlay` | Hetzner tmux | `anaos_emulator` `m -j4` |
| `aosp-overlay-finish` | Hetzner tmux | Seals `OVERLAY_BUILD_OK` / `FAIL`, writes `SLEEP_REPORT.txt` |
| `aosp-watchdog` | Hetzner tmux | Stall watchdog (stock build path) |
| Agent 5m loop | Local Cursor | Status ticks until stopped |

## Will do alone

- Finish overlay compile if it succeeds  
- Write `/opt/anaos/SLEEP_REPORT.txt` + `BRINGUP.txt`  
- Report percent on each 5m tick  

## Will NOT do alone

- Delete Hetzner server (billing stop = **you** in console — `COST_OPS.md`)  
- Air-gap key ceremony  
- Device flash / AVB lock  
- Spend money on a second AOSP sync  

## Morning checklist

1. `ssh anaos-build 'cat /opt/anaos/SLEEP_REPORT.txt'`  
2. If `OVERLAY_BUILD_OK` → smoke later; **delete CPX62** when satisfied  
3. If `OVERLAY_BUILD_FAIL` → read `overlay-build.log` tail; decide retry vs delete  
