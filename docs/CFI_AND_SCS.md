# CFI / SCS / PAC (TASK_041–042)

Control Flow Integrity and Shadow Call Stack / Pointer Authentication where
hardware and AOSP toolchain support them.

## Goals

| Feature | TASK | Target |
| --- | --- | --- |
| CFI | 041 | Keep enabled; never strip to “fix the build” |
| SCS / PAC | 042 | Enable on arm64 devices (`shiba`+) |

## Emulator note

First TASK_018 lunch is `x86_64` emulator — CFI/SCS device policy is validated
on Pixel trees after vendor extract. Emulator success ≠ hardening complete.

## Gate

Any CL that turns off CFI/SCS for `user` builds fails Track B
(`docs/SECURITY_MERGE_GATE.md`).
