# Air-gap key ceremony — practical runbook

Printable, step-by-step. Complements `KEY_CEREMONY_CHECKLIST.md` and
`AIRGAP_DAY.md`. **No private keys belong in this repo or on Hetzner.**

Do **not** run generation until you have a real offline machine and two people.
This doc is preparation + exact commands for ceremony day.

---

## 0. What “done” looks like

| Output | Where it lives | Online? |
| --- | --- | --- |
| `*.pk8`, `avb.pem` | Encrypted USB B only | Never |
| Shamir shares | 3-of-5, separate people/places | Never together online |
| `*.x509.pem`, `avb_pkmd.bin` | USB A → then meta/public inventory | Yes |
| `FINGERPRINTS.sha256` | Published / committed as public text | Yes |

Ceremony is **not** blocked on overlay rebuild. Signing factory images waits for
images; **keygen can happen earlier**.

---

## 1. Shopping / kit list (day −7 … −2)

### Hardware

- [ ] Spare laptop or mini-PC (not your daily driver)  
- [ ] Ability to **physically** disable Wi‑Fi/Ethernet (airplane + unplug; prefer remove NIC/Wi‑Fi if easy)  
- [ ] USB stick **A** — public only (small, new or wiped)  
- [ ] USB stick / SSD **B** — private store (prefer encrypted hardware or LUKS)  
- [ ] Optional: 5× small USBs or printed/QR share carriers for Shamir (see `KEY_RECOVERY.md`)  
- [ ] Known-good Ubuntu 24.04 Desktop ISO on a third stick (installer)  
- [ ] Paper notebook + pens; Faraday / phone basket outside room  

### Label sticks before ceremony

```text
USB-A  PUBLIC-ONLY   AnaOS ceremony YYYY-MM-DD
USB-B  PRIVATE-LUKS  AnaOS keys    YYYY-MM-DD
USB-ISO Ubuntu 24.04 verified
```

### Software to stage **before** going offline

On a **trusted online** machine (not the ceremony laptop yet):

1. Download Ubuntu 24.04 ISO; verify SHA256 from ubuntu.com.  
2. Clone or copy meta repo slice needed offline:

```text
AnaOS/script/make_anaos_keys.sh
AnaOS/script/make_anaos_avb_key.sh
AnaOS/script/make_anaos_app_keys.sh
AnaOS/scripts/record-public-key-fingerprints.sh
AnaOS/docs/KEY_CEREMONY*.md
AnaOS/docs/AIRGAP_*.md
AnaOS/docs/APP_SIGNING.md
AnaOS/docs/KEY_RECOVERY.md
```

3. From a trusted AOSP tree (or the Hetzner tree **copied offline** — only tools, not keys):

```text
development/tools/make_key
external/avb/avbtool.py   # or host avbtool if built
```

4. Copy OpenSSL (distro package is fine once ISO is verified).  
5. Write installer’s SHA256 on paper:

```text
Ubuntu ISO SHA256: _________________________________
Checked by: _____________ Date: _____________
```

---

## 2. Ceremony machine prep (day −1)

### Install

- [ ] Boot from verified USB-ISO  
- [ ] Install Ubuntu 24.04 **minimal**; full-disk encryption optional (extra layer)  
- [ ] Create local user `ceremony` (no cloud login)  
- [ ] **Do not** connect network during/after install if avoidable  
- [ ] If updates needed: update once from trusted mirror, then **disconnect permanently**  

### Offline toolkit layout

```text
/home/ceremony/offline/
  meta/                 # AnaOS scripts + docs (no .pk8 ever)
  aosp-tools/
    make_key
    avbtool.py
  work/                 # empty; keys generated here then wiped
```

```bash
chmod +x offline/meta/script/make_anaos_*.sh
chmod +x offline/meta/scripts/record-public-key-fingerprints.sh
export MAKE_KEY="$HOME/offline/aosp-tools/make_key"
# make_key is often a shell script — ensure executable + openssl present
openssl version
```

### Paper identities

```text
Ceremony ID: AnaOS-KEYS-____________________
UTC date: ____________________
Maintainer 1: ____________________
Maintainer 2 (scribe): ____________________
Room: ____________________
Network check: Wi-Fi off / Ethernet unplugged / RF kill = YES
```

---

## 3. Ceremony day timeline (~2–3 hours)

### T−15 min — room

- [ ] Phones outside  
- [ ] Both maintainers present  
- [ ] USB A + B empty/wiped; labels correct  
- [ ] Print `KEY_CEREMONY_CHECKLIST.md` + this section  

### T0 — isolate

```bash
# Confirm no default route (should fail / empty)
ip route || true
nmcli networking off 2>/dev/null || true
rfkill block all 2>/dev/null || true
```

- [ ] Scribe writes “network isolated” + time  

### T+10 — generate platform keys

```bash
export MAKE_KEY="$HOME/offline/aosp-tools/make_key"
mkdir -p "$HOME/offline/work/anaos-keys"
cd "$HOME/offline/meta"
./script/make_anaos_keys.sh "$HOME/offline/work/anaos-keys"
```

Expect: `platform` `media` `shared` `releasekey` `otakey` each with `.pk8` + `.x509.pem`.

- [ ] List files; scribe ticks each name on checklist  

