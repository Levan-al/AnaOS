# Phase C execution tracker

Started: **2026-10-19** (after Hetzner teardown).

## Progress

| Item | Status | Evidence |
| --- | --- | --- |
| Air-gap prep (no private keys) | in_progress | `scripts/pack-airgap-kit.sh`, kit checklist below |
| Track B gate automation | in_progress | `scripts/check-security-gate.sh` + PR template |
| AOSP17 pin decision | ready | P0 = `android-17.0.0_r1` — needs new host to sync |
| adevtool / shiba | scaffold | `adevtool/CHECKLIST.md` expanded |
| Domains | template ready | `dns/anaos.org.zone.example` — buy later |
| Updater client | scaffold+ | metadata parser + host allowlist (offline) |
| Browser/WebView | deferred | P3 |

## Air-gap readiness (human)

Ceremony **commands** are in `AIRGAP_PRACTICAL.md`. Meta can only prepare:

- [x] Scripts present under `script/` + fingerprint helper  
- [x] Pack script for USB-A public kit  
- [ ] Offline machine + two people scheduled  
- [ ] Ubuntu ISO hash written on paper  
- [ ] `make_key` / `avbtool` copied from trusted AOSP tree  

**Do not** run `make_anaos_keys.sh` on a networked laptop.

## AOSP17 next host

When renting again:

```bash
# Separate disk / VM — never beside Chromium
repo init -u https://android.googlesource.com/platform/manifest -b android-17.0.0_r1
# then overlay AnaOS meta; Track B gate before any release claim
```

Record SHA in `AOSP17_REBASE_LEDGER.md` after first sync.
