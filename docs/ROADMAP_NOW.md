# Near-term action plan

Last updated: **2026-10-19**. Not a substitute for `PLAN.yaml`.
Autopilot (bring-up): [`AUTOPILOT.md`](AUTOPILOT.md). Phase C tracker: [`PHASE_C.md`](PHASE_C.md).

## Snapshot

| Gate | State |
| --- | --- |
| Stock `BUILD_OK` | Done |
| Overlay + `super.img` | Done (`OVERLAY_BUILD_OK`) |
| Artifacts local | `anaos-emulator-out/` |
| CPX62 deleted | Done |
| API token `AnaOS-build` | Revoked |
| **Phase C** | **Active** |

---

## Phase A / B — Closed

Bring-up on Hetzner finished. Do **not** re-rent a build host until AOSP17 pin
or device work needs it (`COST_OPS.md`).

---

## Phase C — Next engineering (active)

| Priority | Item | Owner path | Blocked on |
| --- | --- | --- | --- |
| P0 | Air-gap key ceremony | `AIRGAP_PRACTICAL.md`, `scripts/pack-airgap-kit.sh` | Physical offline machine + two people |
| P0 | Track B gate on every promote | `SECURITY_MERGE_GATE.md`, `check-security-gate.sh` | Human ACK on real promote |
| P1 | AOSP 17 pin `android-17.0.0_r1` | `AOSP17_*` | New build host / disk |
| P1 | `adevtool` + `shiba` vendor | `adevtool/`, `VENDOR_EXTRACT.md` | Factory image + tool work |
| P2 | Domains TASK_002 | `DOMAINS.md`, `dns/anaos.org.zone.example` | Purchase decision |
| P2 | Updater client + CDN | `apps/Updater/`, `ARTIFACT_CDN.md` | Domains + signed metadata |
| P3 | Browser/WebView | dedicated host only | Separate machine |

### This meta sprint (no cloud keys, no new Hetzner)

1. Ceremony prep pack + readiness status  
2. Stronger Track B automation + PR checklist  
3. AOSP17 pin decision log post-bring-up  
4. adevtool / shiba implementation notes  
5. DNS zone example + Updater offline parser  

### Explicit non-goals now

- Re-create CPX62 “just because”  
- Generate `.pk8` on a networked machine  
- Claim device lock from emulator images  
- Chromium beside AOSP on 32G RAM  
