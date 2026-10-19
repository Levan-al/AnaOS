# AnaOS status report

Last updated: **2026-10-19** (Phase D gap-close).

## Verdict

Bring-up **closed**. Phase C prep **closed**. **Phase D active** — executable
gap-report items landed in meta (tests green). Still **not** a signed Pixel image.

## Phases

| Phase | State |
| --- | --- |
| A — stock + overlay compile | Done |
| B — pull + teardown | Done |
| C — air-gap / pin / gate prep | Done |
| D — gap-close (meta) | **In progress** — see [`PHASE_D.md`](PHASE_D.md) |

## Phase D landed

- `ACTION_PLAN_PHASE_D.md` + `PHASE_D.md`  
- Honest `PLAN.yaml` demotions + fixed `BUILD_HOST.md` (host deleted)  
- Updater: `BuildNumber`, `HttpsMetadataFetcher`, asset fixture self-test  
- `fixtures/ota/` + `validate_update_metadata.py` + mock server  
- `adevtool/adevtool.py` CLI + unit tests  
- shiba `sepolicy/*.te` + `init.anaos.rc`  
- `website/` static scaffold + `infra/cdn/` templates  
- `kernel/manifests/` example + `pin-android-17.0.0_r1.xml`  
- meta-ci runs OTA + adevtool tests  

## Still human / blocked

| Item | Needs |
| --- | --- |
| Key ceremony | Offline machine + two people |
| AOSP17 sync | New build host + disk |
| shiba vendor extract | Local factory image + full adevtool |
| Domains | Purchase decision |
| Signed factory / VB green | Ceremony + device flash |

## Local artifacts

`anaos-emulator-out/`: overlay OK from bring-up. Prefer `super.img` for smoke.
