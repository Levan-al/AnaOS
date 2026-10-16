# CI/CD (TASK_005)

## Chosen stack (zero-cost first)

| Stage | Tool |
| --- | --- |
| Meta / docs / app lint | GitHub Actions (public) — `.github/workflows/meta-ci.yml` |
| Full AOSP build | Self-hosted or rented Linux — `SELF_HOSTED_CI.md` |
| Optional later | Woodpecker / Jenkins on self-hosted |

## Pipeline stages (target)

1. **sync** — `repo sync` at pinned manifest  
2. **branding** — apply `branding/` + `device/anaos`  
3. **build** — `lunch` + `m` / `target-files-package` (unsigned)  
4. **test** — smoke + security regression (TASK_077)  
5. **sign** — offline / HSM only (never in public GHA)  
6. **upload** — releases host (TASK_006; needs domains)  
7. **notify** — maintainers  

Production release requires **manual approval** before sign/upload.

## Current status

- [x] Meta CI on GitHub Actions  
- [x] Track B gate smoke (`scripts/check-security-gate.sh`) in meta-ci  
- [ ] Self-hosted runner label for AOSP (`SELF_HOSTED_CI.md`)  
- [ ] Staged release workflow (TASK_068 / TASK_069)  

Promote staging → release only with `SECURITY_MERGE_GATE.md` ACK.

## Meta-ci scope

Validates docs presence, branding YAML, and Track B smoke script. It does **not**
compile AOSP or produce factory images.
