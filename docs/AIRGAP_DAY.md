# Air-gap ceremony day (ops one-pager)

**Full practical runbook:** `AIRGAP_PRACTICAL.md` (kit list, timeline, commands).  
Print with `KEY_CEREMONY_CHECKLIST.md`. No private material in this file.

## Bring

- [ ] Offline machine + known-good boot media  
- [ ] Encrypted USB / SSD for private store (USB B)  
- [ ] Second clean USB for **public** PEMs only (USB A)  
- [ ] Printed `AIRGAP_PRACTICAL.md` §6 paper log + pen  
- [ ] Two maintainers (four-eyes)  
- [ ] Tooling hashes verified before disconnect  

## Do

1. Disconnect network (physically if possible)  
2. Generate platform / media / shared / release / ota / avb / app keys  
3. Export public PEMs + run fingerprint script → USB A  
4. Encrypt private store on USB B; Shamir shares (`KEY_RECOVERY.md`)  
5. Seal media; log serials/times  

## Never

- Ceremony on Hetzner / CI / daily laptop  
- Photograph private key material  
- Reuse GrapheneOS or AOSP test-keys  

## After

- Publish fingerprints only  
- First sign follows `FACTORY_IMAGE.md` + `RELEASE_PROCESS.md`  
