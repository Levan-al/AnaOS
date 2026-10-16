# Testing strategy (TASK_076–082)

| TASK | Suite | When |
| --- | --- | --- |
| 076 | CTS + VTS | After first device user build (031) |
| 077 | AnaOS security regression | After SELinux + malloc + CFI wired |
| 078 | Continuous fuzzing | Kernel/userspace; separate farm |
| 079 | Boot / OTA / VB automation | Needs device lab or cuttlefish |
| 080 | Attestation automation | After 075 |
| 081 | External audit process | Process below |
| 082 | Bug bounty | After public release channel |

## TASK_077 smoke list (start)

- [ ] SELinux enforcing on boot  
- [ ] `ro.anaos.*` / branding strings present  
- [ ] Updater hosts allowlist only  
- [ ] Official build refuses test-keys fingerprint  
- [ ] Track B gate script in CI  

## External audit (081)

1. Scope: verified boot, update path, SELinux, allocator  
2. NDA + safe harbor  
3. Coordinated disclosure via SECURITY.md  

## Bug bounty (082)

Launch only with: domain, security@ contact, scope doc, triage capacity.
