# Vendor extraction (TASK_029)

Automates proprietary blob bring-up for official Pixel SKUs via AnaOS `adevtool`
(or temporary GrapheneOS `adevtool` fork). Checklist: `adevtool/CHECKLIST.md`.

## First SKU

| Field | Value |
| --- | --- |
| Device | Pixel 8 (`shiba`) |
| Product | `ana_shiba` |
| Stub tree | `device/anaos/shiba/` |

## Planned flow

1. Obtain matching Google factory image (hash-pinned in private ops notes if needed).  
2. Run adevtool extract → vendor + device fragments under AnaOS paths.  
3. Verify blob hashes against published inventory.  
4. Wire `ana_shiba.mk` / `BoardConfig.mk` to generated vendor makefiles.  
5. Lunch `ana_shiba-userdebug` smoke before `user` + signing.  

## Inventory format (draft)

```text
<path>  <sha256>  <size>
```

Keep inventory in device tree or ops repo — **not** the blobs themselves in the
public meta repo unless license review allows.

## Status

Not runnable until TASK_027 implementation lands. Do not copy vendor blobs into
this meta repo.

## Related

`DEVICE_PORTING.md`, `DEVICES.md`, `HARDWARE_GENERATION.md`
