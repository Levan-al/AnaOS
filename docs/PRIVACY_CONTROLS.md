# Privacy controls (TASK_046–055)

Track B defaults for AnaOS vs stock Android 17. Implementation lands after
product overlay (post TASK_018).

| TASK | Control | AnaOS default direction | Detail doc |
| --- | --- | --- | --- |
| 046 | Storage isolation | Strict scoped storage; no legacy broad access for untrusted apps | this |
| 047 | Network permission | Per-app network toggle; clear UI | this |
| 048 | Sensors / clipboard / contacts / notifications | Clipboard auto-clear; sensor toggles; notification privacy | this |
| 049 | Profile isolation | Work/secondary hardening; no cross-profile leakage by default | this |
| 050 | Sandboxed Google Play | Optional; never required for core OS | `SANDBOXED_PLAY.md` |
| 051 | Network location | Own path; no forced Google location | `NETWORK_LOCATION.md` |
| 052 | MAC randomization | Aggressive Wi‑Fi / BT defaults | this |
| 053 | DoH / DoT | On by default where possible | `DNS_PRIVACY.md` |
| 054 | Metadata stripping | EXIF/location strip on share where feasible | this |
| 055 | Permission auto-reset + hibernation | Idle apps lose grants | this |

## Per-control notes

### Storage (046)

Prefer modern media/photo pickers; block `MANAGE_EXTERNAL_STORAGE` for
untrusted apps unless user explicitly grants in special settings.

### Network (047)

Global + per-app kill switches. VPN apps remain possible; no silent
re-enable after revoke.

### Sensors / clipboard (048)

- Clipboard: auto-clear after short TTL; sensitive content indicators.  
- Mic/camera/location: QS tiles + per-app history.  
- Notification content hidden on lock screen by default (user may loosen).  

### Profiles (049)

Treat work/secondary as hostile to personal by default; intentional share
APIs only.

### MAC (052)

Per-network randomization; document any carrier/Wi‑Fi breakage escapes as
user-visible exceptions, not silent global disable.

### Metadata strip (054)

Share sheet / Gallery / PdfViewer adjacency: strip GPS and device tags
unless “keep metadata” checked.

### Auto-reset / hibernation (055)

Align with platform unused-app restrictions; tighten timers on AnaOS
products. Hibernated apps lose optional permissions.

## Rules

- Defaults favor privacy; power users may loosen  
- No silent cloud analytics  
- Track B gate on any control that phones home  

## Delivery order

1. Product property / Settings overlays  
2. Framework hooks (GrapheneOS-inspired patches)  
3. CTS + AnaOS privacy regression (TASK_077)  
