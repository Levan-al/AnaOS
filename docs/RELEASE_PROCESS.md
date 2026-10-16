# Release process (TASK_088)

Combines key ceremony + build + distribution into one checklist.

## Preconditions

- [ ] Staging pin recorded (`AOSP17_TAG_SHORTLIST.md` / release-env)  
- [ ] Track B gate ACK (`SECURITY_MERGE_GATE.md`)  
- [ ] Reproducible env vars set (`REPRODUCIBLE_BUILDS.md`)  
- [ ] Offline keys available (not on build host)  

## Steps

1. **Build unsigned** target-files on build host (`BUILD.md`)  
2. **Copy out** unsigned zip + hashes via air-gap  
3. **Sign** with `sign_anaos_release.sh` (`KEY_CEREMONY_CHECKLIST.md`)  
4. **Record** public fingerprints (`record-public-key-fingerprints.sh`)  
5. **Upload** public artifacts only (`ARTIFACT_CDN.md`)  
6. **Publish** Updater metadata (`UPDATE_SERVER.md`)  
7. **Stage** rollout percent (`STAGED_ROLLOUT.md`)  
8. **Announce** + refresh Auditor inventory if needed (`AUDITOR_INTEGRATION.md`)  

## Channel rules

| Channel | Who | Gate |
| --- | --- | --- |
| beta | early testers | B gate still required for security drops |
| stable | general | full checklist + canary ladder |

## Never

- Sign on Hetzner / CI  
- Reuse `BUILD_NUMBER` for different bits  
- Leave rental hosts idle (`COST_OPS.md`)  

## Rollback of a release

1. Set staged `percent` to 0 or remove metadata entry  
2. Publish fixed build with higher anti-rollback indexes  
3. Post mortem in GitHub issue  
