# Sandboxed Google Play compatibility (TASK_050)

Optional layer for apps that need Play services — **never** required for AnaOS
core functionality.

## Principles

- Runs isolated from privileged OS components  
- User must explicitly enable (Setup Wizard: default **off**)  
- No privileging Google apps over AnaOS apps  
- Track GrapheneOS sandboxed Play design; rebrand and audit  

## Threat notes

| Risk | Mitigation |
| --- | --- |
| GMS privilege creep | No `signature\|privileged` by default |
| Network exfil | Per-app network controls (TASK_047) still apply |
| Location leak | Does not replace AnaOS network location policy |
| Update confusion | Play cannot update AnaOS system components |

## User journey (draft)

1. Settings → Apps → Sandboxed Google Play → Enable  
2. Clear warning: Google account / Play terms are Google’s  
3. Install Play Store in sandbox profile/user as designed  
4. One-tap disable returns to Play-free state  

## Ban

- Pre-enabling Play on first boot  
- Granting signature|privileged to GMS by default  
- Using Play as the AnaOS update channel  
- Shipping Google apps in `PRODUCT_PACKAGES` for official user builds  

## Dependencies

- TASK_045 SELinux domains  
- Profile isolation (TASK_049)  
- Track B review before any binder allowlist expansion  

## Status

Design-only until device overlay + GrapheneOS-derived implementation port.
