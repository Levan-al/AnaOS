# Device porting guide (TASK_033 / TASK_084)

Checklist for bringing a Pixel SKU onto AnaOS. Finalize command tables after the
first verified-boot green build (TASK_031 / TASK_032).

## Prerequisites

- Synced AOSP / AnaOS tree (`docs/BUILD.md`)  
- Working `adevtool` (TASK_027) — see `adevtool/README.md`  
- Offline AVB + release keys (TASK_019–022); never on cloud  
- Track B awareness for sepolicy / AVB changes  

## First official SKU

Pixel 8 / `shiba` — stubs in `device/anaos/shiba/`, notes in `docs/DEVICES.md`.

## Steps

1. **Choose SKU** — codename, factory image version, kernel branch.  
2. **Extract vendor** — factory image → `adevtool` → hash inventory (`docs/VENDOR_EXTRACT.md`).  
3. **Product tree** — complete `device/anaos/<codename>/` (BoardConfig, product mk, overlays).  
4. **Sepolicy / init** — fill `sepolicy/` and `init/` (TASK_030 placeholders exist for shiba).  
5. **userdebug smoke** — boot, logcat, radios, SELinux enforcing.  
6. **user + sign** — offline `sign_anaos_release.sh` (`docs/FACTORY_IMAGE.md`).  
7. **Lock bootloader** with AnaOS AVB public key (`docs/AVB_BOOTLOADER_LOCK.md`).  
8. **CTS/VTS subset** — record in `docs/TESTING.md`.  

## Branding checks

Fingerprint and About screens must show Ana / AnaOS / `org.anaos` only
(`docs/BRANDING.md`, `docs/ORG_ANAOS_REBRAND.md`).

## Porting worksheet (copy per SKU)

| Field | Value |
| --- | --- |
| Codename | |
| Factory image build ID | |
| Vendor hash manifest path | |
| Kernel repo / tag | |
| Lunch target | |
| First userdebug boot date | |
| First signed user image date | |
| Bootloader lock verified | yes/no |

## Common pitfalls

| Issue | Mitigation |
| --- | --- |
| Missing proprietary blobs | Re-run extract; do not commit blobs to public git without license review |
| Sepolicy denials at boot | Collect `audit2allow` carefully; prefer neverallow-safe fixes |
| AVB custom key mismatch | Re-flash public key; confirm lock state |
| Branding leaks GrapheneOS/AOSP strings | Run rebrand checklist |

## Related

- `docs/VENDOR_EXTRACT.md`, `docs/KERNEL.md`, `docs/SELINUX_HARDENING.md`
