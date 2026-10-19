# Kernel prebuilt CI stub (TASK_039)

Future job (self-hosted runner only — GHA free minutes cannot build Pixel kernels):

1. `repo init` with `kernel/manifests/kernel_manifest-shiba.xml`  
2. Build Image / dtbo / vendor_boot / modules  
3. Publish hashes to `device/anaos/shiba/prebuilts/` (separate binary repo)  
4. Track B gate before promoting into platform tree  

Until a capable host exists, keep this directory as documentation only.
