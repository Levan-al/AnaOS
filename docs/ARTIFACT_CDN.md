# Artifact storage and CDN (TASK_006)

Blocked on domain registration (TASK_002). Architecture draft only.

## Targets

| Host | Content |
| --- | --- |
| `dl.anaos.org` | Factory images, OTA payloads, deltas |
| `releases.anaos.org` | Metadata JSON / channel index |
| Optional CDN | Cloudflare / self-hosted cache in front of object storage |

## Path layout (draft)

```text
dl.anaos.org/
  factory/<device>/<BUILD_NUMBER>/...
  ota/<device>/<BUILD_NUMBER>/payload.bin
  ota/<device>/<BUILD_NUMBER>/payload.bin.sha256
  delta/<device>/<BASE>_<TO>/...

releases.anaos.org/
  stable/<device>/metadata.json
  beta/<device>/metadata.json
```

## Design

1. Offline sign on air-gap → copy **public** artifacts only to upload host  
2. Object storage (S3-compatible or static nginx)  
3. Immutable paths per `BUILD_NUMBER`  
4. Short cache TTL on metadata; long cache on content-addressed blobs  
5. Upload via scoped token / SSH; no interactive root on CDN for daily ops  

## Integrity

| Artifact | Published next to it |
| --- | --- |
| payload / factory zip | SHA256 sum file |
| metadata.json | classical signature field (+ optional PQ) |
| release notes | link fingerprint log from ceremony |

## Ban

- Uploading `.pk8` / private keys  
- Mutable “latest” binaries without hash pin in metadata  
- Overwriting an existing `BUILD_NUMBER` path  

See also `UPDATE_SERVER.md`, `STAGED_ROLLOUT.md`, `COST_OPS.md`.
