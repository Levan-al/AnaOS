# AOSP 17 rebase conflict ledger (TASK_096 / TRACK A)

Living log for `anaos-aosp17-stage` → `anaos-aosp17`. Fill rows during each rebase;
empty rows mean the area has not been attempted yet.

Related: `docs/AOSP17_ADAPTATION.md`, `docs/AOSP17_TAG_SHORTLIST.md`,
`docs/SECURITY_MERGE_GATE.md`.

## Current pin intent

| Field | Value |
| --- | --- |
| P0 tag | `android-17.0.0_r1` |
| Staging branch | `anaos-aosp17-stage` |
| Release branch | `anaos-aosp17` |
| Bring-up tree | Closed — Hetzner `android-latest-release` → `BUILD_OK` + overlay OK (2026-10-19); host deleted |
| Re-init | **New** build host only; `repo init -b android-17.0.0_r1`; overlay meta @ current `main` |

## Conflict ledger

| Date (UTC) | Upstream area / path | Conflict summary | Resolution | Track B impact | Owner |
| --- | --- | --- | --- | --- | --- |
| 2026-10-19 | bring-up note | Emulator overlay required `BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE=3072MiB` on floating tip | Keep override in `anaos_emulator.mk` for 17 pin | partition / product size | meta |
| — | `bionic` / malloc hooks | _(pending first 17 rebase)_ | | hardened_malloc | |
| — | `system/sepolicy` | _(pending)_ | | SELinux enforcing | |
| — | `build/soong` / product config | _(pending)_ | | official.mk / branding | |
| — | `frameworks/base` privacy APIs | _(pending)_ | | PRIVACY_CONTROLS | |
| — | `external/boringssl` | _(pending)_ | | TLS / PQC P4 only | |
| — | kernel prebuilts / GKI | _(pending)_ | | KERNEL.md | |
| — | AVB / `external/avb` | _(pending)_ | | verified boot green | |

## Staging checklist (each rebase)

1. Record upstream manifest SHA and AnaOS overlay commit SHAs.  
2. Apply branding + `device/anaos` + hardening patches in fixed order.  
3. Log every non-trivial conflict in the table above.  
4. Emulator userdebug smoke (or note blocker).  
5. Complete Track B gate ACK before promoting to `anaos-aosp17`.  

## Notes

- Do not mark TASK_096 done until at least one real rebase pass against the P0 tag
  has entries (or an explicit “no conflict” row with evidence).  
- Prefer small topic commits on staging; squash only on promote.
