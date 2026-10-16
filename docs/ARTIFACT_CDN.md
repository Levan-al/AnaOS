# Artifact storage and CDN (TASK_006)

Blocked on domain registration (TASK_002). Architecture draft only.

## Targets

| Host | Content |
| --- | --- |
| `dl.anaos.org` | Factory images, OTA payloads, deltas |
| `releases.anaos.org` | Metadata JSON / channel index |
| Optional CDN | Cloudflare / self-hosted cache in front of object storage |

## Design

1. Offline sign on air-gap → copy **public** artifacts only to upload host  
2. Object storage (S3-compatible or static nginx)  
3. Immutable paths per `BUILD_NUMBER`  
4. Short cache TTL on metadata; long cache on content-addressed blobs  

## Ban

- Uploading `.pk8` / private keys  
- Mutable “latest” binaries without hash pin in metadata  

See also `UPDATE_SERVER.md`, `COST_OPS.md`.
