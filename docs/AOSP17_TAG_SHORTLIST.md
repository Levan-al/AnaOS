# AOSP 17 tag shortlist (TRACK A — TASK_095)

Candidate pins for AnaOS staging / release. Prefer **explicit tags** over
`android-latest-release` for anything that will be signed.

Source: [AOSP build numbers](https://source.android.com/docs/setup/reference/build-numbers)
(Android 17 / API 37 / 26Q2).

## Shortlist

| Priority | Manifest tag | Notes |
| --- | --- | --- |
| **P0 — recommended staging pin** | `android-17.0.0_r1` | Android 17.0.0 Release 1; Build ID `CP2A.260605.016`; SPL 2026-06-05 |
| P1 — security-focused | `android-security-17.0.0_r1` | Security line; Build ID `15848949`; SPL 2026-05-05 — use when chasing bulletin-only updates |
| Bring-up only (current Hetzner) | `android-latest-release` | Floating; OK for TASK_018 first sync/build, **not** for official images |

## Recommendation

1. Finish TASK_018 on the current `android-latest-release` tree (do not wipe mid-sync).  
2. Open a **second** tree or re-init staging as `anaos-aosp17-stage` on **`android-17.0.0_r1`**.  
3. Rebase AnaOS overlays + hardening; run Track B gate.  
4. Promote to release pin `anaos-aosp17` only after B ACK (`SECURITY_MERGE_GATE.md`).  

When a newer `android-17.0.0_rN` or Q4 tag appears, add a row here and bump P0.

## Init sketch (staging — after disk/RAM allow)

```bash
mkdir -p /opt/anaos/aosp17 && cd /opt/anaos/aosp17
repo init --partial-clone --no-use-superproject \
  -u https://android.googlesource.com/platform/manifest \
  -b android-17.0.0_r1
repo sync -c -j4 --no-tags --optimized-fetch --prune
```

Record resolved manifest commit SHA in `AOSP17_ADAPTATION.md` conflict/pin log after sync.

## Decision log

| Date (UTC) | Decision | By |
| --- | --- | --- |
| 2026-10-16 | P0 staging target = `android-17.0.0_r1` | AnaOS maintainers (meta) |
