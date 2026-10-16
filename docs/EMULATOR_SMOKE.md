# Emulator smoke checklist (post TASK_018)

Run after `BUILD_OK` and preferably after overlay (`POST_BUILD_OVERLAY.md`).

## Boot

- [ ] Emulator image boots to home/launcher  
- [ ] `getenforce` → `Enforcing` (when policy present)  
- [ ] `adb shell getprop ro.build.fingerprint` shows expected brand after overlay  

## Branding (after overlay)

- [ ] About phone / settings strings: Ana / AnaOS  
- [ ] No GrapheneOS update URLs in Updater overlays  
- [ ] `bash scripts/verify-anaos-props.sh` against the emulator serial  

## Host facts

On the build host: `bash /opt/anaos/remote-record-bringup.sh` (or from meta
`scripts/remote-record-bringup.sh`) writes `/opt/anaos/BRINGUP.txt`.

## Updater scaffold (sideload debug APK OK)

- [ ] App installs  
- [ ] Cleartext blocked (`network_security_config`)  
- [ ] Check-for-update returns no network action with `NoOpUpdateRepository`  

## Negative

- [ ] Do not claim device/AVB validation from emulator alone  
- [ ] Do not sign with release keys on the rental host  

## Log artifacts

Save `logcat` snippet + fingerprint prop dump under a dated note in
`STATUS_REPORT.md` or release issue.
