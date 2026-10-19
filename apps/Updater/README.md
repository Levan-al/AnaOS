# AnaOS Updater (`org.anaos.updater`)

Scaffold for TASK_060. Points **only** at AnaOS update servers.

## Package layout (scaffold)

| Path | Role |
| --- | --- |
| `UpdateEndpoints` | Hard-coded `releases.anaos.org` / `dl.anaos.org` |
| `UpdateChannel` | `stable` / `beta` |
| `UpdateMetadata` | Server JSON shape |
| `UpdateMetadataParser` | Offline JSON parse + host allowlist check |
| `HostAllowlist` | Only `releases.anaos.org` / `dl.anaos.org` |
| `UpdateRepository` | Fetch contract; `NoOpUpdateRepository` (default, no network) |
| `AllowlistedUpdateRepository` | Network-ready shape; still offline unless explicitly enabled |
| `HttpsMetadataFetcher` | HTTPS GET (allowlist-gated); not wired in production default |
| `BuildNumber` | Lexicographic compare + minBuild / upgrade checks |
| `UpdateSignatureVerifier` | Classical / hybrid PQ verify contract + NoOp stub |
| `HybridPqSignatureVerifier` | TASK_100 prototype shape (not production-ready) |
| `BootCompletedReceiver` | Boot hook stub |
| `network_security_config.xml` | Cleartext denied; AnaOS domains only |
| `assets/fixtures/` | Offline parse self-test in MainActivity |

Repo fixtures + CI: `fixtures/ota/`, `scripts/validate_update_metadata.py`.

## Planned features

- Channels: stable / beta  
- Full + delta OTA  
- Signature verification (+ optional hybrid PQ — TRACK C) + rollback protection  
- No third-party update hosts  

## Package

- Application ID: `org.anaos.updater`  
- SELinux: dedicated domain (TASK_045)  
- Signing: dedicated app key (`docs/APP_SIGNING.md`)  

Platform tree: `platform_packages_apps_Updater` on GitHub.  
This folder is the development scaffold until merged into the platform package path.
