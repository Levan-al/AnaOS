# Testing strategy (TASK_076–082)

| TASK | Suite | When | Detail |
| --- | --- | --- | --- |
| 076 | CTS + VTS | After first device user build (031) | AOSP suites; record waivers |
| 077 | AnaOS security regression | After SELinux + malloc + CFI wired | checklist below |
| 078 | Continuous fuzzing | Kernel/userspace; separate farm | libFuzzer / syzkaller later |
| 079 | Boot / OTA / VB automation | Device lab or cuttlefish | includes rollback cases |
| 080 | Attestation automation | After 075 | Auditor path |
| 081 | External audit process | Process | `SECURITY_AUDIT.md` |
| 082 | Bug bounty | After public channel | `BUG_BOUNTY.md` |

## TASK_077 smoke list

- [ ] SELinux enforcing on boot  
- [ ] `ro.anaos.*` / branding strings present  
- [ ] Updater hosts allowlist only  
- [ ] Official build refuses test-keys fingerprint  
- [ ] Track B gate script in CI  
- [ ] hardened_malloc linked on critical processes (when wired)  
- [ ] DoH/DoT defaults match `DNS_PRIVACY.md`  

## TASK_078 fuzzing (phased)

1. Document crash triage inbox.  
2. Seed harnesses for OTA metadata parse + Updater verify stubs.  
3. Kernel syzkaller only on dedicated host (cost-aware).  

## TASK_079 boot / OTA / VB

Automate: unlock → flash → lock → OTA apply → reboot → green; plus
rollback reject (`ROLLBACK_PROTECTION.md`).

## External audit (081)

See `SECURITY_AUDIT.md`.

## Bug bounty (082)

See `BUG_BOUNTY.md`. Launch only with domain, contact, scope, triage.

## Emulator bring-up (now)

Until device lab exists: CTS-lite / manual smoke on
`sdk_phone64_x86_64` after `BUILD_OK` + overlay.
