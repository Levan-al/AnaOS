# Reproducible builds verification (TASK_087)

Companion to `REPRODUCIBLE_BUILDS.md` / `release-env.sh`.

## Verifier steps

1. Fetch tagged sources (manifest pin + AnaOS overlays at recorded SHAs)  
2. Set `BUILD_DATETIME` / `BUILD_NUMBER` from release notes  
3. Build on clean Linux host (same major Ubuntu as official when possible)  
4. Compare **unsigned** target-files / image hashes  
5. On mismatch: `diffoscope` (or equivalent) summary; file issue with allow-list proposal  

## What may differ

| Artifact | Expected |
| --- | --- |
| Unsigned target-files | Should match |
| Final signed images | Differ (keys); compare payload digests pre-sign |
| Build logs / timestamps inside non-pinned files | Investigate |

## Official claim

Only claim reproducibility after **two independent builders** match for a release.

## AnaOS status

Gate opens after first signed factory image (TASK_026). Until then this is process-only.
