# Building AnaOS (TASK_083 draft / TASK_017–018)

## Environment

- Ubuntu 24.04 LTS  
- ≥16 CPU, ≥64 GB RAM, ≥1 TB NVMe recommended  
- Current rental: Hetzner CPX62 (16 vCPU / 32 GB / ~600 GB) — workable for first sync; heavy LTO builds may need more RAM  

Install packages: see `scripts/remote-bootstrap-hetzner.sh`.

## Sync

```bash
export PATH=$HOME/bin:$PATH
mkdir -p /opt/anaos/aosp && cd /opt/anaos/aosp
repo init --partial-clone --no-use-superproject \
  -u https://android.googlesource.com/platform/manifest \
  -b android-latest-release
repo sync -c -j4 --no-tags --optimized-fetch --prune
```

AnaOS product overlays (`device/anaos`, `branding`) are applied after the base tree exists (TASK_014–016).

## Reproducibility pins

```bash
export BUILD_DATETIME=20261016000000   # example; set per release
export BUILD_NUMBER=2026101600
```

See `docs/REPRODUCIBLE_BUILDS.md`.

## Emulator user build (TASK_018)

```bash
# After SYNC_OK — overlay AnaOS product trees into the AOSP checkout:
#   ./scripts/overlay-anaos-into-aosp.sh /opt/anaos/aosp
source build/envsetup.sh
lunch sdk_phone64_x86_64-user   # or listed fallbacks in remote-aosp-build.sh
# When device/anaos is overlaid:
# lunch anaos_emulator-userdebug
m -j8
```

Verify branding strings / fingerprint contain `AnaOS` / `Ana` / `org.anaos`.

## Pixel 8 stub (TASK_028)

`lunch ana_shiba-userdebug` requires vendor extract (TASK_029). Product stubs live in
`device/anaos/shiba/` — see `docs/DEVICES.md`.

## Signing

Official images are signed **offline** only. See `docs/KEY_CEREMONY.md`.  
Do not copy `.pk8` keys onto rented cloud hosts.

## Common errors

| Symptom | Likely cause |
| --- | --- |
| OOM during `m` | Lower `-j`, add swap, or larger machine |
| Disk full | Need ≥400–600 GB free for one build |
| Wrong fingerprint brand | Missing branding / official.mk inherit |
| `Cannot initialize work tree` mid-sync | Re-run `scripts/remote-repair-sync.sh` after sync exits |
