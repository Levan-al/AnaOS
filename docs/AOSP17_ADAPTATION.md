# AOSP 17 adaptation playbook (TRACK A)

Fast, controlled absorption of Android 17 / AOSP 17 platform changes.

## Objectives

- Pin AnaOS to a known AOSP 17 tag (not floating `latest` for releases).  
- Rebase hardening and branding patches with a conflict ledger.  
- Keep emulator + first device (`shiba`) buildable after each major rebase.  

## Cadence

| Phase | Action |
| --- | --- |
| Discover | Track AOSP release notes / Security Bulletins for 17 |
| Stage | `repo` init on staging manifest branch `anaos-aosp17-stage` |
| Rebase | Apply AnaOS + GrapheneOS-derived patches; log conflicts |
| Validate | Emulator userdebug smoke; SELinux enforcing; fingerprint brand check |
| Promote | Update release pin (`scripts/release-env.sh` / manifest) after B sign-off |

## Conflict ledger (start empty)

| Upstream area | Conflict | Resolution | Track B impact |
| --- | --- | --- | --- |
| _(fill during first 17 rebase)_ | | | |

## Relation to current sync

Hetzner first sync may use `android-latest-release` for bring-up (TASK_018).  
TRACK A replaces that with an explicit **AOSP 17** pin before official images.
