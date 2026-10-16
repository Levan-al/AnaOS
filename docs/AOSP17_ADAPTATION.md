# AOSP 17 adaptation playbook (TRACK A)

Fast, controlled absorption of Android 17 / AOSP 17 platform changes.

## Objectives

- Pin AnaOS to a known AOSP 17 tag (not floating `latest` for releases).  
- Rebase hardening and branding patches with a conflict ledger.  
- Keep emulator + first device (`shiba`) buildable after each major rebase.  

## Pin criteria (TASK_095)

Tag shortlist and P0 choice: **`docs/AOSP17_TAG_SHORTLIST.md`**
(current P0: `android-17.0.0_r1`).

A release pin is valid only if **all** are true:

1. Manifest points at an explicit AOSP / Android 17 tag or dated security release (not `android-latest-release`).  
2. `scripts/release-env.sh` (or successor) records `BUILD_DATETIME` / `BUILD_NUMBER` for that pin.  
3. Emulator userdebug smoke passed on the pin (TASK_018 path).  
4. **Track B gate** ACK (`docs/SECURITY_MERGE_GATE.md`).  
5. Branding + `official.mk` still inherit on AnaOS products.  

Staging branch name: `anaos-aosp17-stage` (manifest + patch queue).  
Release branch name: `anaos-aosp17` (promoted pins only).

## Cadence

| Phase | Action |
| --- | --- |
| Discover | Track AOSP release notes / Security Bulletins for 17 |
| Stage | `repo` init on staging manifest branch `anaos-aosp17-stage` |
| Rebase | Apply AnaOS + GrapheneOS-derived patches; log conflicts |
| Validate | Emulator userdebug smoke; SELinux enforcing; fingerprint brand check |
| B gate | Complete `SECURITY_MERGE_GATE.md` checklist |
| Promote | Update release pin (`scripts/release-env.sh` / manifest) after B sign-off |

## Conflict ledger (start empty)

| Upstream area | Conflict | Resolution | Track B impact |
| --- | --- | --- | --- |
| _(fill during first 17 rebase)_ | | | |

## Relation to current sync

Hetzner first sync may use `android-latest-release` for bring-up (TASK_018).  
TRACK A replaces that with an explicit **AOSP 17** pin before official images.
After SYNC_OK: record the resolved manifest commit SHA here, then open staging rebase toward 17.
