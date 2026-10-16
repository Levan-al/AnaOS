# Post-quantum cryptography roadmap (TRACK C1)

Forward-looking crypto for AnaOS without breaking today’s verified boot / OTA.

## Principles

1. **Hybrid first** — classical + PQ until PQ-only is universally practical.  
2. **Offline ceremony** — new key types still air-gapped (KEY_CEREMONY.md).  
3. **No cloud dependency** for signing or verification.  
4. **Rollback-safe** — devices must reject downgrades across crypto migrations.

## Phases

| Phase | Scope | Status |
| --- | --- | --- |
| P0 | Inventory: OTA, APK, AVB, TLS touchpoints | in_progress (this doc) |
| P1 | Design hybrid OTA / release metadata signatures | pending |
| P2 | Prototype verify path in Updater (`org.anaos.updater`) | pending |
| P3 | Document PQ options in key ceremony | pending |
| P4 | Optional system TLS hybrid KEM where BoringSSL/AOSP allows | pending |

## Out of scope (for now)

- Replacing Pixel AVB hardware roots with PQ-only keys (hardware-limited).  
- Shipping experimental PQ as the sole trust root for production devices.
