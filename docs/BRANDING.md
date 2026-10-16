# AnaOS Branding

Official branding and identity for The AnaOS Project.

## Identity

| Field | Value |
| --- | --- |
| Project name | AnaOS |
| Short name | Ana |
| Brand | Ana |
| Manufacturer | AnaOS |
| Package prefix | `org.anaos` |
| Copyright | Copyright (C) The AnaOS Project |
| Primary license | Apache-2.0 |
| Secondary license | GPLv2 (where required by upstream) |

## Build fingerprint

Template:

```text
AnaOS/<product>/<device>:<android_version>/<build_id>/<build_number>:user/release-keys
```

Example:

```text
AnaOS/ana_shiba/shiba:15/AP3A.250000.000/2026010100:user/release-keys
```

## About / product strings

Use these strings consistently in Settings → About, boot UI, OTA metadata, and legal notices.

| Key | Value |
| --- | --- |
| `ro.product.brand` | Ana |
| `ro.product.manufacturer` | AnaOS |
| `ro.product.name` | (device product, e.g. `ana_shiba`) |
| `ro.product.model` | (marketing model, e.g. `Pixel 8`) |
| `ro.product.device` | (codename) |
| About OS name | AnaOS |
| About OS version label | AnaOS `<version>` |
| Legal / copyright line | Copyright (C) The AnaOS Project |

## Package namespace rules

- System apps and AnaOS-owned components use `org.anaos.*`
- Do not ship GrapheneOS, AOSP sample, or vendor marketing names in user-visible branding
- Application IDs for first-party apps:

| App | Application ID |
| --- | --- |
| Camera | `org.anaos.camera` |
| Updater | `org.anaos.updater` |
| Auditor | `org.anaos.auditor` |
| App Store | `org.anaos.appstore` |
| PDF Viewer | `org.anaos.pdfviewer` |
| Setup Wizard | `org.anaos.setupwizard` |
| Browser | `org.anaos.browser` |
| Attestation (server-facing) | `org.anaos.attestation` |

## Domains (planned)

| Purpose | Domain |
| --- | --- |
| Primary site | `anaos.org` |
| Releases | `releases.anaos.org` |
| Attestation | `attestation.anaos.org` |
| Downloads | `dl.anaos.org` |
| Apps / store metadata | `apps.anaos.org` |

## Visual / media assets (to be supplied)

Expected under `branding/`:

- `bootanimation/` — boot animation
- `logos/` — mark, wordmark, adaptive icons
- `overlays/` — runtime resource overlays
- `strings/` — branded string overrides
- `wallpapers/` — default wallpapers
- `config.mk` — makefile injection for product builds

Until final artwork lands, builds may use placeholder AnaOS text marks; final assets must replace placeholders before public release.

## Non-negotiable branding rules

Per project execution rules:

- User-visible and fingerprint branding must use **AnaOS**, **Ana**, and **org.anaos**
- Updater and release metadata must not point at third-party OS update servers
- Official / production builds must identify as AnaOS with release-keys when signed with project keys
