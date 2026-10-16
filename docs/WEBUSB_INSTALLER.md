# WebUSB installer (TASK_070)

Browser-based flash for supported devices. Secondary to CLI (`INSTALL_CLI.md`).

## Goals

- Guided install without installing a native flash tool (Chrome/Edge + WebUSB).  
- Same signed factory artifacts as CLI path.  
- Clear wipe / unlock warnings before any write.  

## Non-goals (v1)

- Supporting every Chromium fork  
- Flashing unsigned / developer-signed images in production UI  
- Bypassing AVB or lock requirements  

## Architecture sketch

```text
Browser UI  --WebUSB-->  bootloader
    │
    └── fetches factory zip from dl.anaos.org (CORS + checksum)
```

- Static site only; no user accounts.  
- Checksum verify in-browser before flash.  
- Device allowlist by USB VID/PID + codename.  

## Security

| Risk | Mitigation |
| --- | --- |
| Malicious site | Serve only from `anaos.org` / dedicated install host; SRI on JS |
| Downgrade | Enforce min build / anti-rollback metadata |
| Confused deputy | Explicit confirmation; show fingerprint of image |

Track B must review before public enablement.

## Order vs CLI

1. CLI docs + scripts (TASK_071)  
2. WebUSB MVP for `shiba` only  
3. Expand SKUs after porting guide stable  
