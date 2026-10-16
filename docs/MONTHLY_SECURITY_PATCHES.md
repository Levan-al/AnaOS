# Monthly security patch pipeline (TASK_090)

Automate absorption of Android Security Bulletin / AOSP patches into AnaOS.

## Cadence

| Week | Action |
| --- | --- |
| Bulletin day | Track AOSP / Pixel tags; open staging branch |
| +1–3 days | Merge security patches; log conflicts (`AOSP17_REBASE_LEDGER.md` pattern) |
| Mid-cycle | Emulator smoke + security regression (TASK_077) |
| Sign-off | Track B gate ACK |
| Publish | Offline sign → CDN → staged rollout |

## Pipeline stages

```text
monitor bulletin → stage rebase → build unsigned → regression
       → B gate → offline sign → upload → Updater cohorts
```

## Automation (target)

- CI job: detect new `android-*-security-*` / release tags.  
- Issue template auto-filed with checklist.  
- Build farm produces unsigned target-files only.  
- Human: ceremony + B gate for production channel.  

## Relation to version ports

Monthly ASP ≠ full Android version port. Full ports use
`AOSP17_ADAPTATION.md` / `LONGTERM_OPS.md`.

## Cost note

Prefer ephemeral build hosts (`COST_OPS.md`); do not leave CPX62 idle between
months.
