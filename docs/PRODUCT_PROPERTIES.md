# AnaOS product properties

`ro.anaos.*` and related props set from `device/anaos/common/*.mk`.

## Always (common)

| Property | Source | Meaning |
| --- | --- | --- |
| `ro.product.brand` | `PRODUCT_BRAND := Ana` | Brand |
| `ro.product.manufacturer` | `PRODUCT_MANUFACTURER := AnaOS` | Manufacturer |
| `ro.anaos.version` | `anaos.mk` | Dev/release version string |
| `ro.anaos.brand` | `anaos.mk` | `Ana` |

## Official builds (`ANAOS_OFFICIAL_BUILD=true`)

| Property | Value |
| --- | --- |
| `ro.anaos.official` | `1` |
| `ro.anaos.updater.uri` | `https://releases.anaos.org/` |
| `ro.anaos.attestation.uri` | `https://attestation.anaos.org/` |
| `ro.anaos.apps.uri` | `https://apps.anaos.org/` |

## Engineering builds

| Property | Value |
| --- | --- |
| `ro.anaos.official` | `0` |

Must not advertise release-keys update channels as production.

## Fingerprint

Template in `BRANDING.md`. Release scripts set `BUILD_ID` / `BUILD_NUMBER`
(`release-env.sh`).

## Ban

- `ro.grapheneos.*` in AnaOS products  
- Pointing updater URI at non-AnaOS hosts on official builds  
