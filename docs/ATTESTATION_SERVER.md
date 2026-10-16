# Remote attestation server (TASK_073–075)

Pairs with `org.anaos.auditor` and `attestation.anaos.org`.
Client integration checklist: `AUDITOR_INTEGRATION.md`.

## Goals

- Optional scheduled device integrity checks  
- Alert channel (email later; PGP when domain ready)  
- Public key inventory for Auditor  

## Components

| Piece | Notes |
| --- | --- |
| API | HTTPS only; rate-limited |
| Store | Attestation records encrypted at rest |
| Trust | AnaOS release keys / AVB public material |
| Client | Auditor app scaffold |

## API sketch (MVP)

```text
POST /v1/attest   — device submits attestation chain (auth: device key / token)
GET  /v1/status   — public health
GET  /v1/keys     — public fingerprint inventory (read-only)
```

## Data minimization

- Store hashes / verdicts; avoid full disk dumps  
- Retention limit documented at deploy time  
- User can disable remote checks (local-only mode)  

## Blockers

- TASK_002 domains  
- TASK_006 storage  
- First signed builds for meaningful samples  

## Ban

- Coupling to qizimarket AI Ops  
- Requiring attestation for basic phone use  
- Accepting attestations from test-keys as “official green”  
