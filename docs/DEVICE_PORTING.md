# Device porting guide (TASK_033 draft)

Draft checklist for bringing a Pixel SKU onto AnaOS. Finalize after first
verified-boot green build (TASK_031 / TASK_032).

## Prerequisites

- Synced AOSP / AnaOS tree  
- Working `adevtool` (TASK_027)  
- Offline AVB + release keys (TASK_019–022)  

## Steps

1. **Choose SKU** — first official: Pixel 8 / `shiba` (`docs/DEVICES.md`).  
2. **Extract vendor** — factory image → `adevtool` → hash inventory (`docs/VENDOR_EXTRACT.md`).  
3. **Product tree** — complete `device/anaos/<codename>/` (stubs exist for `shiba`).  
4. **Sepolicy / init** — fill `sepolicy/` and `init/` (TASK_030).  
5. **userdebug smoke** — boot, logcat, basic radios.  
6. **user + sign** — offline `sign_anaos_release.sh` (TASK_025 / TASK_026).  
7. **Lock bootloader** with AnaOS AVB public key (TASK_032).  

## Branding checks

Fingerprint and About screens must show Ana / AnaOS / `org.anaos` only
(`docs/BRANDING.md`).
