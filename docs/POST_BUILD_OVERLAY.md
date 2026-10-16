# Post-BUILD_OK overlay (TASK_018 follow-on)

What to do on the build host immediately after `/opt/anaos/BUILD_OK` appears.

## Preconditions

- `SYNC_OK` and `BUILD_OK` present  
- tmux `aosp-build` idle or stopped cleanly  
- Meta checkout available with `device/anaos` + `branding`  
- Disk headroom for a second `m` (or rebuild overlay products only)  

## Steps

```bash
# On anaos-build — keys stay offline; this is unsigned product wiring only
export META=/path/to/AnaOS-meta   # clone of Levan-al/AnaOS
bash /opt/anaos/post-build-overlay.sh
# or: META=... bash scripts/post-build-overlay.sh

cd /opt/anaos/aosp
source build/envsetup.sh
lunch anaos_emulator-userdebug   # name per device/anaos/emulator
m -j4
```

Marker: `/opt/anaos/OVERLAY_OK` written by `post-build-overlay.sh`.

## Verify

- [ ] Fingerprint / About contains Ana / AnaOS / `org.anaos`  
- [ ] `official.mk` inherit active on product  
- [ ] No GrapheneOS update hosts in Updater overlays  
- [ ] Track B smoke: `scripts/check-security-gate.sh`  

## Cost

After overlay smoke (or hard fail), **delete or power-off** the Hetzner CPX62
per `COST_OPS.md` unless a scheduled overnight kernel job is queued.

## Do not

- Start a second full `repo sync` of AOSP 17 on the same disk without a plan  
- Copy `.pk8` release keys onto the host  
- Claim “AnaOS release” from stock `sdk_phone64_*` lunch without overlay  
