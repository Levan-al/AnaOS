# AnaOS build host notes

## Active build host: Hetzner `anaos-build` (rented)

SSH: `ssh anaos-build` → `root@188.34.189.66` (key `id_ed25519_qizi`)

| Resource | Available | Required (plan) |
| --- | --- | --- |
| Type | CPX62 (shared) | dedicated preferred |
| CPU | 16 vCPU | ≥16 |
| RAM | 32 GB | ≥64 GB (ideal) |
| Disk | ~575 GB free | ≥1 TB ideal |
| OS | Ubuntu 24.04 LTS | OK |
| Credit | $25 prepaid verification credit | monitor burn rate |

**Notes:**

- New Hetzner accounts block larger **dedicated** types (`ccx43`+ = resource_limit). Request limit increase in Console → Limits for 64GB+ dedicated.
- Bootstrap installed (`repo`, build packages, ccache). API token name: `AnaOS-build` (revoke after rental ends).
- **Delete the server when done** so hourly billing stops.

## Secondary: homeserver (Qizi-server)

SSH: `ssh Qizi-server` → too small for full AOSP (8 GB RAM). Keep for light tooling only.

## Still needed on host

1. Passwordless or interactive `sudo` to install AOSP packages (`scripts/server-bootstrap.sh`)
2. A machine meeting RAM/disk targets, **or** more RAM + ≥1 TB attached storage on this host
3. Chosen Android / GrapheneOS release branch pin (e.g. `16`, `202410xxx`)

## What was done without full sync (TASK_011 / TASK_012)

GitHub forks under `Levan-al` from GrapheneOS (see `docs/REPOSITORIES.md` / `gh repo list Levan-al`).
