# Release process (TASK_088)

Combines key ceremony + build + distribution.

1. Cut staging pin (`AOSP17_TAG_SHORTLIST.md`)  
2. Track B gate ACK (`SECURITY_MERGE_GATE.md`)  
3. Build unsigned target-files on build host  
4. Air-gap sign (`sign_anaos_release.sh` / KEY_CEREMONY_CHECKLIST)  
5. Upload public artifacts (`ARTIFACT_CDN.md`)  
6. Publish metadata for Updater  
7. Announce + update Auditor key inventory if needed  

Never sign on Hetzner. Delete rental hosts when idle (`COST_OPS.md`).
