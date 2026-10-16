# One-day rented build host (practical path)

Homeserver is too small. Rent a machine for a short burst, sync + first build, then destroy.

## Target spec (minimum for first AnaOS user/emulator build)

| Resource | Minimum | Better |
| --- | --- | --- |
| CPU | 16 vCPU / cores | 32 |
| RAM | 64 GB | 128 GB |
| NVMe | 1 TB free | 1.5–2 TB |
| OS | Ubuntu 24.04 LTS | same |
| Network | fast egress (sync pulls 100GB+) | — |

## Recommended provider (price / simplicity)

### 1) Hetzner (best default for EU)

- **Cloud CCX / dedicated AX/EX** with ≥64 GB RAM and large NVMe  
- Hourly billing on many products → order → work → **delete same day**
- Example ballpark (check live prices): roughly **€5–€25 for ~24 hours** depending on SKU  
  (dedicated ~€0.10–€0.20/h + disk; always verify on hetzner.com)

Order Ubuntu 24.04, add your SSH public key (`id_ed25519_qizi.pub` or a new build key).

### 2) Alternatives

| Provider | Notes |
| --- | --- |
| OVH / Scaleway | Similar EU dedicated/cloud |
| AWS / GCP spot | Possible but usually **more expensive** and more setup |
| Contabo | Cheap monthly; worse for true 1-day teardown |

Avoid tiny “VPS 8 GB” offers — they will fail the same way as homeserver.

## Realistic time for day-1

| Step | Typical duration |
| --- | --- |
| Order + SSH | 15–60 min |
| Packages + `repo` | 15–30 min |
| First `repo sync` (full tree) | **3–12 hours** |
| First `m` user build (emulator or device) | **2–8 hours** |
| **Total** | Often **one long day**, sometimes overnight |

So “one calendar day” works if you start early and pick a strong machine. First time rarely finishes in 2–3 hours.

## What you do / what the agent does

**You:**

1. Create Hetzner account + add payment  
2. Order server (Ubuntu 24.04, ≥64 GB RAM, ≥1 TB NVMe)  
3. Put SSH key, send me: `ssh user@IP` (or add Host to `~/.ssh/config`)  
4. After work: **destroy** the server so billing stops  

**Agent (me):**

1. Run `scripts/server-bootstrap.sh`  
2. `repo init` / `repo sync` from AnaOS manifest + AOSP pin  
3. Attempt first emulator or device build  
4. Capture logs/artifacts; tear-down checklist  

## Cost control checklist

- [ ] Hourly billing confirmed  
- [ ] Snapshot only if you need to pause (snapshots also cost)  
- [ ] Delete instance when done  
- [ ] Do **not** leave idle overnight unless build is still running  
- [ ] Keep signing keys **off** the rented host (TASK_007 — offline keys)

## After the rental

Homeserver stays for docs/CI light work. Heavy builds = rent again when needed (monthly security patch day, etc.).
