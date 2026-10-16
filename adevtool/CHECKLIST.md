# adevtool implementation checklist (TASK_027 / TASK_029)

## Tooling

- [ ] Decide: extend `grapheneos_adevtool` fork vs greenfield CLI  
- [ ] Package as reproducible Go/Python tool under `adevtool/`  
- [ ] CI lint + unit tests for path rewrite / hash inventory  

## First SKU: Pixel 8 (`shiba`)

- [ ] Pin factory image URL + SHA256 in docs (not in public if redistribution-limited)  
- [ ] Download + extract proprietary blobs  
- [ ] Generate `device/anaos/shiba/` fragments from stubs  
- [ ] Write vendor hash inventory (`docs/VENDOR_EXTRACT.md` format)  
- [ ] Smoke `lunch` target after overlay into AOSP tree  

## Rebrand

- [ ] Paths and comments use AnaOS / `org.anaos`  
- [ ] No GrapheneOS update endpoints left in generated trees  

## Exit criteria for TASK_029

Automated extract produces a hash-verified vendor tree consumable by
`device/anaos/shiba` without manual copy-paste of blobs.
