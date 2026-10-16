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
| P0 | Inventory: OTA, APK, AVB, TLS touchpoints | done (this doc) |
| P1 | Design hybrid OTA / release metadata signatures | in_progress (metadata fields) |
| P2 | Prototype verify path in Updater (`org.anaos.updater`) | in_progress (scaffold interfaces) |
| P3 | Document PQ options in key ceremony | pending |
| P4 | Optional system TLS hybrid KEM where BoringSSL/AOSP allows | pending |

## P0 inventory (touchpoints)

| Trust surface | Today (classical) | PQ direction |
| --- | --- | --- |
| APK / `releasekey` | RSA via `make_key` / sign_target_files | Keep classical for APKs initially; revisit with ecosystem support |
| OTA packages | `otakey` / releasekey | **Hybrid** metadata or dual-sign in Updater (P1–P2) |
| AVB / boot | RSA-4096 AVB key | Hardware-limited; keep RSA; document PQ as non-root overlay research |
| TLS (system) | BoringSSL as in AOSP | Hybrid KEM when AOSP exposes stable API |
| Attestation | Existing Auditor path | Metadata-only PQ experiments; no VB break |

## Out of scope (for now)

- Replacing Pixel AVB hardware roots with PQ-only keys (hardware-limited).  
- Shipping experimental PQ as the sole trust root for production devices.
