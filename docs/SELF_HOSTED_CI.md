# Self-hosted CI for AOSP (TASK_005 extension)

GitHub Actions meta-ci stays on `ubuntu-latest`. Full tree builds need a
self-hosted or rented Linux runner — never sign there.

## Runner profile

| Spec | Minimum | Notes |
| --- | --- | --- |
| CPU | 16 vCPU | Match CPX62-class |
| RAM | 64 GB preferred / 32 GB + swap | 32GB needs `-j4` |
| Disk | ≥1 TB NVMe | One tree + `out/` |
| OS | Ubuntu 24.04 | Same as `BUILD_HOST.md` |

## Labels (draft)

```text
runs-on: [self-hosted, anaos-aosp, linux]
```

Jobs allowed on that label: sync (optional), unsigned `m`, artifact upload of
**unsigned** outputs. Jobs **forbidden**: keygen, `sign_anaos_release`, anything
with `.pk8`.

## Lifecycle

1. Ephemeral VM per release candidate (prefer)  
2. Register runner → run workflow → drain → **delete VM** (`COST_OPS.md`)  
3. Do not keep a 24/7 AOSP runner “warm” without a calendar reason  

## Workflow sketch

```yaml
# future: .github/workflows/aosp-unsigned.yml
# on: workflow_dispatch
# jobs:
#   build:
#     runs-on: [self-hosted, anaos-aosp]
#     steps: sync / overlay / lunch / m / upload-unsigned
```

Promote to sign only via human + air-gap (`RELEASE_PROCESS.md`).
