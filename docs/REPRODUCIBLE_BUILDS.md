# Reproducible builds (TASK_017 / TASK_087)

## Goals

Independent rebuilds of the same source pin + inputs produce bit-identical artifacts (or documented allow-listed deltas).

## Controls

| Input | Policy |
| --- | --- |
| `BUILD_DATETIME` | Fixed per release from release script |
| `BUILD_NUMBER` | Fixed per release |
| Toolchains / prebuilts | Pinned by manifest revision |
| Source tree | Clean `repo sync` at tagged manifest |
| Branding | From `branding/` at known commit |

## Verification workflow (outline)

1. Tag release sources (`platform_manifest` + device trees)  
2. Official builder produces signed images offline  
3. Community rebuilds **unsigned** target-files with same datetime/number  
4. Compare digests of unsigned payloads; signing material differs by design  

Reference: GrapheneOS community reproducibility discussions and AOSP `target-files` comparison practices.

## AnaOS status

- Build host scripts: `scripts/remote-aosp-*.sh`  
- Full reproducibility gate lands after first signed factory image (TASK_026)  
