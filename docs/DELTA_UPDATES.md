# Delta updates (TASK_067)

Incremental OTAs after full-package path works.

## Principles

1. Full package always available as fallback.  
2. Delta + full use the same trust chain (classical required; PQ optional hybrid).  
3. Client rejects delta if source build mismatch or verify fails.  

## Pipeline sketch

```text
signed full A → signed full B
       │
       └─ delta(A→B) generated offline or on build host from unsigned? 
          Prefer: generate from signed artifacts on air-gap or controlled signer
```

Exact tool (bsdiff / courgette / AOSP payload generator) TBD when first two
full releases exist.

## Metadata fields (draft)

| Field | Role |
| --- | --- |
| `incremental` | true for delta |
| `baseBuildNumber` | required source |
| `downloadUrl` | delta blob |
| `sha256` | delta payload |
| `fallbackUrl` | full package |

Updater scaffold already has `incremental` on `UpdateMetadata`.

## When to enable

- [ ] ≥2 consecutive full signed releases  
- [ ] Storage savings measured  
- [ ] TASK_079 includes delta apply + rollback tests  

Until then: full OTA only (`DISTRIBUTION.md` MVP).
