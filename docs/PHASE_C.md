# Phase C execution tracker

Started: **2026-10-19** (after Hetzner teardown).  
**Superseded for active work by [`PHASE_D.md`](PHASE_D.md)** — keep as historical prep log.

## Progress

| Item | Status | Evidence |
| --- | --- | --- |
| Air-gap prep (no private keys) | ready | `scripts/pack-airgap-kit.sh` — ceremony still human |
| Track B gate automation | ready | `scripts/check-security-gate.sh` + PR template |
| AOSP17 pin decision | ready | P0 = `android-17.0.0_r1` — needs new host to sync |
| adevtool / shiba | Phase D CLI | `adevtool/adevtool.py` + sepolicy stubs |
| Domains | template ready | `dns/anaos.org.zone.example` — buy later |
| Updater client | Phase D+ | fixtures + validator + HTTPS fetcher (offline default) |
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
