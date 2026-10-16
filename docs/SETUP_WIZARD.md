# Setup Wizard (TASK_062)

First-boot UX: `org.anaos.setupwizard`. Defaults favor Track B privacy.

## Defaults (official)

| Setting | Default |
| --- | --- |
| Telemetry / analytics | Off (no toggle to “AnaOS cloud analytics”) |
| Sandboxed Google Play | Off; explicit later enable |
| Network location | Opt-in |
| Private DNS | On / Automatic (`DNS_PRIVACY.md`) |
| Update channel | `stable` |
| Backup | Local encrypted path explained; Google Backup not required |

## Screens (MVP order)

1. Language / region  
2. Privacy summary (short, honest)  
3. Network + Private DNS  
4. Optional features (Play, location) — all off until checked  
5. Set screen lock (encourage strong)  
6. Finish → home  

## Ban

- Pre-checking Play or cloud AI  
- Skipping lock recommendation without clear “not recommended”  
- Phoning home during wizard  

Scaffold: `apps/SetupWizard/`. SELinux: `anaos_setupwizard`.
