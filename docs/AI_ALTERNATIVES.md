# On-device AI alternatives (TRACK C2)

Privacy-preserving assistive features as an **alternative** to stock cloud AI —
not a clone of Google’s AI stack, and **not** the Qizi AI Ops product.

## Boundary

| Product | Scope |
| --- | --- |
| **AnaOS (this repo)** | On-device models, OS APIs, SELinux domains, user consent UX |
| **qizimarket.com/anaos AI Ops** | Separate FastAPI / ops stack — out of scope (`PRODUCT_SCOPE.md`) |

Do not share signing keys, update channels, or default network endpoints between them.

## Design rules

- Default: **offline**. Network inference requires explicit, revocable consent.  
- No silent uploads of mic, camera, SMS, or notifications.  
- Dedicated `org.anaos.ai.*` (or similar) package prefix; unprivileged by default.  
- Models are user-visible (download size, license, update channel).  
- Track B reviews any binder/system-server integration.

## Candidate capabilities (priority order)

1. On-device OCR / text extract (gallery / PDF adjacency)  
2. Offline speech-to-text toggle for accessibility  
3. Local classification (e.g. spam heuristics) without cloud  
4. Optional federated-free “smart” features only after 1–3 ship

## Non-goals

- Training user data on AnaOS servers by default  
- Bundling a cloud assistant that phones home  
- Replacing hardened Browser/WebView with an AI shell
