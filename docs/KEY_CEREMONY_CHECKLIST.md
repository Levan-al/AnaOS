# Offline key ceremony checklist (TRACK B)

Print this page. Check boxes **on paper** during the ceremony.  
Never run these steps on Hetzner, CI, or a networked daily laptop.

**Practical timeline + kit list:** `AIRGAP_PRACTICAL.md` (use that as the day script).

Related: `KEY_CEREMONY.md`, `AIRGAP_DAY.md`, `APP_SIGNING.md`, `KEY_RECOVERY.md`,
`script/make_anaos_*.sh`.

## Before (day −1)

- [ ] Air-gapped machine identified (spare laptop / mini-PC)
- [ ] Known-good OS install media verified (hash written below)
- [ ] Two maintainers scheduled (four-eyes)
- [ ] Clean USB A (public PEMs out) and USB B (encrypted private store) prepared
- [ ] Offline copies of: `development/tools/make_key`, OpenSSL, `avbtool` (from a trusted AOSP tree)
- [ ] Paper logbook + pen; no phones in the room

```text
OS media hash: ________________________________
make_key path/hash: ___________________________
openssl version: ______________________________
Date/time start (UTC): ________________________
Present: ____________________________________
```

## Generate (air-gap only)

From a directory that will become the offline key store:

```bash
# Platform / media / shared / releasekey / otakey
./script/make_anaos_keys.sh "$HOME/anaos-keys"

# AVB
./script/make_anaos_avb_key.sh "$HOME/anaos-keys/avb"
# Then on same machine (AOSP tree available offline):
# avbtool extract_public_key --key "$HOME/anaos-keys/avb/avb.pem" \
#   --output "$HOME/anaos-keys/avb/avb_pkmd.bin"

# First-party apps
./script/make_anaos_app_keys.sh "$HOME/anaos-keys/apps"
```

- [ ] `platform` created  
- [ ] `media` created  
- [ ] `shared` created  
- [ ] `releasekey` created  
- [ ] `otakey` created (or documented reuse of releasekey)  
- [ ] `avb.pem` + `avb_pkmd.bin` created  
- [ ] app keys: updater, auditor, camera, appstore, pdfviewer  

## Public export only

- [ ] Copy **only** `*.x509.pem` and `avb_pkmd.bin` to USB A  
- [ ] Confirm USB A has **zero** `*.pk8` / `avb.pem`  
- [ ] Record SHA-256 of each public file in the logbook  

```bash
# Example (air-gap):
find "$HOME/anaos-keys" \( -name '*.x509.pem' -o -name 'avb_pkmd.bin' \) -print0 \
  | sort -z | xargs -0 sha256sum
```

## Private store

- [ ] Encrypt private store (LUKS or age) on USB B  
- [ ] Shamir / recovery split per `KEY_RECOVERY.md`  
- [ ] Wipe plaintext copies from ceremony disk (secure erase)  
- [ ] Seal USB B; note storage location (not in git, not in cloud)

## After (online, public only)

- [ ] From USB A, publish fingerprints (signed JSON — TASK_073)  
- [ ] Update ceremony completion note in internal log (no private material)  
- [ ] Mark TASK_019–022 keygen complete in `PLAN.yaml` when done  

## Explicit fail if

- Any `.pk8` appeared on a networked machine  
- Ceremony machine was online during generation  
- Test-keys or GrapheneOS/AOSP sample keys used for “temporary” official builds  
