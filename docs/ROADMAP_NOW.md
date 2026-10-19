# Near-term action plan (bring-up window)

Last updated: **2026-10-19**. Execution order below — do not skip phases.
Not a substitute for `PLAN.yaml` (full backlog).
Autopilot: [`AUTOPILOT.md`](AUTOPILOT.md).

## Snapshot

| Gate | State |
| --- | --- |
| Stock `BUILD_OK` | Done (2026-10-16) |
| Overlay lunch | Done (`anaos_emulator-trunk_staging-userdebug`) |
| Partition fix (3072 MiB) | Done (`79047cd`) |
| Overlay `m` retry | **Done** — `OVERLAY_BUILD_OK` 2026-10-19T14:22:56Z + `super.img` |
| Emulator smoke | Optional local (`EMULATOR_SMOKE.md`) |
| Pull artifacts + **delete CPX62** | Autopilot Phase B (needs `HCLOUD_TOKEN` for delete) |
| Air-gap / shiba / AOSP17 | Phase C — not fully unattended |

---

## Phase A — Now (while `m` runs)

**Owner:** agent + host automation. **Do not** start a second AOSP sync.

1. Keep `aosp-overlay` + `aosp-overlay-finish` alive  
2. Poll for `OVERLAY_BUILD_OK` or `OVERLAY_BUILD_FAIL`  
3. Parallel cheap meta work only (docs, scaffolds, this plan)  
4. On FAIL → triage log (esp. `super.img` / lpmake); fix; retry once; else stop billing  

**Success signal:** `/opt/anaos/OVERLAY_BUILD_OK` (+ optional `SLEEP_REPORT.txt`)

---

## Phase B — Immediately after overlay OK

**Owner:** autopilot (`remote-autopilot` + `local-autopilot.ps1`). **Cost-critical.**

1. Markers + packed `/opt/anaos/artifacts-ready`  
2. Pull to `anaos-emulator-out/` (see `ARTIFACT_PULL.md`)  
3. **Delete** `anaos-build` via Hetzner API when `HCLOUD_TOKEN` / `secrets/hcloud_token` present  
4. Revoke build API token when rental ends  

**Do not** claim device/AVB lock from emulator images alone.

---

## Phase C — Next engineering (after teardown)

| Priority | Item | Notes |
| --- | --- | --- |
| P0 | Air-gap key ceremony | Physical offline — `AIRGAP_PRACTICAL.md` |
| P0 | Track B security gate on any promote | `SECURITY_MERGE_GATE.md` |
| P1 | AOSP 17 pin + rebase ledger | `AOSP17_*` docs |
| P1 | `adevtool` + `shiba` vendor | Blocked on device tree / extract |
| P2 | Domains (TASK_002) before public OTA | |
| P2 | Updater real client + CDN | Scaffold exists under `apps/` |
| P3 | Browser/WebView | Dedicated host only — never beside AOSP on 32G |

---

## Explicit non-goals (this window)

- Public website polish  
- Bug bounty payouts  
- Chromium on the AOSP rental  
- Second full tree sync on CPX62  
- Release signing keys on the cloud host  

---

## Decision table

| If… | Then… |
| --- | --- |
| `OVERLAY_BUILD_OK` | Phase B → pull → delete |
| `OVERLAY_BUILD_FAIL` (partition again) | Bump size / fix mk → one retry |
| `OVERLAY_BUILD_FAIL` (other) | Capture log tail; decide retry vs delete same day |
| Idle >1h after conclusive OK/FAIL | Delete host (billing) |
