# Auditor app integration (TASK_074 prep)

Pairs `org.anaos.auditor` scaffold with `ATTESTATION_SERVER.md`.

## Current state

- App scaffold under `apps/Auditor`  
- Server architecture draft only (domains blocked)  
- Meaningful samples need signed + lockable device builds  

## Integration checklist

- [ ] Embed / pin AnaOS release + AVB public fingerprints  
- [ ] Attestation submit path to `attestation.anaos.org` (HTTPS only)  
- [ ] Offline mode: local verify without phone-home  
- [ ] SELinux domain `anaos_auditor`  
- [ ] No coupling to qizimarket AI Ops  
- [ ] UI: clear pass/fail + last check time  

## TASK_075 (hardware-backed validation)

- [ ] Pixel with locked bootloader + AnaOS AVB key  
- [ ] Green VB reflected in Auditor  
- [ ] Tamper / unlock detected as fail  
- [ ] Automated case in TASK_080 later  

## Ban

- Shipping Auditor that trusts Google-only roots for AnaOS identity  
- Silent continuous upload without user enablement  
