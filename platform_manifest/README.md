# platform_manifest

`repo` manifest for AnaOS.

## Usage (when a full AOSP pin exists)

```bash
repo init -u https://github.com/Levan-al/platform_manifest.git -b main
repo sync -j4
```

## Current status

Bootstrap `default.xml` lists AnaOS-owned remotes and projects. Full AOSP include + GrapheneOS-derived forks arrive in TASK_011 / TASK_012.
