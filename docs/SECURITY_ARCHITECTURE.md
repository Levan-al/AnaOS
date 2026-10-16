# Security architecture (TASK_085)

High-level AnaOS security stack. Implementation follows Track B primacy
(`STRATEGY.md`, `SECURITY_MERGE_GATE.md`).

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
| AVB | `AVB_BOOTLOADER_LOCK.md`, `make_anaos_avb_key.sh` |
| OTA | `UPDATE_SERVER.md`, `ROLLBACK_PROTECTION.md` |
| Attestation | `ATTESTATION_SERVER.md` |
| Merge gate | `SECURITY_MERGE_GATE.md` |
| Install path | `INSTALL_CLI.md`, `WEBUSB_INSTALLER.md` |

## Control mapping (PLAN → layer)

| Area | PLAN tasks | Primary docs |
| --- | --- | --- |
| Memory safety | 040–044 | `HARDENED_MALLOC.md`, `CFI_AND_SCS.md`, `MEMORY_SAFETY.md` |
| Isolation | 045–049 | `SELINUX_HARDENING.md`, `PRIVACY_CONTROLS.md` |
| Privacy extras | 050–055 | `SANDBOXED_PLAY.md`, `DNS_PRIVACY.md`, `NETWORK_LOCATION.md` |
| Kernel | 034–039 | `KERNEL.md` |
| Updates | 066–072 | `DISTRIBUTION.md`, `ROLLBACK_PROTECTION.md` |
| Attestation | 073–075 | `ATTESTATION_SERVER.md` |

## Invariants (non-negotiable)

1. Production builds signed offline; no cloud private keys.  
2. Verified boot green on official user images; bootloader lockable.  
3. SELinux enforcing; no permissive “for convenience” on release.  
4. Updater trusts only AnaOS hosts / keys.  
5. Track B may veto Track A/C merges that regress the above.  

## Data flow (update)

```text
Build host (unsigned) → air-gap sign → CDN → Updater verify → apply → reboot → VB green
```

## Related

- Threat delta: `THREAT_MODEL_ANDROID17.md`  
- External review: `SECURITY_AUDIT.md`  
- Bounty: `BUG_BOUNTY.md`  
