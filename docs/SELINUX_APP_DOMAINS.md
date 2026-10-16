# SELinux domains for AnaOS apps (TASK_045 prep)

Stub policy names for first-party apps. Concrete `.te` files land with
`platform_system_sepolicy` after first device/emulator images.

| App ID | Planned domain | Network | Notes |
| --- | --- | --- | --- |
| `org.anaos.updater` | `anaos_updater` | `releases` / `dl` only | No arbitrary HTTPS |
| `org.anaos.auditor` | `anaos_auditor` | optional attestation host | Offline mode required |
| `org.anaos.camera` | `anaos_camera` | none by default | Camera HAL |
| `org.anaos.pdfviewer` | `anaos_pdfviewer` | none | Content URI only |
| `org.anaos.appstore` | `anaos_appstore` | `apps.anaos.org` only | |
| `org.anaos.setupwizard` | `anaos_setupwizard` | none persistent | First-boot |
| `org.anaos.ai.*` | `anaos_ai` | none by default | Consent before any net |
| `org.anaos.backup` | `anaos_backup` | user endpoint only | TASK_064 |

## Policy sketch (not yet in tree)

```text
type anaos_updater, domain;
app_domain(anaos_updater)
# net allowlist via network_security_config + sepolicy neverallows
```

Placeholders under `device/anaos/shiba/sepolicy/` until platform sepolicy fork
carries global app domains.

## Rules

- No new `permissive` domains on `user` builds  
- Track B gate on binder / HAL expansions  
- Map every new `org.anaos.*` package here before merge  
