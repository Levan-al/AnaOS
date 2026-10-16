# Encrypted backup (TASK_064)

User-controlled encrypted backups without Google Backup by default.

## Goals

- Export app-selectable data to an encrypted archive the user holds.  
- Optional restore on a new AnaOS device with passphrase / hardware key.  
- No dependency on Google account.  

## Direction

| Mode | Description |
| --- | --- |
| Local file | Write `.anaos-backup` (name TBD) to user-chosen storage |
| Self-hosted | Optional HTTPS endpoint the user configures (not AnaOS cloud) |

Crypto candidates: age, or AES-256-GCM with Argon2id KDF. Final pick needs
Track B review + library audit.

## UX rules

- Explicit opt-in; progress and size shown before write.  
- Passphrase strength meter; warn on cloud-folder targets.  
- Restore requires unlock + confirmation of wipe/merge policy.  

## Ban

- Silent upload to AnaOS or third-party servers  
- Requiring Google account for backup  
- Including call logs / SMS without separate toggles  

## Components (planned)

| Piece | Package / area |
| --- | --- |
| Backup app / Settings entry | `org.anaos.backup` (TBD) |
| SELinux domain | `docs/SELINUX_APP_DOMAINS.md` |
| Transport | user URL only; certificate pins optional |

## Dependencies

- TASK_045 domains  
- Product overlay after TASK_018  
- Hardened storage isolation (TASK_046) so backups do not punch holes  

## MVP acceptance

- [ ] Create encrypted local backup of a test dataset  
- [ ] Restore on clean device  
- [ ] Confirm no network by default (firewall / tcpdump spot check)  
