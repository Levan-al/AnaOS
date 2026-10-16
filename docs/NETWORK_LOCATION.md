# Network location (TASK_051 draft)

Own network-based location stack as a privacy-respecting alternative to stock
fused location with Google backends.

## Goals

- Optional Wi‑Fi / cell–based location without Google location services.  
- Explicit user enablement; off by default or clearly labeled.  
- No silent upload of BSSID/cell towers to AnaOS unless user opts into a
  contribution mode (future; not MVP).  
- SELinux-confined service; Track B review before privileged binder APIs.

## MVP scope

| Item | Status |
| --- | --- |
| Policy + threat notes (this doc) | draft |
| Provider package `org.anaos.location` | not started |
| Offline cache / local multilateration | research |
| Contribution opt-in | deferred |

## Threat notes

- BSSID databases are sensitive; treat as PII-adjacent.  
- Prefer on-device inference from user-supplied / locally cached data.  
- Do not hard-depend on a single commercial geolocation API.  
- Sandboxed Play (TASK_050) must not become a backdoor for Google location.

## Dependencies

- TASK_045 SELinux domains  
- TASK_018 tree overlay before platform integration  
- `docs/PRIVACY_CONTROLS.md` for UX language
