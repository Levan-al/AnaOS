# Vendor extraction (TASK_029)

Automates proprietary blob bring-up for official Pixel SKUs via AnaOS `adevtool` (or temporary GrapheneOS `adevtool` fork).

## First SKU

- Device: Pixel 8 (`shiba`)
- Product: `ana_shiba`
- Stub tree: `device/anaos/shiba/` (already present)

## Planned flow

1. Obtain matching Google factory image (hash-pinned).
2. Run adevtool extract → vendor + device fragments under AnaOS paths.
3. Verify blob hashes against published inventory.
4. Wire `ana_shiba.mk` / `BoardConfig.mk` to generated vendor makefiles.
5. Lunch `ana_shiba-userdebug` smoke build before `user` + signing.

## Status

Not runnable until TASK_027 implementation lands. Do not copy vendor blobs into this meta repo.
