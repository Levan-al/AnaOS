# Factory image pipeline (TASK_026 prep)

How AnaOS produces a **fully signed** factory image. Private keys stay offline.

## Preconditions

| Gate | Requirement |
| --- | --- |
| TASK_018 | Emulator (or device) `user`/`userdebug` tree builds (`BUILD_OK`) |
| TASK_025 | `script/sign_anaos_release.sh` (and siblings) reviewed |
| TASK_019–022 | Offline key ceremony complete; **no** `.pk8` on cloud |
| Track B | `SECURITY_MERGE_GATE.md` ACK for the release candidate |

## Flow (unsigned → signed → publish)

```
[build host] m target-files-package
       │
       ▼
  unsigned target-files.zip  ──copy via air-gap──►  [offline signer]
                                                         │
                                              sign_anaos_release.sh
                                                         │
       ◄── signed factory + OTA packages ────────────────┘
       │
       ▼
  [release host] upload to CDN paths in ARTIFACT_CDN.md
       │
       ▼
  Updater / installers consume metadata (DISTRIBUTION.md)
```

## Build host (cloud OK)

- Produce **unsigned** `target-files` / images only.  
- Record `BUILD_DATETIME` / `BUILD_NUMBER` (`scripts/release-env.sh`).  
- Never generate or store release keys on Hetzner or CI runners.

## Offline signer

1. Verify hash of inbound unsigned artifact.  
2. Run `script/sign_anaos_release.sh` with keys from air-gapped media.  
3. Produce factory zip + OTA package + public fingerprints.  
4. Run `scripts/record-public-key-fingerprints.sh` (or equivalent).  
5. Export only signed outputs + fingerprint logs.

## First milestone definition of done

- [ ] Signed factory image for first supported product (emulator proof, then `shiba`)  
- [ ] AVB signed with AnaOS AVB key  
- [ ] Fingerprints published (no private material)  
- [ ] Install documented in `docs/DISTRIBUTION.md` / CLI installer  

Until TASK_018 completes, this document is process-only.
