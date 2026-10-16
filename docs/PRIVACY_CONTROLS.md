# Privacy controls (TASK_046–055)

Track B defaults for AnaOS vs stock Android 17. Implementation lands after
product overlay (post TASK_018).

| TASK | Control | AnaOS default direction |
| --- | --- | --- |
| 046 | Storage isolation | Strict scoped storage; no legacy broad access for untrusted apps |
| 047 | Network permission | Per-app network toggle; clear UI; deny background where policy allows |
| 048 | Sensors / clipboard / contacts / notifications | Clipboard auto-clear; sensor toggles; notification content privacy |
| 049 | Profile isolation | Work/secondary profile hardening; no cross-profile leakage by default |
| 050 | Sandboxed Google Play | Optional compatibility layer; never required for core OS |
| 051 | Network location | Own implementation path; no forced Google location |
| 052 | MAC randomization | Aggressive randomization defaults on Wi‑Fi / BT |
| 053 | DoH / DoT | See `DNS_PRIVACY.md` |
| 054 | Metadata stripping | EXIF/location strip on share where feasible |
| 055 | Permission auto-reset + hibernation | Idle apps lose grants; hibernate unused |

## Rules

- Defaults favor privacy; power users may loosen  
- No silent cloud analytics  
- Track B gate on any control that phones home  

## Delivery order

1. Product property / Settings overlays  
2. Framework hooks (GrapheneOS-inspired patches)  
3. CTS + AnaOS privacy regression (TASK_077)  
