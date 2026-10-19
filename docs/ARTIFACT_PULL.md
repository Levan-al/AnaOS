# Pull artifacts from Hetzner (Phase B)

Run **only after** `/opt/anaos/OVERLAY_BUILD_OK` exists. Then delete the host.

## From your laptop (PowerShell / OpenSSH)

```powershell
# Markers + reports
scp anaos-build:/opt/anaos/OVERLAY_BUILD_OK .
scp anaos-build:/opt/anaos/SLEEP_REPORT.txt .
scp anaos-build:/opt/anaos/BRINGUP.txt .
scp anaos-build:/opt/anaos/overlay-build.log .

# Images (create a local folder first)
mkdir anaos-emulator-out
scp anaos-build:/opt/anaos/aosp/out/target/product/emulator/system.img anaos-emulator-out/
scp anaos-build:/opt/anaos/aosp/out/target/product/emulator/product.img anaos-emulator-out/
scp anaos-build:/opt/anaos/aosp/out/target/product/emulator/vendor.img anaos-emulator-out/
scp anaos-build:/opt/anaos/aosp/out/target/product/emulator/system_ext.img anaos-emulator-out/
scp anaos-build:/opt/anaos/aosp/out/target/product/emulator/system_dlkm.img anaos-emulator-out/
scp anaos-build:/opt/anaos/aosp/out/target/product/emulator/vendor_boot.img anaos-emulator-out/
scp anaos-build:/opt/anaos/aosp/out/target/product/emulator/vbmeta.img anaos-emulator-out/
scp anaos-build:/opt/anaos/aosp/out/target/product/emulator/ramdisk.img anaos-emulator-out/
scp anaos-build:/opt/anaos/aosp/out/target/product/emulator/super.img anaos-emulator-out/
```

If `super.img` is missing but OK marker exists, still pull the component images + logs.

## Then

1. Verify sizes look sane (`ls` / Explorer).  
2. Hetzner Console → **Delete** `anaos-build` (`COST_OPS.md`).  
3. Optional later: boot on a machine with emulator + `EMULATOR_SMOKE.md`.  
