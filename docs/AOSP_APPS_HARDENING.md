# Harden Messaging, Dialer, Contacts, Gallery (TASK_063)

Stock AOSP apps kept where useful; strip tracking and tighten permissions.

## Checklist

- [ ] No Google cloud sync defaults  
- [ ] Minimal privileges; no SMS upload  
- [ ] Gallery: metadata strip on share hooks into TASK_054  
- [ ] Dialer/Contacts: no unexpected network  
- [ ] Package IDs remain platform; branding AnaOS where user-visible  

Prefer GrapheneOS patches as reference; rebrand strings per `ORG_ANAOS_REBRAND.md`.
