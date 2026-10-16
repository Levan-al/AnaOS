# Post-BUILD_OK overlay (TASK_018 follow-on)

What to do on the build host immediately after `/opt/anaos/BUILD_OK` appears.

## Preconditions

- `SYNC_OK` and `BUILD_OK` present  
- tmux `aosp-build` idle or stopped cleanly  
- Meta at `/opt/anaos/meta` (`META_OK` via `scripts/remote-stage-meta.sh`)  
- Disk headroom for a second `m` (host had ~300G+ free at bring-up)  

## Stage meta (can run **during** compile)

```bash
# Does not touch aosp/out — safe while ninja runs
bash /opt/anaos/remote-stage-meta.sh
# → /opt/anaos/meta + /opt/anaos/META_OK
```

## Overlay after BUILD_OK

```bash
export META=/opt/anaos/meta
bash /opt/anaos/post-build-overlay.sh
# writes /opt/anaos/OVERLAY_OK

cd /opt/anaos/aosp
source build/envsetup.sh
lunch anaos_emulator-userdebug
m -j4
```

If `anaos_emulator-*` is missing from lunch, fall back to documenting the
stock combo that succeeded for TASK_018 and fix product inherit paths against
that AOSP pin (see `device/anaos/emulator/`).

## Verify

- [ ] Fingerprint / props show Ana / AnaOS (`PRODUCT_PROPERTIES.md`)  
- [ ] `ro.anaos.*` present  
- [ ] Track B smoke from meta: `bash /opt/anaos/meta/scripts/check-security-gate.sh`  
- [ ] Emulator smoke: `EMULATOR_SMOKE.md`  

## Cost

After overlay smoke (or hard fail), **delete** CPX62 per `COST_OPS.md` unless
a scheduled job remains.

## Do not

- Second full AOSP 17 sync on the same disk without a plan  
- Copy `.pk8` keys onto the host  
- Claim “AnaOS release” from stock lunch without overlay  
