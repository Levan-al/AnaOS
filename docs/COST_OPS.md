# Cost operations (Hetzner build host)

Keep billable idle time low while TASK_018 runs.

## Active controls

| Control | Location |
| --- | --- |
| Build watchdog | tmux `aosp-watchdog` → `/opt/anaos/remote-build-watchdog.sh` |
| Status file | `/opt/anaos/STATUS.txt` |
| Build jobs | `ANAOS_BUILD_JOBS=4` (default in `remote-aosp-build.sh`) |
| Swap | 32G `/swapfile` (reduces OOM restarts) |
| Agent poll | every ~5 minutes while this session watches |

## After BUILD_OK or hard fail

1. Confirm artifacts / logs needed.  
2. Optional: `META=... bash scripts/post-build-overlay.sh` then AnaOS lunch rebuild.  
3. **Delete** `anaos-build` in Hetzner Console (or snapshot then delete).  
4. Revoke API token `AnaOS-build` when rental ends (`BUILD_HOST.md`).  

Power-off alone may still bill — prefer delete.

## Do not

- Leave a stuck ninja for hours without watchdog  
- Run private key ceremony on the rental host  
- Keep the CPX62 overnight after a successful/failed conclusive run without a plan  
