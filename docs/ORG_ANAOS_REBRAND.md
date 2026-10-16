# GrapheneOS → AnaOS (`org.anaos`) rebrand checklist

Track B: user-visible and package identity must be Ana / AnaOS / `org.anaos`.  
Do **not** ship GrapheneOS names in Settings, OTA metadata, or launcher labels.

Forks under `Levan-al` (see `docs/REPOSITORIES.md`). Work per-repo after AOSP sync;
do not force-push history rewrites on public forks without a plan.

## Global substitutions (review each hit)

| From (examples) | To |
| --- | --- |
| `app.grapheneos.*` / GrapheneOS app IDs | `org.anaos.*` per BRANDING.md |
| `GrapheneOS` (user-visible) | `AnaOS` |
| `grapheneos.org` update/attestation URLs | `releases.anaos.org` / `attestation.anaos.org` / … |
| `ro.grapheneos.*` style props | `ro.anaos.*` |
| GrapheneOS fingerprint brand | `AnaOS` / product `ana_*` |

Keep SPDX / copyright lines for **upstream authors** intact; add AnaOS copyright
only on AnaOS-authored files.

## Per-repo checklist

### Apps

| Repo | Target ID | Package/strings | URLs | SELinux | Done |
| --- | --- | --- | --- | --- | --- |
| `platform_packages_apps_Updater` | `org.anaos.updater` | [x] scaffold | [x] | [ ] | [ ] |
| `platform_packages_apps_Auditor` | `org.anaos.auditor` | [x] scaffold | [x] | [ ] | [ ] |
| `platform_packages_apps_Camera` | `org.anaos.camera` | [x] scaffold | n/a | [ ] | [ ] |
| `platform_packages_apps_AppStore` | `org.anaos.appstore` | [x] scaffold | [x] | [ ] | [ ] |
| `platform_packages_apps_PdfViewer` | `org.anaos.pdfviewer` | [x] scaffold | n/a | [ ] | [ ] |
| `platform_packages_apps_SetupWizard` | `org.anaos.setupwizard` | [ ] | [ ] | [ ] | [ ] |
| `Auditor` (upstream fork) | align or archive | [ ] | [ ] | [ ] | [ ] |
| `PdfViewer` (upstream fork) | align or archive | [ ] | [ ] | [ ] | [ ] |

### Browser / WebView

| Repo | Target | Notes | Done |
| --- | --- | --- | --- |
| `platform_external_vanadium` / Vanadium fork | `org.anaos.browser` (+ WebView provider) | Large; stage after emulator build | [ ] |

### Platform / tooling

| Repo | Notes | Done |
| --- | --- | --- |
| `platform_*` GrapheneOS forks | Rebrand only AnaOS-touched surfaces; keep security patches | [ ] |
| `grapheneos_adevtool` → `adevtool` | Paths `device/anaos`, brand strings | [ ] |
| `grapheneos_script` → `script` | Release metadata for Updater | [ ] |
| `branding` | Final artwork / RRO | [ ] partial |

## Verification

```bash
# In a candidate tree — expect zero user-facing GrapheneOS hits in AnaOS products:
rg -n "GrapheneOS|grapheneos\\.org|app\\.grapheneos" device/anaos branding apps || true
```

- [ ] Fingerprint / About show AnaOS  
- [ ] Updater hosts only `*.anaos.org`  
- [ ] Track B gate ACK before release pin  

## Order of work

1. Updater + branding props (this meta scaffold started)  
2. Auditor / Camera / PdfViewer / AppStore  
3. Vanadium  
4. Platform frameworks strings leftovers  
