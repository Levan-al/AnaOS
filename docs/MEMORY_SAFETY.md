# Memory safety extras (TASK_043–044)

Companion to `HARDENED_MALLOC.md` and `CFI_AND_SCS.md`.

## TASK_043 — integer overflow / bounds

- Keep AOSP UBSAN/integer sanitizers where GrapheneOS enables them  
- Do not strip checks to fix Hetzner build time  
- Prefer ARM64 device validation over emulator-only  
- Record known flaky targets instead of global disable  

## TASK_044 — dynamic code / exec-spawn

- Restrict `execve` / JIT / dynamic code load for untrusted apps  
- SELinux + seccomp synergy (TASK_045)  
- Browser/WebView exceptions documented and minimal  
- No arbitrary `dlopen` of world-writable paths  

## Layering

```text
hardened_malloc → CFI/SCS → overflow checks → exec-spawn policy → SELinux
```

## Ban

Disabling sanitizers or exec-spawn restrictions on `user` builds without Track B ACK.

## Test hooks

Add cases to TASK_077 regression when wired: allocator present, sample
overflow abort in eng, untrusted app cannot `exec` shell helpers.
