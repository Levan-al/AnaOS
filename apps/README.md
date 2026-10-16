# AnaOS first-party apps (scaffolds)

Development scaffolds under `org.anaos.*`. Platform merge targets are
`platform_packages_apps_*` on GitHub.

| App | ID | Status |
| --- | --- | --- |
| [Updater](Updater/) | `org.anaos.updater` | scaffold + OTA contracts |
| [Auditor](Auditor/) | `org.anaos.auditor` | scaffold |
| [Camera](Camera/) | `org.anaos.camera` | scaffold |
| [PdfViewer](PdfViewer/) | `org.anaos.pdfviewer` | scaffold |
| [AppStore](AppStore/) | `org.anaos.appstore` | scaffold |
| [SetupWizard](SetupWizard/) | `org.anaos.setupwizard` | scaffold |

Signing map: `docs/APP_SIGNING.md`. Rebrand from GrapheneOS: `docs/ORG_ANAOS_REBRAND.md`.  
SELinux domains: `docs/SELINUX_APP_DOMAINS.md`.

## Local debug APKs

With Android SDK + JDK on the workstation (not on Hetzner):

```powershell
powershell -File scripts/build-app-scaffolds.ps1
```

Outputs: `apps/<App>/app/build/outputs/apk/debug/app-debug.apk` (gitignored).
