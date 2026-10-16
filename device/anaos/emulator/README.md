# AnaOS emulator product

Bring-up lunch target after overlay (`docs/POST_BUILD_OVERLAY.md`).

| File | Role |
| --- | --- |
| `AndroidProducts.mk` | Registers lunch choices |
| `anaos_emulator.mk` | Product + AnaOS common inherit |
| `BoardConfig.mk` | Minimal x86_64 emulator board stub |

- First host build may use stock `sdk_phone64_x86_64-*` until overlay  
- Smoke: `docs/EMULATOR_SMOKE.md`  
- Does not validate Pixel AVB / bootloader lock  

If lunch fails after overlay, adjust goldfish inherit paths to match the
synced AOSP pin (do not guess on a second full sync).
