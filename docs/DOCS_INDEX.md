# AnaOS documentation index

Canonical map of meta-repo docs. Prefer linking here from README instead of
duplicating long tables.

## Strategy & plan

| Doc | Topic |
| --- | --- |
| [STRATEGY.md](STRATEGY.md) | Tracks A / B / C |
| [PLAN.yaml](PLAN.yaml) | Machine-readable task plan |
| [STATUS_REPORT.md](STATUS_REPORT.md) | Live bring-up status |
| [PRODUCT_SCOPE.md](PRODUCT_SCOPE.md) | AnaOS vs AI Ops boundary |
| [COST_OPS.md](COST_OPS.md) | Hetzner / idle billing |

## Build & source

| Doc | Topic |
| --- | --- |
| [BUILD.md](BUILD.md) | Sync, lunch, watchdog |
| [BUILD_HOST.md](BUILD_HOST.md) | Host requirements |
| [RENT_BUILD_HOST.md](RENT_BUILD_HOST.md) | Rental notes |
| [REPRODUCIBLE_BUILDS.md](REPRODUCIBLE_BUILDS.md) | Pins |
| [REPRODUCIBLE_VERIFY.md](REPRODUCIBLE_VERIFY.md) | Third-party verify |
| [AOSP17_ADAPTATION.md](AOSP17_ADAPTATION.md) | TRACK A playbook |
| [AOSP17_TAG_SHORTLIST.md](AOSP17_TAG_SHORTLIST.md) | Tag pin |
| [AOSP17_REBASE_LEDGER.md](AOSP17_REBASE_LEDGER.md) | Conflict ledger |
| [CI_CD.md](CI_CD.md) | CI stages |
| [POST_BUILD_OVERLAY.md](POST_BUILD_OVERLAY.md) | After BUILD_OK |
| [EMULATOR_SMOKE.md](EMULATOR_SMOKE.md) | Emulator checklist |
| [BUILD_FAILURE_PLAYBOOK.md](BUILD_FAILURE_PLAYBOOK.md) | Host failure triage |
| [GLOSSARY.md](GLOSSARY.md) | Terms |
| [REPOSITORIES.md](REPOSITORIES.md) | Repo map |

## Signing & release

| Doc | Topic |
| --- | --- |
| [SIGNING_INFRASTRUCTURE.md](SIGNING_INFRASTRUCTURE.md) | Overview |
| [KEY_CEREMONY.md](KEY_CEREMONY.md) / [CHECKLIST](KEY_CEREMONY_CHECKLIST.md) | Offline keys |
| [KEY_ROTATION.md](KEY_ROTATION.md) / [KEY_RECOVERY.md](KEY_RECOVERY.md) | Lifecycle |
| [APP_SIGNING.md](APP_SIGNING.md) | App keys |
| [FACTORY_IMAGE.md](FACTORY_IMAGE.md) | Signed factory flow |
| [RELEASE_PROCESS.md](RELEASE_PROCESS.md) | Release cadence |
| [AVB_BOOTLOADER_LOCK.md](AVB_BOOTLOADER_LOCK.md) | Lock / green VB |

## Device & kernel

| Doc | Topic |
| --- | --- |
| [DEVICES.md](DEVICES.md) | SKU list |
| [DEVICE_PORTING.md](DEVICE_PORTING.md) | Port guide |
| [VENDOR_EXTRACT.md](VENDOR_EXTRACT.md) | Blobs |
| [KERNEL.md](KERNEL.md) | Kernel trees / hardening |

## Security & privacy

