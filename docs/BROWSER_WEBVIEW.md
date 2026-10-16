# Browser + WebView (TASK_057)

Vanadium-class hardened Chromium for AnaOS (`org.anaos.browser` + system WebView).

## Constraints

- Full Chromium **must not** build on the same 32GB host beside AOSP (`COST_OPS.md`)  
- Dedicated larger host or overnight window after TASK_018  
- Rebrand per `ORG_ANAOS_REBRAND.md`  

## Components

| Piece | Role |
| --- | --- |
| Browser APK | User-facing `org.anaos.browser` |
| WebView provider | System WebView for other apps |
| Patch set | GrapheneOS/Vanadium tracking forks under `Levan-al` |

## Phases

1. README + package ID reserved (`apps/Browser`)  
2. Manifest pin of vanadium external tree  
3. Dedicated build → prebuilt drop into platform  
4. SELinux / network defaults (DoH adjacency with TASK_053)  
5. Track B review of JIT / dynamic code exceptions (`MEMORY_SAFETY.md`)  

## Ban

- Shipping stock Chrome/WebView as “AnaOS Browser”  
- Phone-home metrics by default  
- Building Chromium on CPX62 in parallel with `m`  
