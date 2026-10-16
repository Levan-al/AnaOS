# Air-gap ceremony day (ops one-pager)

Print with `KEY_CEREMONY_CHECKLIST.md`. No private material in this file.

## Bring

- [ ] Offline machine + known-good boot media  
- [ ] Encrypted USB / SSD for private store  
- [ ] Second clean USB for **public** PEMs only  
- [ ] Printed checklist + pen  
- [ ] Two maintainers (four-eyes)  
- [ ] Tooling hashes verified before disconnect  

## Do

1. Disconnect network (physically if possible)  
2. Generate platform / media / shared / release / ota / avb / app keys  
3. Export public PEMs + run fingerprint script  
4. Encrypt private store; Shamir shares per `KEY_RECOVERY.md`  
5. Seal media; log serials/times  

## Never

- Ceremony on Hetzner / CI / daily laptop  
- Photograph private key material  
- Reuse GrapheneOS or AOSP test-keys  

## After

- Publish fingerprints only  
- First sign follows `FACTORY_IMAGE.md` + `RELEASE_PROCESS.md`  
