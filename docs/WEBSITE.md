# Official website and user docs (TASK_089 draft)

Blocked on domain registration (TASK_002). Content architecture only.

## Intended hosts

| Host | Role |
| --- | --- |
| `anaos.org` | Marketing + user documentation |
| `releases.anaos.org` | Update metadata (not marketing HTML) |
| `dl.anaos.org` | Artifact CDN (factory / OTA) |
| `attestation.anaos.org` | Auditor backend |

Until DNS exists, keep docs in this meta repo under `docs/` and GitHub README.

## Site IA (MVP)

1. **Home** — AnaOS brand, one sentence privacy/security pitch, download CTA.  
2. **Install** — supported devices, CLI flash summary, link to factory images.  
3. **Features** — hardening highlights (no exaggerated claims).  
4. **Security** — link to `SECURITY.md`, severity, disclosure.  
5. **Source** — GitHub org map (`docs/REPOSITORIES.md`).  
6. **Privacy** — no telemetry by default; on-device AI consent rules.  

## Non-goals for v1

- Account systems / cloud sync portals  
- Bundling qizimarket AI Ops UI  
- Serving unsigned “convenience” builds  

## Build approach (when unblocked)

- Static site (Markdown → static generator) preferred for attack surface.  
- No third-party analytics by default.  
- CSP + HTTPS only; mirror critical install docs in-repo.
