# Official devices (TASK_028+)

## First device (target)

| Field | Value |
| --- | --- |
| Codename | `shiba` |
| Hardware | Google Pixel 8 |
| Product name | `ana_shiba` |
| Marketing model | Pixel 8 |
| Fingerprint example | `AnaOS/ana_shiba/shiba:…:user/release-keys` |

Stub tree: `device/anaos/shiba/`. Full vendor blobs and GrapheneOS-style bring-up wait on `adevtool` (TASK_027 / TASK_029) after AOSP sync.

## Integration checklist

- [ ] `adevtool` extract for `shiba` factory image
- [ ] `device/anaos/shiba` inherits vendor + common AnaOS fragments
- [ ] AVB public key slot for AnaOS (TASK_020 / TASK_032)
- [ ] Device sepolicy / init (TASK_030)
- [ ] `user` build + verified boot green (TASK_031)

## Emulator

`device/anaos/emulator` remains the first CI / bring-up target (TASK_018) and does not replace a Pixel SKU.
