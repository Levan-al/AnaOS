# Building AnaOS (TASK_083 draft / TASK_017–018)

Complete build documentation expands as TASK_018 (`BUILD_OK`) and TASK_026
(signed factory) land. This page is the working runbook for bring-up hosts.

## Environment

- Ubuntu 24.04 LTS  
- ≥16 CPU, ≥64 GB RAM, ≥1 TB NVMe recommended  
- Current rental: Hetzner CPX62 (16 vCPU / 32 GB / ~600 GB) — workable for first sync; use `-j4` + swap on 32 GB  

Install packages: see `scripts/remote-bootstrap-hetzner.sh`.

Cost / idle rules: `docs/COST_OPS.md` — delete the server after BUILD_OK or hard fail.

## Sync

```bash
export PATH=$HOME/bin:$PATH
mkdir -p /opt/anaos/aosp && cd /opt/anaos/aosp
repo init --partial-clone --no-use-superproject \
  -u https://android.googlesource.com/platform/manifest \
  -b android-latest-release
repo sync -c -j4 --no-tags --optimized-fetch --prune
```

Marker: `/opt/anaos/SYNC_OK` (written by sync scripts).

AnaOS product overlays (`device/anaos`, `branding`) are applied after the base
tree exists (TASK_014–016). Helper: `scripts/overlay-anaos-into-aosp.sh`.

## Watchdog + status

```bash
# On build host (tmux sessions used in bring-up):
#   aosp-build     — lunch + m
#   aosp-watchdog  — scripts/remote-build-watchdog.sh
cat /opt/anaos/STATUS.txt
tail -n 5 /opt/anaos/build.log
test -f /opt/anaos/BUILD_OK && echo BUILD_OK
```

Do **not** start a second full AOSP tree on the same CPX62 (disk + billing).

## Reproducibility pins

```bash
export BUILD_DATETIME=20261016000000   # example; set per release
export BUILD_NUMBER=2026101600
source scripts/release-env.sh          # when used in-repo
```

See `docs/REPRODUCIBLE_BUILDS.md` and `docs/REPRODUCIBLE_VERIFY.md`.

## Emulator user build (TASK_018)

```bash
# After SYNC_OK — overlay AnaOS product trees into the AOSP checkout:
#   ./scripts/overlay-anaos-into-aosp.sh /opt/anaos/aosp
source build/envsetup.sh
lunch sdk_phone64_x86_64-trunk_staging-user   # Hetzner bring-up chose this
# When device/anaos is overlaid:
# lunch anaos_emulator-userdebug
m -j4   # or ANAOS_BUILD_JOBS; host may use -j8 with swap
```

Success marker: `/opt/anaos/BUILD_OK`. Prefer tmux `aosp-after` /
`scripts/remote-after-build.sh` (see `POST_BUILD_OVERLAY.md`).

Bring-up snapshot: `scripts/remote-record-bringup.sh` → `/opt/anaos/BRINGUP.txt`.

Verify branding strings / fingerprint contain `AnaOS` / `Ana` / `org.anaos`.

## Pixel 8 stub (TASK_028)

`lunch ana_shiba-userdebug` requires vendor extract (TASK_029). Product stubs live in
`device/anaos/shiba/` — see `docs/DEVICES.md`, `docs/DEVICE_PORTING.md`.

## Signing

Official images are signed **offline** only. See `docs/KEY_CEREMONY.md` and
`docs/FACTORY_IMAGE.md`. Do not copy `.pk8` keys onto rented cloud hosts.

## AOSP 17 pin (TRACK A)

Bring-up may use `android-latest-release`. Official pins move to
`android-17.0.0_r1` (see `docs/AOSP17_TAG_SHORTLIST.md`) after BUILD_OK + disk
headroom, with conflicts logged in `docs/AOSP17_REBASE_LEDGER.md`.

## Common errors

| Symptom | Likely cause |
| --- | --- |
| OOM during `m` | Lower `-j`, add swap, or larger machine |
| Disk full | Need ≥400–600 GB free for one build |
| Wrong fingerprint brand | Missing branding / official.mk inherit |
| `Cannot initialize work tree` mid-sync | Re-run `scripts/remote-repair-sync.sh` after sync exits |
| HTTP 429 during sync | `scripts/remote-repair-retry.sh` + backoff |
| CRLF `bash\r` errors | LF scripts + `.gitattributes`; fix on host |

## Local app scaffolds (parallel)

Debug APKs for `org.anaos.*` apps can build on a workstation without AOSP:

```powershell
pwsh ./scripts/build-app-scaffolds.ps1
```

These are **not** platform-signed release artifacts.
