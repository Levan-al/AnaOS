# branding

AnaOS product branding: names, overlays, boot animation, logos, and makefile injection.

Source of truth for identity values: [`config.yaml`](config.yaml) and [`../docs/BRANDING.md`](../docs/BRANDING.md).

## Layout

```text
branding/
  config.yaml          # machine-readable identity
  config.mk            # makefile injection
  bootanimation/       # boot animation assets
  logos/               # marks and icons
  overlays/            # RROs / framework overlays
  strings/             # branded string packs
  wallpapers/          # default wallpapers
```

Directories above are populated as TASK_014 proceeds.
