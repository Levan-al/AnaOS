# AnaOS build host notes

## Current state (2026-10-19)

**No active cloud build host.** Hetzner CPX62 `anaos-build` (id `170755575`,
`188.34.189.66`) was deleted after overlay bring-up. API token `AnaOS-build`
was revoked. Do **not** re-rent until AOSP17 pin sync or device work needs it
(`COST_OPS.md`, `RENT_BUILD_HOST.md`).

## Last host (historical)

| Resource | Was | Plan target |
| --- | --- | --- |
| Type | CPX62 (shared) | dedicated preferred |
| CPU | 16 vCPU | ≥16 |
| RAM | 32 GB | ≥64 GB (ideal) |
| Disk | ~575 GB free | ≥1 TB ideal |
| OS | Ubuntu 24.04 LTS | OK |

Bring-up result: stock + overlay `OVERLAY_BUILD_OK` (emulator). Artifacts pulled
to local `anaos-emulator-out/`. Floating tip build — **not** release pin.

## Next rental criteria

1. Disk / VM sized for `repo sync` of `android-17.0.0_r1`  
2. Run `scripts/server-bootstrap.sh`  
3. Overlay meta; keep `BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE` ≥ 3072 MiB  
4. Track B gate before any release claim  
5. **Never** place `.pk8` / AVB private keys on the host  

## Secondary: homeserver (Qizi-server)

SSH: `ssh Qizi-server` — too small for full AOSP (8 GB RAM). Light tooling only.

## What was done without full pin sync (TASK_011 / TASK_012)

GitHub forks under `Levan-al` from GrapheneOS (see `docs/REPOSITORIES.md`).
