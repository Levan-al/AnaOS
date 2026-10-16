# CFI / SCS / PAC (TASK_041–042)

Control Flow Integrity and Shadow Call Stack / Pointer Authentication where
hardware and AOSP toolchain support them.

## Goals

| Feature | TASK | Target |
| --- | --- | --- |
| CFI | 041 | Keep enabled; never strip to “fix the build” |
| SCS / PAC | 042 | Enable on arm64 devices (`shiba`+) |

## Integration notes

- Prefer AOSP/GrapheneOS defaults for `user` arm64 products.  
- Document any target that must disable a check (name the binary + reason).  
- Emulator `x86_64` may lack PAC; do not use that as excuse to disable on device.  

## Emulator note

First TASK_018 lunch is `x86_64` emulator — CFI/SCS device policy is validated
on Pixel trees after vendor extract. Emulator success ≠ hardening complete.

## Validation (device)

- [ ] `user` build boots with CFI-enabled binaries  
- [ ] No global `LOCAL_DISABLE_CFI` in AnaOS product makefiles  
- [ ] SCS/PAC confirmed on Tensor arm64 where HW allows  

## Gate

Any CL that turns off CFI/SCS for `user` builds fails Track B
(`SECURITY_MERGE_GATE.md`).
