# SELinux hardening (TASK_045)

Maximum enforcing policy for AnaOS `user` builds. Extends
`SELINUX_APP_DOMAINS.md`.

## Non-negotiable

- `user` / official: **enforcing**, no global permissive  
- No new `permissive` domains without Track B exception + expiry  
- AnaOS apps get dedicated domains (`anaos_*`)  

## Workstreams

| Area | Action |
| --- | --- |
| Base | Track `platform_system_sepolicy` fork; rebase on AOSP 17 |
| Neverallows | Expand GrapheneOS-style neverallows; document conflicts |
| Apps | Domains table in `SELINUX_APP_DOMAINS.md` |
| Vendor | `device/anaos/shiba/sepolicy` after TASK_029 |
| AI / backup | `anaos_ai`, `anaos_backup` when those packages land |
| Tests | TASK_077: boot + denied audit noise budget |

## Order

1. Emulator stock policy boots (TASK_018)  
2. Overlay AnaOS product + app domains  
3. Device vendor sepolicy  
4. Neverallow ratchet + CTS/VTS  

## Bring-up discipline

Eng/userdebug may log denials heavily — fix forward, do not ship
`setenforce 0`. Temporary `permissive` domain requires: issue link, owner,
removal date.

## Ban

- `setenforce 0` in shipping init  
- Shipping with `permissive` “just for bring-up” on official channel  
