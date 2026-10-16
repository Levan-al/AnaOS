# Official devices (TASK_028+)

## First device (target)

| Field | Value |
| --- | --- |
| Codename | `shiba` |
| Hardware | Google Pixel 8 |
| Product name | `ana_shiba` |
| Marketing model | Pixel 8 |
| Fingerprint example | `AnaOS/ana_shiba/shiba:…:user/release-keys` |

Stub tree: `device/anaos/shiba/`. Full vendor blobs wait on `adevtool`
(TASK_027 / TASK_029) after AOSP sync / overlay.

## Integration checklist

- [ ] `adevtool` extract for `shiba` factory image  
- [ ] `device/anaos/shiba` inherits vendor + common AnaOS fragments  
- [ ] Kernel prebuilts (`KERNEL.md`)  
- [ ] AVB public key slot (TASK_020 / TASK_032)  
- [ ] Device sepolicy / init (TASK_030)  
- [ ] `user` build + verified boot green (TASK_031)  
- [ ] Updater + CLI allowlist entries  

## Emulator

`device/anaos/emulator` is the first CI / bring-up target (TASK_018).
It does not replace a Pixel SKU for AVB/lock claims (`EMULATOR_SMOKE.md`).

## Future SKUs

Follow `HARDWARE_GENERATION.md`. Add a row here only when officially supported.
