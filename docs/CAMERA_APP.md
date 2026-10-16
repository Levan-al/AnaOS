# Camera app (TASK_056)

Privacy-oriented camera: `org.anaos.camera` (GrapheneOS Camera lineage later).

## Goals

- Local capture only by default  
- No cloud upload / Google Photos hooks  
- EXIF location off unless user enables  
- Share path respects metadata strip (TASK_054)  

## Permissions

| Permission | Policy |
| --- | --- |
| Camera | Foreground only |
| Mic | Only when video/audio recording |
| Location | Off by default for geotag |
| Network | None by default |

## Signing / SELinux

- Dedicated app key (`APP_SIGNING.md`)  
- Domain `anaos_camera` (`SELINUX_APP_DOMAINS.md`)  

## Status

Scaffold at `apps/Camera/`. Full feature port after platform overlay.
