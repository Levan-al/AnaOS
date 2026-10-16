# hardened_malloc integration (TASK_040)

Track B memory-safety baseline. Do not weaken for build speed.

## Sources

| Repo | Role |
| --- | --- |
| https://github.com/Levan-al/hardened_malloc | AnaOS tracking / fork target |
| GrapheneOS `hardened_malloc` | Upstream reference |

## Integration checklist

- [ ] Pin commit in `platform_manifest` / local manifest  
- [ ] Build as bionic allocator replacement (or LD_PRELOAD path for eng only — **not** for user)  
- [ ] Enable for `user` / `userdebug` AnaOS products  
- [ ] CTS / AnaOS smoke: no permissive fallback  
- [ ] Document knobs in `device/anaos/common/`  

## Product wiring (sketch)

```make
# device/anaos/common/anaos.mk (later)
PRODUCT_PACKAGES += hardened_malloc
# Exact Soong/Make name depends on chosen integration style.
```

## Ban

- Shipping with stock allocator “temporarily” on official builds  
- Disabling on Hetzner rental for faster `m` without a tracked exception  
