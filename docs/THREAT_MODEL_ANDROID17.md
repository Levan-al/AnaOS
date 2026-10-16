# Threat-model delta vs stock Android 17 (TRACK B — TASK_098 draft)

AnaOS aims to reduce attacker value vs stock AOSP/Android 17 on the same Pixel class.

## Assets (same as stock + AnaOS extras)

| Asset | Stock Android 17 | AnaOS target |
| --- | --- | --- |
| User data at rest | FBE / CE | Same + stronger defaults |
| App sandbox | SELinux + seccomp | Hardened neverallows (TASK_045) |
| Memory safety | Partial MTE/CFI | Full hardened_malloc + CFI/SCS where HW allows |
| Update trust | Google signed | AnaOS offline keys + optional PQ hybrid later |
| Network identity | MAC rand + Private DNS optional | Stronger defaults (DoH/DoT on) |
| Google services | Deep integration | Optional sandboxed Play only |

## Adversaries

1. Remote drive-by / malicious app  
2. Network observer / captive portal  
3. Physical with unlocked bootloader  
4. Supply-chain compromised OTA  

## Controls AnaOS adds (planned)

- Verified boot green + custom AVB key (lockable)  
- No production test-keys  
- Updater pinned to `*.anaos.org`  
- Permission auto-reset / idle hibernation (TASK_055)  
- Track B merge gate on every upstream promote  

## Open gaps (honest)

- First emulator build still stock AOSP lunch (AnaOS overlay next)  
- Hardening patches not yet applied in tree  
- Domains / attestation servers not live  

Fill metrics after TASK_076–081 test suites exist.
