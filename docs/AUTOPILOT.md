# Unattended autopilot (Phases A–B)

Runs the bring-up plan without keyboard input.

## Pieces

| Piece | Role |
| --- | --- |
| `scripts/remote-autopilot.sh` (tmux `aosp-autopilot`) | Watch overlay; auto-retry **one** partition/`super.img` failure (bump to 4096 MiB); pack `/opt/anaos/artifacts-ready`; write `SLEEP_REPORT.txt` |
| `scripts/local-autopilot.ps1` | On each agent tick: status; on OK/ABORT → pull artifacts → delete VM if token present |
| Cursor 5m loop | Wakes agent to run local autopilot + fix unexpected failures |

## Delete token (required for full hands-off)

Set **one** of:

```powershell
$env:HCLOUD_TOKEN = "<AnaOS-build token>"
# or
# file: secrets/hcloud_token   (gitignored)
```

Without it: artifacts still pull; delete is marked `DELETE_PENDING.txt` until token is available.

## Phase C

Air-gap key ceremony **cannot** run unattended (physical offline). Autopilot stops after Phase B.

## Stop

Kill tmux `aosp-autopilot` on the host; stop the local Cursor loop.
