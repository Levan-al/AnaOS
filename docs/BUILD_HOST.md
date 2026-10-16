# AnaOS build host notes

## Current host: homeserver (Qizi-server)

SSH: `ssh Qizi-server` → `levani@100.100.180.34` (Tailscale)

| Resource | Available | Required (plan) |
| --- | --- | --- |
| CPU | 8 cores | ≥16 |
| RAM | ~8 GB | ≥64 GB |
| Disk `/` | ~72 GB free | ≥1 TB |
| Disk `/mnt/wealth-ssd` | ~104 GB free | (extra) |
| OS | Ubuntu 24.04 LTS | OK |

**Verdict:** tooling only. Full AOSP/`repo sync` + user build is **not feasible** on this machine (will OOM / fill disk).

Prepared on host:

- `~/bin/repo`
- `~/anaos/HOST_STATUS.md`
- `/mnt/wealth-ssd/anaos/` (empty workspace mount)

## Still needed on host

1. Passwordless or interactive `sudo` to install AOSP packages (`scripts/server-bootstrap.sh`)
2. A machine meeting RAM/disk targets, **or** more RAM + ≥1 TB attached storage on this host
3. Chosen Android / GrapheneOS release branch pin (e.g. `16`, `202410xxx`)

## What was done without full sync (TASK_011 / TASK_012)

GitHub forks under `Levan-al` from GrapheneOS (see `docs/REPOSITORIES.md` / `gh repo list Levan-al`).
