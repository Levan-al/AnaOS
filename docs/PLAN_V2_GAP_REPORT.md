# AnaOS Optimized Plan v2.0 — Gap Report

**Date:** 2026-10-19  
**Scope:** TASK_001–093 vs meta repo evidence  
**Also:** Cursor canvas `AnaOS-Plan-v2-Gap-Report.canvas.tsx`

## Verdict

Roughly **18–22%** of the 93-task Optimized Plan is truly done. The meta repo is a
strong documentation + bootstrap scaffold with a **real emulator overlay compile**
(`OVERLAY_BUILD_OK` 2026-10-19) and Phase C prep. It is **not** near a signed Pixel
image.

| Status | Count |
| --- | ---: |
| done | 8 |
| partial | 24 |
| stub_docs | 48 |
| blocked | 4 |
| not_started | 9 |

## Bucket estimates (% done)

| Bucket | % | Read |
| --- | ---: | --- |
| Foundation (1–3, 8–9) | ~70 | Branding, licenses, Issues; domains blocked; org personal |
| Infra (4–6) | ~25 | Meta-CI + deleted Hetzner burst; no live CDN |
| Source (10–17) | ~45 | Manifest/device/branding scaffolds; no AOSP17 pin tree |
| Build (18) | ~65 | Emulator overlay OK; userdebug; host gone |
| Signing (7, 19–26) | ~20 | Option A + scripts + public air-gap kit; no ceremony |
| Device (27–33) | ~10 | shiba stubs; no vendor/VB green |
| Kernel (34–39) | ~5 | KERNEL.md only |
| Sec/privacy (40–55) | ~8 | Policy checklists only |
| Apps (56–65) | ~20 | Gradle scaffolds; Updater richest |
| Dist/attest (66–75) | ~8 | Architecture docs |
| Docs/test/longterm (76–93) | ~15 | Broad stub corpus |

## Critical path → first signed device image

1. Offline key ceremony (019–023)  
2. New build host + `android-17.0.0_r1`  
3. Overlay + emulator smoke on pin (keep 3072MiB override)  
4. adevtool + shiba vendor (027–030)  
5. Unsigned device target-files (no keys on host)  
6. Offline sign factory/OTA (025→026)  
7. Flash + lock bootloader; `verifiedbootstate=green` (031–032)  

## Free-infra reference gaps

| Area | Chosen now | Still open |
| --- | --- | --- |
| CI/CD | GitHub Actions meta-ci | No AOSP runner |
| Artifact storage | Draft only | R2/OCI/Upstash + domains |
| Bug tracking | GitHub Issues | — |
| Community | Draft | Matrix/Bonfire/etc. |
| Fuzzing | Mentioned | OSS-Fuzz not enrolled |
| Signing | Option A air-gap | Ceremony not run; SignPath optional later |
| Compute | Paid Hetzner burst (deleted) | Next host still rental |

## Plan vs STRATEGY tensions

- `strict_order` vs parallel Tracks A∥B∥C  
- Plan paste v2.0 vs repo PLAN.yaml **2.1**  
- Floating bring-up tip ≠ release pin `android-17.0.0_r1`  
- PLAN.yaml often overmarks docs-only work as done  
- `zero_cost_infrastructure` vs paid bring-up  
- TASK_018 title “user” vs userdebug artifacts  

## Evidence notes

- No `.pk8` / private keys in tree (correct).  
- Local `anaos-emulator-out/` has `OVERLAY_BUILD_OK` + `super.img`; `system_dlkm.img` hash warn.  
- Phase C landed: air-gap pack script, Updater allowlist/parser, DNS zone example, AOSP17 pin log.  

Full task-by-task matrix was produced in the audit pass; keep this file as the
durable summary. Update when ceremony or AOSP17 host lands.
