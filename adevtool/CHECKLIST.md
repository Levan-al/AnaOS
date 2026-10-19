# adevtool implementation checklist (TASK_027 / TASK_029)

Phase C — after emulator bring-up. First SKU: **Pixel 8 (`shiba`)**.

## Tooling

- [ ] Decide: extend `grapheneos_adevtool` fork vs greenfield CLI  
- [ ] Package as reproducible Go/Python tool under `adevtool/` (this repo) + GitHub `Levan-al/adevtool`  
- [ ] CI lint + unit tests for path rewrite / hash inventory  
- [ ] CLI subcommands (target shape): `fetch`, `extract`, `generate-device`, `verify-hashes`  

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
