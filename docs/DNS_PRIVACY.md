# DNS-over-HTTPS / DNS-over-TLS defaults (TASK_053)

Track B privacy default: encrypted DNS on by default for AnaOS products.

## Policy

| Setting | Official AnaOS |
| --- | --- |
| Private DNS mode | Automatic or specified provider (user-changeable) |
| Cleartext DNS | Not the default |
| Captive portal | Must still work (fallback path documented) |

## Implementation sketch

- Product overlay / Settings defaults in `device/anaos/common` or branding RRO  
- Prefer system Private DNS (DoT) first; DoH where platform supports  
- No forced AnaOS-operated resolver required for MVP (user may pick)  

## Ban

- Hardcoding a resolver that logs queries without disclosure  
- Breaking offline / captive portal without escape hatch  

## Dependencies

Needs working product overlay after TASK_018 + branding inherit.
