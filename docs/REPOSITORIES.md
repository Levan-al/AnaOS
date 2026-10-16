# Source control layout (TASK_003)

## Organization

**Decision:** GitHub (public OSS + Actions).

**Current host (bootstrap):** personal account [Levan-al](https://github.com/Levan-al)  
**Meta repo:** https://github.com/Levan-al/AnaOS  

Organization named `AnaOS` could not be created yet (GitHub UI name/captcha). Create a free org later and transfer these repos. Until then all TASK_003 repos live under `Levan-al/`.

Scope: Android hardened OS only. AI Ops landing at qizimarket.com/anaos is unrelated (see `PRODUCT_SCOPE.md`).

## Required repositories

### Core

| Repository | Purpose |
| --- | --- |
| `platform_manifest` | `repo` manifest (`default.xml`) |
| `branding` | Product branding injection |
| `script` | Build / release helper scripts |
| `hardened_malloc` | Allocator (fork or tracking) |
| `adevtool` | Vendor extraction / device tree generation |
| `vendor_state` | Vendor blob state tracking |

### System apps (AnaOS-owned)

| Repository | Application ID |
| --- | --- |
| `platform_packages_apps_Camera` | `org.anaos.camera` |
| `platform_packages_apps_Updater` | `org.anaos.updater` |
| `platform_packages_apps_Auditor` | `org.anaos.auditor` |
| `platform_packages_apps_AppStore` | `org.anaos.appstore` |
| `platform_packages_apps_SetupWizard` | `org.anaos.setupwizard` |
| `platform_packages_apps_PdfViewer` | `org.anaos.pdfviewer` |
| `platform_external_vanadium` | Browser / WebView |

### Policy on every repo

- Branch protection on `main` / release branches
- Require signed commits
- `CODEOWNERS`
- `SECURITY.md` (or org-level security policy link)
- DCO (Developer Certificate of Origin) via signed-off-by

## This workspace

The current tree is the **meta / bootstrap** workspace until remotes exist. After the org is created, split or push:

- `branding/` → `branding`
- `docs/PLAN.yaml` may stay in a `meta` or `website` repo, or `platform_manifest`
