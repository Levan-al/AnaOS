# AnaOS App Store (TASK_061)

First-party catalog client: `org.anaos.appstore` → `apps.anaos.org`.

## Goals

- Distribute AnaOS-signed apps and curated FOSS  
- No Google Play dependency for core apps  
- Separate from sandboxed Play (TASK_050)  

## Trust

| Item | Rule |
| --- | --- |
| Host | `apps.anaos.org` only in network config |
| Packages | Signature verify against AnaOS app keys / store root |
| Updates | Store updates ≠ OS OTA (`UPDATE_SERVER.md`) |

## MVP

1. Static JSON catalog + APK URLs on CDN  
2. Client lists / installs / verifies  
3. Manual curator upload after offline sign  

## Non-goals (v1)

- Arbitrary third-party developer console  
- In-app purchases / ads  
- Replacing F-Droid for users who want it (sideload still possible)  

Scaffold: `apps/AppStore/`. Domains: TASK_002.
