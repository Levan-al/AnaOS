# Reproducible builds verification (TASK_087)

Companion to `REPRODUCIBLE_BUILDS.md` / `release-env.sh`.

## Verifier steps

1. Fetch tagged sources (manifest pin + AnaOS overlays)  
2. Set `BUILD_DATETIME` / `BUILD_NUMBER` from release notes  
3. Build on clean Linux host  
4. Compare unsigned target-files hashes (or signed with same keys offline)  
5. Publish diffoscope summary on mismatch  

## Official claim

Only claim reproducibility after two independent builders match for a release.
