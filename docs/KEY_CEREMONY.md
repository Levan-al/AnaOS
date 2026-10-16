# Key ceremony (TASK_023 / TASK_007)

Private keys are generated and used only on an **air-gapped** machine (Option A).  
This document never contains private key material.

## Participants

- At least two maintainers present (four-eyes)
- One scribe logs times, hashes of public keys, and media serials
- No phones / network on the ceremony machine

## Certificate subject

```text
/C=GE/ST=Tbilisi/L=Tbilisi/O=AnaOS/OU=AnaOS/CN=AnaOS/emailAddress=security@anaos.org
```

## Keys produced

| Key | Files (public only published) | Purpose |
| --- | --- | --- |
| platform | `platform.x509.pem` (+ offline `.pk8`) | Platform-signed APKs |
| media | `media.x509.pem` | Media UID |
| shared | `shared.x509.pem` | Shared UID |
| releasekey | `releasekey.x509.pem` | Default release APK signing |
| otakey | `otakey.x509.pem` or policy: reuse releasekey | OTA packages |
| avb | 4096-bit RSA; public for device embedding | Verified Boot |
| app-* | per-app where needed | see `docs/APP_SIGNING.md` + `script/make_anaos_app_keys.sh` |

## Ceremony steps (summary)

- One-pager: **`docs/AIRGAP_DAY.md`**  
- Paper boxes: **`docs/KEY_CEREMONY_CHECKLIST.md`**  
- Practical runbook (kit, timeline, commands): **`docs/AIRGAP_PRACTICAL.md`**  

1. Boot offline machine from known-good media  
2. Verify tooling hashes (`development/tools/make_key`, `openssl`, `avbtool`)  
3. Generate each keypair; export **public** PEMs only to a clean USB  
4. Encrypt private key store (LUKS / age); split recovery with Shamir (see KEY_RECOVERY.md)  
5. Record public hashes (`scripts/record-public-key-fingerprints.sh`); publish signed JSON (TASK_073)  
6. Seal offline store; log ceremony completion  

## Explicit bans

- No private keys in git, CI, or rented cloud hosts  
- No production signing on developer laptops  
- No reuse of GrapheneOS / AOSP test keys for official AnaOS builds  
