# New Android version porting process (TASK_091)

Standard playbook when moving AnaOS to a new major Android / AOSP release.
First application: AOSP 17 (`AOSP17_ADAPTATION.md`).

## Phases

| Phase | Actions | Exit |
| --- | --- | --- |
| 1. Discover | Shortlist tags; read bulletin + release notes | Tag P0 chosen |
| 2. Stage | `anaos-aospN-stage` manifest branch | Sync OK on staging host |
| 3. Rebase | Apply branding, device, hardening; fill ledger | Conflict table updated |
| 4. Smoke | Emulator userdebug + SELinux enforcing | Boot + branding OK |
| 5. B gate | `SECURITY_MERGE_GATE.md` ACK | Written ACK |
| 6. Device | Port first SKU (`DEVICE_PORTING.md`) | userdebug on device |
| 7. Promote | `anaos-aospN` release branch + pin scripts | Pin recorded |
| 8. Sign | Offline factory/OTA (`FACTORY_IMAGE.md`) | Fingerprints published |

## Always keep separate

- Monthly ASP (`MONTHLY_SECURITY_PATCHES.md`) — security drops inside a major  
- Major port (this doc) — API / behavior / kernel generation changes  

## Roles

| Role | Responsibility |
| --- | --- |
| Track A | Speed of absorption, ledger hygiene |
| Track B | Veto regressions; gate promote |
| Track C | Re-validate PQC/AI assumptions after API breaks |

## Template issue checklist

Copy into GitHub issue when starting a port:

- [ ] P0 tag documented  
- [ ] Staging branch created  
- [ ] Ledger file linked  
- [ ] Emulator smoke  
- [ ] B gate ACK  
- [ ] First device plan  
- [ ] Cost/host plan (`COST_OPS.md`)  
