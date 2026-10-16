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
| Failure triage | `BUILD_FAILURE_PLAYBOOK.md` |

## After BUILD_OK or hard fail

1. Confirm artifacts / logs needed.  
2. Optional: `META=...` → `POST_BUILD_OVERLAY.md` then AnaOS lunch rebuild.  
3. Emulator smoke: `EMULATOR_SMOKE.md`.  
4. **Delete** `anaos-build` in Hetzner Console (or snapshot then delete).  
5. Revoke API token `AnaOS-build` when rental ends (`BUILD_HOST.md`).  

Power-off alone may still bill — prefer delete.

## Parallel work (cheap)

Docs, app scaffolds, and planning on the workstation while `m` runs — do **not**
start a second AOSP tree or Chromium build on the same CPX62.

## Do not

- Leave a stuck ninja for hours without watchdog  
- Run private key ceremony on the rental host  
- Keep the CPX62 overnight after a conclusive run without a scheduled job  
- Build Browser/WebView Chromium beside AOSP on 32GB RAM  
