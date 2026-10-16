# Local manifest fragment

File: `platform_manifest/local_manifests/anaos.xml`

## Purpose

After base AOSP `repo sync`, optionally pull AnaOS GitHub projects into the
tree. For bring-up, **prefer** `scripts/overlay-anaos-into-aosp.sh` for
`device/anaos` + `branding` from the meta repo.

## Install

```bash
mkdir -p /opt/anaos/aosp/.repo/local_manifests
cp platform_manifest/local_manifests/anaos.xml \
  /opt/anaos/aosp/.repo/local_manifests/
cd /opt/anaos/aosp && repo sync -c -j4 --no-tags
```

## Projects listed today

- `branding`  
- `packages/apps/AnaOS{Updater,Auditor,Camera,PdfViewer,AppStore,SetupWizard}`  

Device trees remain overlay-from-meta until split to dedicated repos.

## Notes

- Remote `anaos` → `https://github.com/Levan-al/`  
- Empty / stub app repos may fail sync — overlay scaffolds from meta instead  
- Do not add private key paths to any manifest  
