# Signing infrastructure (TASK_007)

Private keys never leave offline / HSM-controlled environments. This document selects options and procedures; key material is generated only during the ceremony (TASK_019–TASK_023).

## Options

| Option | Description | Cost posture |
| --- | --- | --- |
| A | Air-gapped machine + encrypted key storage (GrapheneOS-style) | Preferred default; hardware you control |
| B | YubiHSM 2 or Nitrokey HSM | Low-cost hardware HSM |
| C | SignPath Foundation (OSS code signing) | Free for qualifying OSS; use only if policy allows third-party signing service |

**Selected default for AnaOS:** Option A for platform / AVB / OTA / release keys. Option C may supplement *application* signing later if evaluated and approved; it does not replace AVB or platform keys.

## Key types (planned)

| Key | Purpose |
| --- | --- |
| platform | Platform-signed APKs / APKs with platform permission |
| media | Media UID signed components |
| shared | Shared UID signed components |
| releasekey | Default release / APK signing |
| otakey | OTA packages (or policy: reuse releasekey — decide in TASK_021) |
| avb | Android Verified Boot (4096-bit RSA) |
| app-specific | Camera, Updater, Auditor, AppStore where dedicated keys are required |

## Certificate subject

```text
/C=GE/ST=Tbilisi/L=Tbilisi/O=AnaOS/OU=AnaOS/CN=AnaOS/emailAddress=security@anaos.org
```

## Ceremony prerequisites

- Offline machine (no network) or HSM
- Encrypted storage with geographically separated backups
- Shamir's Secret Sharing for recovery shares (TASK_023)
- Access logging for ceremony participants
- Public fingerprints published only after ceremony (signed JSON for AVB — TASK_073)

## Explicit non-goals for this repository

- Do **not** commit private keys, `.pk8` files, or unencrypted HSM backups
- Do **not** generate production keys on developer laptops used for day-to-day work
