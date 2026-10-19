# AnaOS status report

Last updated: **2026-10-19** (Phase C started).

## Verdict

Bring-up **closed**: overlay OK, artifacts local, Hetzner deleted, API token revoked.  
**Phase C active** — air-gap / AOSP17 / shiba / domains / Updater (no cloud keys).

## Phases

| Phase | State |
| --- | --- |
| A — stock + overlay compile | Done |
| B — pull + teardown | Done |
| C — next engineering | **In progress** — see [`PHASE_C.md`](PHASE_C.md) |

## Phase C deliverables landed this sprint

- `docs/PHASE_C.md`, refreshed `ROADMAP_NOW.md`  
- `scripts/pack-airgap-kit.sh` (public USB-A pack)  
- Stronger `check-security-gate.sh`  
- AOSP17 pin decision log post-bring-up  
- `dns/anaos.org.zone.example`  
- Updater: `HostAllowlist`, `UpdateMetadataParser`, `AllowlistedUpdateRepository`  
- `scripts/verify-emulator-artifacts.sh`  
- adevtool checklist expanded  

## Local artifacts note

`anaos-emulator-out/`: `super.img` + main partitions present and hash-OK.  
`system_dlkm.img` alone failed SHA256 vs packed sums (likely truncated scp);  
host already deleted — prefer boot via `super.img` for smoke.

## Still human / blocked

| Item | Needs |
| --- | --- |
| Key ceremony | Offline machine + two people (`out/anaos-airgap-public-*.tar.gz` ready) |
| AOSP17 sync | New build host + disk |
| shiba vendor | Factory image + adevtool implementation |
| Domains | Purchase decision |
| Emulator UI smoke | Local Android emulator + images |
