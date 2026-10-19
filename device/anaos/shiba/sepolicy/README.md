# shiba SELinux stubs

| File | Role |
| --- | --- |
| `private/anaos_updater.te` | Updater domain type |
| `private/anaos_auditor.te` | Auditor domain type |
| `private/anaos_camera.te` | Camera domain type |
| `file_contexts` | priv-app path labels |

These **do not compile** in the meta repo. Copy into `device/google/shiba-sepolicy`
or `system/sepolicy` after AOSP17 + adevtool extract. See `docs/SELINUX_APP_DOMAINS.md`.
