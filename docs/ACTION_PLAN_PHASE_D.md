# Action plan (Phase D) — execute now

Derived from canvas **AnaOS-Plan-v2-Gap-Report** high-signal gaps + critical path.

## Must finish in this sprint (meta)

1. **D1 Honesty** — rewrite `BUILD_HOST.md`; demote overmarked `PLAN.yaml` tasks  
2. **D2 Updater** — fixtures, `validate_update_metadata.py`, asset self-test, rollback compare  
3. **D3 adevtool** — Python CLI + unit tests (no factory blobs in git)  
4. **D4 Sepolicy/init** — `device/anaos/shiba/sepolicy/*.te`, `init/init.anaos.rc`  
5. **D5 CDN/website** — `infra/cdn/*`, `website/` static scaffold  
6. **D6 Kernel** — `kernel/manifests/` example + docs checkboxes for skeleton only  
7. **D7 Manifest pin** — AOSP17 pin include sidecar  
8. **D8 Gate/docs/canvas** — wire CI; refresh ROADMAP + gap canvas  

## After this sprint (human)

| Step | Owner |
| --- | --- |
| Air-gap ceremony | Two people + offline PC |
| Rent AOSP17 host | When ready to sync pin |
| Pixel factory image | Local download for adevtool extract |
| Domain purchase | Optional until public OTA |

## Success metric

meta-ci green; Phase D checklist in `PHASE_D.md` all checked; gap canvas
reflects new evidence (not claim of signed device).
