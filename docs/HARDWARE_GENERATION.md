# New hardware generation support (TASK_092)

Process when adding a new Pixel generation (or first non-Pixel — future only).

## Order (strict)

1. **SKU choice** — codename, SoC, support window (`DEVICES.md`)  
2. **Factory image pin** — version + hash notes (`VENDOR_EXTRACT.md`)  
3. **adevtool extract** — automated blobs (`adevtool/CHECKLIST.md`)  
4. **Device tree** — `device/anaos/<codename>/`  
5. **Kernel** — own tree / prebuilts (`KERNEL.md`)  
6. **Sepolicy / init** — device specifics  
7. **userdebug smoke** — radios, cameras, SELinux  
8. **user + sign** — offline (`FACTORY_IMAGE.md`)  
9. **AVB lock** — (`AVB_BOOTLOADER_LOCK.md`)  
10. **Updater + installers** — metadata + CLI allowlist  

## Support policy (draft)

| Class | Meaning |
| --- | --- |
| Official | Signed images + security updates for stated window |
| Experimental | userdebug only; no production channel |
| Retired | No new builds; last OTA may force upgrade path |

## Cost

New generation often needs a clean build host. Prefer ephemeral machines;
do not pile multiple device trees onto one undersized CPX without disk plan.

## First generation

Pixel 8 (`shiba`) is the template. Newer Pixels copy this worksheet from
`DEVICE_PORTING.md`.
