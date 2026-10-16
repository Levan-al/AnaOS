# CLI installer (TASK_071)

Command-line flash path for supported Pixels. Preferred over WebUSB for
power users and reproducible install docs.

## Planned binary / script

Name: `anaos-flash` (shell wrapper first; Go/Rust later if needed).

```bash
# Draft interface — not shipped yet
anaos-flash --device shiba --image ./anaos-shiba-factory-YYYYMMDD.zip
anaos-flash --lock   # after custom AVB key flashed
```

## Preconditions

- Platform-tools (`fastboot`, `adb`) on PATH  
- Bootloader unlock allowed (OEM process; wipes data)  
- Signed factory zip from AnaOS channel (`docs/FACTORY_IMAGE.md`)  
- Device codename matches image  

## High-level steps

1. Verify factory zip SHA256 against published checksums.  
2. Reboot to bootloader.  
3. Flash partitions per device flash script inside the zip.  
4. Flash AnaOS AVB public key (`docs/AVB_BOOTLOADER_LOCK.md`).  
5. Optionally lock bootloader.  
6. First boot → Setup Wizard (`org.anaos.setupwizard`).  

## Safety

- Refuse test-keys / unsigned packages in “release” mode.  
- Never embed private keys.  
- Track B gate if any flag disables AVB verification.  

## Docs delivery

Ship man-page style README beside the script; mirror steps on website
(`docs/WEBSITE.md`) when domains exist.
