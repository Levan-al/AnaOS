# AnaOS status report

Last updated: **2026-10-19** (partition fix + overlay retry; plan refreshed).

## Verdict

Stock emulator build **succeeded**. AnaOS overlay lunch **works**. First overlay
`m` **failed** at ~93% on `super.img` (product partition vs 1800 MiB group).
Fixed with `BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE` → **3072 MiB** (`79047cd`).
**Retry `m` in progress** on Hetzner (`aosp-overlay`).

Action plan: [`ROADMAP_NOW.md`](ROADMAP_NOW.md).

## Live infra

| Item | State |
| --- | --- |
| Host | Hetzner `anaos-build` CPX62 — **billing** |
| Sync | `SYNC_OK` |
| Stock build | `BUILD_OK` @ 2026-10-16T17:05:54Z |
| Meta | Fix on GitHub `main`; host trees patched for retry |
| Overlay trees | `OVERLAY_OK` + `OVERLAY_LUNCH_OK` |
| Overlay rebuild | Retry running — wait for `OVERLAY_BUILD_OK` / `FAIL` |
| Cost | Delete after Phase B (`COST_OPS.md`) |

## Critical path (now)

```
Phase A: overlay m finish
    → Phase B: pull artifacts + delete CPX62
    → Phase C: air-gap keys / AOSP17 / shiba (offline / new host)
```

## Done / remaining (bring-up only)

| Done | Remaining (this window) |
| --- | --- |
| Sync, stock build, lunch | Overlay `m` OK |
| Partition fix pushed | Artifact pull |
| Meta docs / scaffolds (large) | Smoke (optional) |
| Away-mode finish watcher | **Delete CPX62** |
