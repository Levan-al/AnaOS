# Key rotation (TASK_024)

## When to rotate

- Suspected compromise  
- Planned schedule (document interval; recommend ≤ 2 years for app keys)  
- Personnel change that affects share holders  

## Platform / release / OTA

1. Generate new keys via KEY_CEREMONY.md  
2. Sign a transitional OTA that installs the new AVB/public material only if hardware allows  
3. Publish new fingerprints; keep old public keys listed as revoked  
4. Device policy: forbid downgrade (rollback index — TASK_072)  

## App keys

- Publish new cert in App Store metadata before cutting over  
- Keep old cert accepted for one staged release window if needed  

## Communication

- Security mailing list / website banner  
- Attestation server updated fingerprints (signed JSON)  
