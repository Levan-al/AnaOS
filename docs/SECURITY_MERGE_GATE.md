# Security / privacy merge gate (TRACK B — TASK_097)

Every upstream (AOSP 17) or innovation (PQC / AI) change that touches the
platform must pass this gate before promotion to a release pin.

**Track B can veto Track A and Track C.** Speed never overrides isolation.

## Must remain true

| Control | Required state |
| --- | --- |
| SELinux | enforcing on `user` / official builds |
| Verified boot | green path planned; no disabled AVB in official |
| Rollback protection | intact across OTA |
| hardened_malloc | enabled for AnaOS products (once wired) |
| CFI / SCS / PAC | not regressively disabled where previously on |
| Branding | `Ana` / `AnaOS` / `org.anaos` only in user-visible OS strings |
| Signing | no test-keys / no `.pk8` in CI or cloud |
| Telemetry | no new always-on phone-home |

## Checklist (copy into PR / promote notes)

```text
TRACK B GATE
[ ] Threat-model delta written (what attacker gains if this merges)
[ ] No new privileged network endpoints without user consent
[ ] SELinux: no new permissive domains on user builds
[ ] AVB / rollback: not weakened
[ ] Memory-safety flags: not turned off "to fix the build"
[ ] Branding / OFFICIAL_BUILD inherit still present
[ ] Privacy defaults: sensors, clipboard, mic remain deny-by-default where AnaOS hardened them
[ ] Track C only: AI features offline-default; PQ changes hybrid + rollback-safe
[ ] Tests planned: smoke boot + (later) TASK_077 suite items
[ ] B reviewer ACK (two-person when possible)
```

## Fail → action

| Failure | Action |
| --- | --- |
| Isolation weakened | Block promote; quarantine on `anaos-aosp17-stage` |
| Build-only disable of CFI/hmalloc | Reject; fix properly or document time-boxed exception with expiry |
| Cloud AI default on | Reject (see `AI_ALTERNATIVES.md`) |

## Automation (incremental)

- Meta CI: docs + branding presence (`.github/workflows/meta-ci.yml`)  
- Host: `scripts/check-security-gate.sh` — local/CI smoke for gate file + branding rules  
- Full SELinux/AVB checks land with TASK_077 after first device/emulator builds  
