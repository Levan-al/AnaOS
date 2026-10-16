# Staged rollout (TASK_068)

Gradual OTA exposure after a signed release is uploaded.

## Model

| Field | Meaning |
| --- | --- |
| `cohort` | Sticky bucket id derived from device (hash; no PII server-side) |
| `percent` | 0–100 of cohorts eligible |
| `channel` | `stable` / `beta` |

Updater: if device cohort > percent → treat as “no update” (or show “held”).

## Typical ladder

| Stage | percent | Hold |
| --- | --- | --- |
| Canary | 1 | ≥24h + crash/audit watch |
| Early | 10 | ≥24h |
| Broad | 50 | ≥24h |
| Full | 100 | — |

Emergency: publish metadata with `percent: 0` or remove build entry.

## Rules

- Never stage unsigned / test-keys on `stable`  
- Rollback indexes still enforced (`ROLLBACK_PROTECTION.md`)  
- Beta channel may move faster; still Track B for security fixes  

## Ops

Owner watches Auditor samples + GitHub issues during canary.
Cost: metadata is cheap; do not keep build hosts up for staging waits.
