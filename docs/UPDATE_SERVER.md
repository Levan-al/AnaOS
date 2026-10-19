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

1. **Metadata** — JSON per device + channel (schema below)  
2. **Signing** — classical release/otakey; hybrid PQ later (TRACK C / TASK_099)  
3. **Storage** — object store or static CDN (`ARTIFACT_CDN.md`)  
4. **Delta** — `DELTA_UPDATES.md`  
5. **Staged rollout** — cohort fields in metadata  
6. **Factory/OTA pipeline** — offline sign → upload (`FACTORY_IMAGE.md`)  
7. **Rollback** — `ROLLBACK_PROTECTION.md`  

## Fixtures (Phase D)

| Path | Role |
| --- | --- |
| `fixtures/ota/stable/emulator/metadata.json` | Valid sample |
| `fixtures/ota/stable/emulator/metadata.bad-host.json` | Must reject |
| `fixtures/ota/stable/emulator/metadata.channel-mismatch.json` | Must reject |

```bash
python3 scripts/validate_update_metadata.py fixtures/ota/stable/emulator/metadata.json --channel stable
python3 scripts/mock_ota_metadata_server.py --port 8765
```

## Metadata schema (draft)

Aligns with Updater `UpdateMetadata`:

```json
{
  "buildNumber": "2026101600",
  "channel": "stable",
  "device": "shiba",
  "incremental": false,
  "downloadUrl": "https://dl.anaos.org/ota/2026101600/payload.bin",
  "sha256": "...",
  "minBuildNumber": "2026090100",
  "classicalSignature": "...",
  "pqSignature": null,
  "cohort": { "percent": 100 },
  "securityPatchLevel": "2026-10-01"
}
```

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

Signatures verified client-side before apply. Installers:
`INSTALL_CLI.md`, `WEBUSB_INSTALLER.md`.
