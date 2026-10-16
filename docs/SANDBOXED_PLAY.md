# Sandboxed Google Play compatibility (TASK_050)

Optional layer for apps that need Play services — **never** required for AnaOS
core functionality.

## Principles

- Runs isolated from privileged OS components  
- User must explicitly enable  
- No privileging Google apps over AnaOS apps  
- Track GrapheneOS sandboxed Play design; rebrand and audit  

## Ban

- Pre-enabling Play on first boot  
- Granting signature|privileged to GMS by default  
