# Update server architecture (TASK_066–072 draft)

Serves OTA metadata and payloads for `org.anaos.updater` only.

## Hosts (planned domains — TASK_002)

| Host | Role |
| --- | --- |
| `releases.anaos.org` | Channel metadata (`stable` / `beta`) |
| `dl.anaos.org` | Payload / delta blobs |

Until domains exist, engineering may use a temporary host **explicitly listed**
in Updater — never third-party app stores.

## Components

1. **Metadata** — JSON/protobuf per device + channel (`UpdateMetadata` shape)  
2. **Signing** — classical release/otakey; hybrid PQ later (TRACK C / TASK_099)  
3. **Storage** — object store or static CDN (TASK_006)  
4. **Delta** — TASK_067  
5. **Staged rollout** — TASK_068  
6. **Factory/OTA pipeline** — TASK_069 (offline sign → upload public artifacts)  

## Security

- HTTPS only; HSTS  
- Pin / restrict in Updater `network_security_config`  
- Rollback protection (TASK_072)  
- No analytics phone-home in default metadata  

## Minimal MVP (after first signed build)

```text
GET https://releases.anaos.org/stable/<device>/metadata.json
GET https://dl.anaos.org/ota/<build_number>/payload.bin
```

Signatures verified client-side before apply.
