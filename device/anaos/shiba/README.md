# device/anaos/shiba

First official hardware target: **Google Pixel 8** (`shiba` → product `ana_shiba`).

| File | Role |
| --- | --- |
| `ana_shiba.mk` | Product stub + AnaOS common inherit |
| `BoardConfig.mk` | Board / AVB stubs |
| `AndroidProducts.mk` | Lunch choices |

Vendor blobs and complete inheritance require TASK_027 / TASK_029 (`adevtool`). See `docs/DEVICES.md`.
