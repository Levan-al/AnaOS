# adevtool implementation checklist (TASK_027 / TASK_029)

Phase D scaffold landed; full extract still needs factory image. First SKU: **Pixel 8 (`shiba`)**.

## Tooling

- [x] Decide: greenfield Python CLI in meta + keep GrapheneOS fork as reference  
- [x] Package under `adevtool/adevtool.py` (meta) — mirror to GitHub `Levan-al/adevtool` later  
- [x] Unit tests for fetch allowlist / verify-hashes / extract missing-image  
- [x] CLI subcommands: `list-devices`, `fetch` (dry-run), `extract` (plan), `verify-hashes`  
- [ ] `generate-device` + real blob unpack (needs factory zip)

## First SKU: Pixel 8 (`shiba`)

- [ ] Pin factory image URL + SHA256 in private ops note (redistribution-limited — not always public)  
- [ ] Download + extract proprietary blobs on a **dedicated** workstation (not daily driver)  
- [ ] Generate `device/anaos/shiba/` fragments from current stubs  
- [ ] Write vendor hash inventory (`docs/VENDOR_EXTRACT.md` format)  
- [ ] Smoke `lunch` after overlay into AOSP **17.0.0_r1** tree  
- [ ] Track B gate ACK before claiming device support  

## Rebrand

- [ ] Paths and comments use AnaOS / `org.anaos`  
- [ ] No GrapheneOS update endpoints left in generated trees  

## Exit criteria for TASK_029

Automated extract produces a hash-verified vendor tree consumable by
`device/anaos/shiba` without manual copy-paste of blobs.

## Explicit non-goals yet

- Multiple Pixel SKUs before `shiba` boots signed  
- Running extract on a rented cloud VM that also holds release keys  