### T+25 — AVB

```bash
./script/make_anaos_avb_key.sh "$HOME/offline/work/anaos-keys/avb"
# Typical: openssl genrsa → avb.pem; then:
python3 "$HOME/offline/aosp-tools/avbtool.py" extract_public_key \
  --key "$HOME/offline/work/anaos-keys/avb/avb.pem" \
  --output "$HOME/offline/work/anaos-keys/avb/avb_pkmd.bin"
```

- [ ] `avb.pem` exists (private — stays offline)  
- [ ] `avb_pkmd.bin` exists (public — goes to USB A)  

### T+40 — app keys

```bash
./script/make_anaos_app_keys.sh "$HOME/offline/work/anaos-keys/apps"
```

Minimum set (`APP_SIGNING.md`): updater, auditor, camera, appstore, pdfviewer.

- [ ] Each app has `.pk8` + `.x509.pem`  

### T+55 — public export (USB A)

```bash
PUB="$HOME/offline/work/public-export"
rm -rf "$PUB" && mkdir -p "$PUB"
# Copy ONLY public artifacts
find "$HOME/offline/work/anaos-keys" -type f \( -name '*.x509.pem' -o -name 'avb_pkmd.bin' \) \
  -exec cp -a {} "$PUB"/ \;
# Refuse if private leaked into PUB
find "$PUB" -type f \( -name '*.pk8' -o -name 'avb.pem' \) | grep -q . && echo FAIL && exit 1
./scripts/record-public-key-fingerprints.sh "$PUB" "$PUB/FINGERPRINTS.sha256"
# Mount USB A and copy
cp -a "$PUB"/* /media/ceremony/USB-A/
sync
```

- [ ] USB A contains PEMs + `avb_pkmd.bin` + `FINGERPRINTS.sha256`  
- [ ] USB A contains **zero** `.pk8` / `avb.pem`  
- [ ] Paper: paste or write fingerprint file hash  

```text
FINGERPRINTS.sha256 digest: _________________________________
```

### T+75 — private seal (USB B)

Recommended: LUKS partition on USB B.

```bash
# Example shape — adjust device node carefully (DOUBLE-CHECK lsblk)
# cryptsetup luksFormat /dev/sdX1
# cryptsetup open /dev/sdX1 anaos-keys
# mkfs.ext4 /dev/mapper/anaos-keys
# mount /dev/mapper/anaos-keys /mnt/keys
# rsync -a "$HOME/offline/work/anaos-keys/" /mnt/keys/
# umount /mnt/keys && cryptsetup close anaos-keys
```

- [ ] Passphrase in sealed envelope / password manager **offline** policy  
- [ ] Shamir 3-of-5 over recovery secret (`KEY_RECOVERY.md`) — distribute shares now  
- [ ] Wipe `$HOME/offline/work/anaos-keys` (shred/rm); reboot  

### T+100 — close room

- [ ] USB B sealed + location logged (building/safe) — **not** in git  
- [ ] USB A goes with scribe for online publish  
- [ ] Ceremony laptop powered off; store separately  

---

## 4. After ceremony (online machine — public only)

Use **USB A only** on a normal laptop:

```bash
# From meta repo checkout
./scripts/record-public-key-fingerprints.sh /media/$USER/USB-A ./public-keys/FINGERPRINTS.sha256
# Commit ONLY fingerprints + PEMs if you choose to publish PEMs in a public keys repo
# Never commit .pk8
```

- [ ] Publish fingerprints (GitHub release note / `attestation` inventory later)  
- [ ] Internal log: ceremony ID, UTC end, who present — **no secrets**  
- [ ] Update `PLAN.yaml` TASK_019–022 notes when keygen truly finished  
- [ ] First **sign** still waits for unsigned target-files (`FACTORY_IMAGE.md`)  

---

## 5. Abort / fail conditions (stop immediately)

| If this happens | Action |
| --- | --- |
| Ceremony laptop got network mid-generation | Assume leak; destroy key material; reschedule |
| Any `.pk8` copied to USB A or online disk | Destroy that copy; rotate if unsure |
| Only one person present | Do not generate; reschedule four-eyes |
| Using GrapheneOS/AOSP test-keys “for now” | Forbidden for official path |
| Hetzner used for keygen | Forbidden; wipe any such material |

---

## 6. Minimal paper log (copy onto notebook)

```text
Ceremony ID: ____________________  UTC start: __________  UTC end: __________
Present: ____________________ / ____________________
ISO SHA256 verified: Y/N
make_key path: ____________________
Keys: platform media shared releasekey otakey avb apps(updater auditor camera appstore pdfviewer)
USB-A serial: __________  USB-B serial: __________
FINGERPRINTS.sha256: ____________________
Shamir: 3-of-5 distributed to: ____________________
Storage location USB-B (vague): ____________________
 anomalies: ____________________
Sign-off M1: __________  M2: __________
```

---

## 7. Relation to current bring-up

| Item | Status vs ceremony |
| --- | --- |
| Hetzner `BUILD_OK` / overlay | Independent — do not put keys on that host |
| Emulator images | Sign later offline when you choose release |
| Domains / CDN | Needed to *publish* updates, not to *generate* keys |

Next after this runbook: schedule calendar slot + buy/label USBs (section 1).
