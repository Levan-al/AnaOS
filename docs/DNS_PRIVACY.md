# DNS-over-HTTPS / DNS-over-TLS defaults (TASK_053)

Track B privacy default: encrypted DNS on by default for AnaOS products.

## Policy

| Setting | Official AnaOS |
| --- | --- |
| Private DNS mode | Automatic or specified provider (user-changeable) |
| Cleartext DNS | Not the default |
| Captive portal | Must still work (fallback path documented) |
| AnaOS-operated resolver | Optional later; not required for MVP |

## Implementation sketch

- Product overlay / Settings defaults in `device/anaos/common` or branding RRO  
- Prefer system Private DNS (DoT) first; DoH where platform supports  
- Document user path: Settings → Network → Private DNS  
- Enterprise: allow managed config to set hostname  

## Captive portal escape

1. Detect captive portal failure  
2. Temporarily allow cleartext DNS / bypass for portal host  
3. Return to Private DNS after connectivity  

## Ban

- Hardcoding a resolver that logs queries without disclosure  
- Breaking offline / captive portal without escape hatch  
- Forcing a commercial resolver with affiliate telemetry  

## Dependencies

Needs working product overlay after TASK_018 + branding inherit.
Validate in TASK_077 privacy smoke.
