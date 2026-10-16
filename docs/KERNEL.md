# Kernel trees (TASK_034–039)

AnaOS does not ship stock Pixel kernels unmodified for official builds.
Own trees track GrapheneOS/AOSP android12–16/17 Pixel kernels with hardening.

## First SKU

| Field | Value |
| --- | --- |
| Device | Pixel 8 (`shiba`) |
| Platform | Tensor G3 / `zuma` |
| Repo (planned) | `Levan-al/kernel_devices_google_shiba` (or monorepo layout TBD) |

## Checklist

- [ ] Create / fork kernel repos under `Levan-al`  
- [ ] Pin tags matching AOSP 17 / security release  
- [ ] Apply hardening series (TASK_035): hardened usercopy, strict W^X, etc.  
- [ ] MTE where HW allows (TASK_036)  
- [ ] USB-C / kill-switch policy hooks (TASK_037)  
- [ ] Firmware verified load path (TASK_038)  
- [ ] Prebuilt packaging pipeline (TASK_039)  

## Build host note

Full kernel + AOSP on one CPX62 is heavy. Prefer sequential: finish TASK_018,
then kernel on a larger host or overnight window (`docs/COST_OPS.md`).

## Relation to device tree

`device/anaos/shiba/BoardConfig.mk` will point at AnaOS kernel prebuilts once
TASK_039 lands. Until then emulator builds use AOSP prebuilt kernels.
