# AVB and bootloader lock (TASK_031 / TASK_032 prep)

Goal: user builds boot with **verified boot green** and a lockable bootloader
using AnaOS’s own AVB public key.

## Concepts

| Term | AnaOS meaning |
| --- | --- |
| AVB | Android Verified Boot; root of trust for boot/dtbo/vbmeta |
| Custom AVB key | Generated offline (`script/make_anaos_avb_key.sh`); public half flashed |
| Locked | Bootloader locked; only images signed for that key boot |
| Green | `verifiedbootstate=green` (or equivalent) on official user builds |

## Sequence (after signed factory image)

1. Unlock bootloader once (stock OEM flow) — destroys user data.  
2. Flash AnaOS factory image (signed).  
3. Flash / set custom AVB public key per device docs (Pixel: `avb_custom_key`).  
4. Lock bootloader.  
5. Confirm green state + AnaOS fingerprint branding.  

Exact `fastboot` command lines are device-revision specific; fill after first
`shiba` signed image (TASK_026 + TASK_031).

## Safety

- Never publish AVB private keys.  
- Test-keys builds must not be lockable for release channels.  
- Rollback indexes enforced with OTA metadata (`docs/DISTRIBUTION.md`).  
- Track B veto if lock flow requires disabling AVB.

## Validation checklist (TASK_032)

- [ ] Device boots only AnaOS-signed images when locked  
- [ ] Tampered boot image fails closed  
- [ ] About / fingerprint show Ana / AnaOS / `org.anaos`  
- [ ] Auditor / attestation path still coherent (`docs/ATTESTATION_SERVER.md`)  

## Related

- `docs/KEY_CEREMONY.md`, `docs/FACTORY_IMAGE.md`, `docs/DEVICE_PORTING.md`
