# Build failure playbook (TASK_018 ops)

How to triage Hetzner / build-host failures without wasting billable time.

## Symptoms → actions

| Symptom | Action |
| --- | --- |
| Log mtime stale >30–60m, ninja quiet | Check OOM/`dmesg`; watchdog should flag; restart `m -j2` if needed |
| `No space left` | `df -h`; delete stale `out/` only if intentional; else larger disk |
| HTTP 429 during sync | `remote-repair-retry.sh` / backoff — not a compile issue |
| `bash\r` / CRLF | LF fix + `.gitattributes` |
| Compile error in single target | Capture 80 log lines; fix or file issue; don’t reboot host blindly |
| Envsetup / lunch missing | Re-source; verify PATH; see `remote-aosp-build.sh` |

## After hard fail

1. Keep `/opt/anaos/build.log` (or download)  
2. Note last `%` and target in `STATUS_REPORT.md`  
3. Decide: retry vs delete host (`COST_OPS.md`)  
4. Do **not** leave CPX62 idle overnight “to think”  

## After BUILD_OK

Follow `POST_BUILD_OVERLAY.md` then `EMULATOR_SMOKE.md`.
