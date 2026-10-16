# SELinux domains for AnaOS apps (TASK_045 prep)

Stub policy names for first-party apps. Concrete `.te` files land with
`platform_system_sepolicy` after first device/emulator images.

| App ID | Planned domain | Notes |
| --- | --- | --- |
| `org.anaos.updater` | `anaos_updater` | Network to `releases.anaos.org` / `dl.anaos.org` only |
| `org.anaos.auditor` | `anaos_auditor` | Attestation + optional network to `attestation.anaos.org` |
| `org.anaos.camera` | `anaos_camera` | Camera HAL; no unsolicited network |
| `org.anaos.pdfviewer` | `anaos_pdfviewer` | Isolated; content URI only |
| `org.anaos.appstore` | `anaos_appstore` | Network to `apps.anaos.org` only |

Rules: no new `permissive` domains on `user` builds. Track B gate applies.
