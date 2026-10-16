# Near-term roadmap (bring-up window)

Honest next steps while Hetzner emulator `m` runs. Not a substitute for
`PLAN.yaml`.

## Now (blocked on BUILD_OK)

1. Keep watchdog; do not second-sync AOSP 17 on same disk  
2. Parallel docs/scaffolds only (this meta repo)  

## Immediately after BUILD_OK

1. `POST_BUILD_OVERLAY.md` → `OVERLAY_OK`  
2. `lunch anaos_emulator-userdebug` (or documented name) + `m -j4`  
3. `EMULATOR_SMOKE.md`  
4. Snapshot logs; **delete or schedule** CPX62 (`COST_OPS.md`)  

## Next engineering (order)

| Priority | Item |
| --- | --- |
| P0 | Air-gap key ceremony (when ready for signed images) |
| P0 | Track B gate on any promote |
| P1 | AOSP 17 pin + rebase ledger (`AOSP17_*`) |
| P1 | `adevtool` + `shiba` vendor |
| P2 | Domains (TASK_002) before public OTA |
| P2 | Updater real client + CDN |
| P3 | Browser/WebView on dedicated host |

## Do not prioritize yet

- Public website polish  
- Bug bounty payouts  
- Chromium on the AOSP host  
- Claiming device lock without signed `shiba` image  
