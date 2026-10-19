# Phase D — Gap-close action plan

Started: **2026-10-19**. Closes executable items from
[`PLAN_V2_GAP_REPORT.md`](PLAN_V2_GAP_REPORT.md) and the Gap Report canvas
**without** private keys, domain purchase, or a new Hetzner host.

## Goal

Turn stub_docs / partial high-signal gaps into **testable meta code + honest
plan status**, so the next human blockers (ceremony, AOSP17 host, vendor image)
have clear integration points.

## Work packages

| ID | Package | Plan tasks | Exit criteria |
| --- | --- | --- | --- |
| D1 | Honesty | PLAN.yaml, BUILD_HOST, canvas | Statuses match evidence; host doc historical |
| D2 | Updater offline CI | 060, 066, 077 | Fixtures + Python validator + asset self-test |
| D3 | adevtool CLI | 027, 029 | Runnable CLI: verify-hashes, dry-run fetch |
| D4 | Device stubs | 028, 030 | sepolicy `.te` + `init.anaos.rc` skeletons |
| D5 | CDN + website | 006, 089 | Templates under `infra/` + `website/` (no live DNS) |
| D6 | Kernel skeleton | 034, 039 | Example kernel manifest + prebuilt CI stub |
| D7 | Pin sidecar | 010, 017 | `platform_manifest/pin-android-17.0.0_r1.xml` |
| D8 | Gate + ROADMAP | 097 | Gate requires fixtures; ROADMAP → Phase D active |

## Explicit non-goals (still blocked)

- Generate or store `.pk8` / AVB private keys on a network machine  
- Register anaos.org or create Cloudflare R2 accounts  
- Re-rent CPX62 / claim device `verifiedbootstate=green`  
- Full AOSP sync or Chromium builds  

## Completion rule

A gap-report highlight moves from `stub_docs` / `partial` only when this file’s
exit criteria have evidence in-tree (tests green in meta-ci).

## Checklist (this sprint)

- [x] D1 Honesty — `BUILD_HOST.md`, `PLAN.yaml` demotions  
- [x] D2 Updater fixtures + validator + asset self-test  
- [x] D3 adevtool CLI + unittest  
- [x] D4 sepolicy `.te` + `init.anaos.rc`  
- [x] D5 `infra/cdn` + `website/`  
- [x] D6 kernel manifest example  
- [x] D7 AOSP17 pin sidecar  
- [x] D8 gate + ROADMAP + STATUS (+ canvas refresh)
