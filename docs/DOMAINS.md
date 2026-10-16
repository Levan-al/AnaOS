# Domain registration plan (TASK_002)

**Status:** blocked / deferred — not required for AOSP bring-up.  
Register before public OTA, website, or attestation go live.

## Planned DNS

| Name | Role |
| --- | --- |
| `anaos.org` | Website + apex |
| `www.anaos.org` | Optional redirect to apex |
| `releases.anaos.org` | OTA metadata |
| `dl.anaos.org` | Factory / OTA blobs |
| `attestation.anaos.org` | Auditor backend |
| `apps.anaos.org` | App Store catalog |
| `security@anaos.org` | Mail (MX) for disclosure |

## When to buy

1. After first signed factory image path is real, **or**  
2. Before any public “download AnaOS” claim  

Until then use GitHub docs only; Updater scaffolds may list future hosts but must not soft-fail to third parties.

## Registrar / DNS notes

- Prefer DNSSEC if registrar supports it  
- CAA records locking issuance to chosen CA  
- No unnecessary third-party trackers on apex  

Related: `WEBSITE.md`, `ARTIFACT_CDN.md`, `UPDATE_SERVER.md`.
