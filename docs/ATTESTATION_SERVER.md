# Remote attestation server (TASK_073–075)

Pairs with `org.anaos.auditor` and `attestation.anaos.org`.

## Goals

- Optional scheduled device integrity checks  
- Alert channel (email later; PGP when domain ready)  
- Public key inventory for Auditor (TASK_073 fingerprints)  

## Components

| Piece | Notes |
| --- | --- |
| API | HTTPS only; rate-limited |
| Store | Attestation records encrypted at rest |
| Trust | AnaOS release keys / AVB public material |
| Client | Auditor app scaffold already points at `attestation.anaos.org` |

## Blockers

- TASK_002 domains  
- TASK_006 storage  
- First signed builds for meaningful samples  

## MVP sketch

```text
POST /v1/attest  — device submits attestation chain
GET  /v1/status  — public health
```

No coupling to qizimarket AI Ops.