| Doc | Topic |
| --- | --- |
| [SECURITY_ARCHITECTURE.md](SECURITY_ARCHITECTURE.md) | Stack overview |
| [SECURITY_MERGE_GATE.md](SECURITY_MERGE_GATE.md) | Track B gate |
| [THREAT_MODEL_ANDROID17.md](THREAT_MODEL_ANDROID17.md) | Delta vs stock |
| [SEVERITY.md](SEVERITY.md) | Severity rubric |
| [HARDENED_MALLOC.md](HARDENED_MALLOC.md) / [CFI_AND_SCS.md](CFI_AND_SCS.md) / [MEMORY_SAFETY.md](MEMORY_SAFETY.md) | Memory |
| [SELINUX_HARDENING.md](SELINUX_HARDENING.md) / [SELINUX_APP_DOMAINS.md](SELINUX_APP_DOMAINS.md) | Isolation |
| [PRIVACY_CONTROLS.md](PRIVACY_CONTROLS.md) | Privacy matrix |
| [DNS_PRIVACY.md](DNS_PRIVACY.md) | DoH/DoT |
| [NETWORK_LOCATION.md](NETWORK_LOCATION.md) | Location |
| [SANDBOXED_PLAY.md](SANDBOXED_PLAY.md) | Optional Play |
| [SECURITY_AUDIT.md](SECURITY_AUDIT.md) | External audit |
| [BUG_BOUNTY.md](BUG_BOUNTY.md) | Bounty program |

## Distribution & install

| Doc | Topic |
| --- | --- |
| [UPDATE_SERVER.md](UPDATE_SERVER.md) | OTA architecture |
| [DISTRIBUTION.md](DISTRIBUTION.md) | Pipeline overview |
| [DELTA_UPDATES.md](DELTA_UPDATES.md) | Incremental OTA |
| [STAGED_ROLLOUT.md](STAGED_ROLLOUT.md) | Cohort rollout |
| [ARTIFACT_CDN.md](ARTIFACT_CDN.md) | CDN layout |
| [ROLLBACK_PROTECTION.md](ROLLBACK_PROTECTION.md) | Anti-rollback |
| [INSTALL_CLI.md](INSTALL_CLI.md) | CLI flash |
| [WEBUSB_INSTALLER.md](WEBUSB_INSTALLER.md) | WebUSB |
| [WEBSITE.md](WEBSITE.md) | Site IA |

## Apps & innovation

| Doc | Topic |
| --- | --- |
| [AOSP_APPS_HARDENING.md](AOSP_APPS_HARDENING.md) | Stock apps |
| [BROWSER_WEBVIEW.md](BROWSER_WEBVIEW.md) | Vanadium-class browser |
| [APPSTORE.md](APPSTORE.md) | First-party store |
| [ENCRYPTED_BACKUP.md](ENCRYPTED_BACKUP.md) | Backup |
| [ORG_ANAOS_REBRAND.md](ORG_ANAOS_REBRAND.md) | Rebrand map |
| [PQC_ROADMAP.md](PQC_ROADMAP.md) | TRACK C1 |
| [AI_ALTERNATIVES.md](AI_ALTERNATIVES.md) / [AI_THREAT_MODEL.md](AI_THREAT_MODEL.md) | TRACK C2 |
| [BRANDING.md](BRANDING.md) | Brand rules |

## Ops & testing

| Doc | Topic |
| --- | --- |
| [TESTING.md](TESTING.md) | Suites |
| [LONGTERM_OPS.md](LONGTERM_OPS.md) | Long-term |
| [MONTHLY_SECURITY_PATCHES.md](MONTHLY_SECURITY_PATCHES.md) | ASP pipeline |
| [ANDROID_VERSION_PORT.md](ANDROID_VERSION_PORT.md) | Major version ports |
| [HARDWARE_GENERATION.md](HARDWARE_GENERATION.md) | New Pixel gens |
| [COMMUNITY_SUPPORT.md](COMMUNITY_SUPPORT.md) | Support channels |
| [ATTESTATION_SERVER.md](ATTESTATION_SERVER.md) | Auditor backend |
| [AUDITOR_INTEGRATION.md](AUDITOR_INTEGRATION.md) | Auditor client integration |
