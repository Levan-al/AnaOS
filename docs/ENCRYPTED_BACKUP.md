# Encrypted backup (TASK_064)

User-controlled encrypted backups without Google Backup by default.

## Direction

- Local export (file) and optional self-hosted endpoint  
- Strong encryption (age / AES-GCM); passphrase or hardware key  
- No plaintext cloud sync in official builds  

## Ban

- Silent upload to AnaOS or third-party servers  
- Requiring Google account for backup  

Blocked on product UX + SELinux domains after TASK_045.
