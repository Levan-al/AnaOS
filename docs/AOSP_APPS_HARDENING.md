# Harden Messaging, Dialer, Contacts, Gallery (TASK_063)

Stock AOSP apps kept where useful; strip tracking and tighten permissions.

## Per-app checklist

### Messaging (SMS/MMS)

- [ ] No Google cloud sync defaults  
- [ ] No SMS upload / analytics  
- [ ] Minimal network (MMS only when sending)  
- [ ] Link preview optional / off by default  

### Dialer

- [ ] No unexpected network  
- [ ] Caller-ID third parties off by default  
- [ ] Permissions: phone state only as needed  

### Contacts

- [ ] No cloud account sync required  
- [ ] Export/import local; encrypted backup via TASK_064 later  
- [ ] No contacts upload to AnaOS  

### Gallery

- [ ] Metadata strip on share (TASK_054)  
- [ ] No location in shares by default  
- [ ] Trash / access confined to media store  

## Cross-cutting

| Item | Action |
| --- | --- |
| Package IDs | Keep platform IDs where required; user-visible AnaOS branding |
| Strings | `ORG_ANAOS_REBRAND.md` |
| Network | Honor per-app toggle (TASK_047) |
| SELinux | App domains map (`SELINUX_APP_DOMAINS.md`) |

## Reference

Prefer GrapheneOS patches as reference; drop GrapheneOS hosts/branding.
Track B gate on any new privileged permission.
