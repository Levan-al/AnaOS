# Security architecture (TASK_085 draft)

High-level AnaOS security stack. Expand after hardening patches land.

## Layers

```text
┌─────────────────────────────────────────┐
│ Apps (org.anaos.*) + SELinux domains    │
├─────────────────────────────────────────┤
│ Framework isolation / privacy controls  │
├─────────────────────────────────────────┤
│ Bionic + hardened_malloc + CFI/SCS      │
├─────────────────────────────────────────┤
│ Kernel (own trees, MTE where possible)  │
├─────────────────────────────────────────┤
│ AVB + rollback + lockable bootloader    │
└─────────────────────────────────────────┘
```

## Trust anchors

| Anchor | Doc |
| --- | --- |
| Offline signing keys | `KEY_CEREMONY.md` |
| AVB | `make_anaos_avb_key.sh` |
| OTA | `UPDATE_SERVER.md` |
| Attestation | `ATTESTATION_SERVER.md` |
| Merge gate | `SECURITY_MERGE_GATE.md` |

## Related

- Threat delta: `THREAT_MODEL_ANDROID17.md`  
- Privacy: `PRIVACY_CONTROLS.md`  
- Memory: `HARDENED_MALLOC.md`, `CFI_AND_SCS.md`  
