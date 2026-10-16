# init for shiba (TASK_030)

Device init `.rc` fragments and fstab hooks for AnaOS on Pixel 8.

Populate from adevtool / Google device tree after TASK_029. Keep AnaOS-specific
properties (updater URI, official flag) in product makefiles, not vendor init,
unless a hardware constraint requires it.
