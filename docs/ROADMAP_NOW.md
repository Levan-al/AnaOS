# Near-term action plan

Last updated: **2026-10-19**. Not a substitute for `PLAN.yaml`.
Phase D: [`PHASE_D.md`](PHASE_D.md) · [`ACTION_PLAN_PHASE_D.md`](ACTION_PLAN_PHASE_D.md).  
Gap audit: [`PLAN_V2_GAP_REPORT.md`](PLAN_V2_GAP_REPORT.md).

## Snapshot

| Gate | State |
| --- | --- |
| Stock `BUILD_OK` | Done |
| Overlay + `super.img` | Done (`OVERLAY_BUILD_OK`) |
| Artifacts local | `anaos-emulator-out/` |
| CPX62 deleted | Done |
| API token `AnaOS-build` | Revoked |
| Phase C prep | Done (air-gap pack, gate, pin log) |
| **Phase D** | **Active** — gap-close in meta |

---

## Phase A / B / C — Closed or absorbed

Bring-up finished; Phase C meta prep landed. Do **not** re-rent a build host
until AOSP17 pin or device work needs it (`COST_OPS.md`).

---

## Phase D — Gap-close (active)

| ID | Item | Exit |
| --- | --- | --- |
| D1 | Honest PLAN + BUILD_HOST | Statuses match evidence |
| D2 | Updater fixtures + validator | meta-ci green |
| D3 | adevtool CLI | unittest green |
| D4 | shiba sepolicy/init stubs | `.te` + `init.anaos.rc` |
| D5 | CDN templates + website | `infra/cdn`, `website/` |
| D6 | Kernel manifest example | `kernel/manifests/` |
| D7 | AOSP17 pin sidecar | `pin-android-17.0.0_r1.xml` |
| D8 | Gate + docs + canvas | ROADMAP + gap canvas |

### Still human / blocked

| Priority | Item | Blocked on |
| --- | --- | --- |
| P0 | Air-gap key ceremony | Offline machine + two people |
| P0 | Track B ACK on promote | Human |
| P1 | AOSP17 host sync | New rental / disk |
| P1 | adevtool extract blobs | Local Pixel factory image |
| P2 | Domains TASK_002 | Purchase |
| P3 | Browser/WebView | Separate machine |

### Explicit non-goals

- Re-create CPX62 “just because”  
- Generate `.pk8` on a networked machine  
- Claim device lock from emulator images  
- Chromium beside AOSP on 32G RAM  
