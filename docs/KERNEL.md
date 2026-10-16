# Kernel trees (TASK_034–039)

AnaOS does not ship stock Pixel kernels unmodified for official builds.
Own trees track GrapheneOS/AOSP Pixel kernels with hardening for the release pin.

## First SKU

| Field | Value |
| --- | --- |
| Device | Pixel 8 (`shiba`) |
| Platform | Tensor G3 / `zuma` |
| Repo (planned) | `Levan-al/kernel_devices_google_shiba` (or monorepo layout TBD) |

## Task breakdown

| TASK | Item | Notes |
| --- | --- | --- |
| 034 | Own kernel trees | Fork/pin; CI build recipe |
| 035 | Hardening patches | Strict W^X, hardened usercopy, attack-surface cuts |
| 036 | MTE | Enable where Tensor/HW supports; document gaps |
| 037 | USB-C / kill-switch | Port control policy; userspace UX later |
| 038 | Firmware verified load | Align with AVB / fw loading pipeline |
| 039 | Prebuilts automation | Package → `device/anaos/shiba` BoardConfig |

## Hardening series (035 checklist)

- [ ] Pin baseline tag matching platform security release  
- [ ] Import GrapheneOS-equivalent hardening commits (license-clean)  
- [ ] Disable unused drivers / attack surface where Pixel still boots  
- [ ] CONFIG audit recorded in tree `ANAOS_KERNEL.md` (per-repo)  
- [ ] Boot + radio smoke on `shiba` userdebug  

## MTE (036)

- Prefer synchronous MTE where stable.  
- If userspace/apps regress, document exclusion list — do not silently disable.  

## USB-C / kill-switch (037)

- Kernel/firmware hooks + Settings policy; default secure.  
- No “always charge+data” silent default on locked devices.  

## Firmware verified load (038)

- Coordinate with AVB (`AVB_BOOTLOADER_LOCK.md`).  
- Reject unsigned/mismatched fw where hardware allows.  

## Prebuilts (039)

```text
kernel CI → Image/dtb artifacts → device/anaos/<sku>/prebuilts → lunch
```

Hashes recorded for reproducible release notes.

## Build host note

Full kernel + AOSP on one CPX62 is heavy. Prefer sequential: finish TASK_018,
then kernel on a larger host or overnight window (`COST_OPS.md`).

## Relation to device tree

`device/anaos/shiba/BoardConfig.mk` will point at AnaOS kernel prebuilts once
TASK_039 lands. Until then emulator builds use AOSP prebuilt kernels.
