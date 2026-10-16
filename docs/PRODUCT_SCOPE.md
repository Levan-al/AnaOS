# Product scope

## This repository (Android AnaOS)

Hardened Android OS: AOSP-based, GrapheneOS-inspired security, package prefix
`org.anaos`, brand Ana / AnaOS.

**Not a stock Android clone.** AnaOS runs three parallel tracks
(`docs/STRATEGY.md`):

| Track | Focus |
| --- | --- |
| **A** | Fast, controlled AOSP 17 adaptation |
| **B** | Security & privacy primacy (core value; gates merges) |
| **C** | Innovation — PQC and on-device AI alternatives |

Tracked by `docs/PLAN.yaml` (v2.1+).

## Not this repository

**Ana OS — AI Operations Layer** at [https://qizimarket.com/anaos/](https://qizimarket.com/anaos/)
is a separate Qizi Venture Studio product (FastAPI / QERP / homeserver). It is
**out of scope** for this Android project.

Track C “AI alternatives” means **on-device, privacy-preserving** OS features only —
not that AI Ops stack.

Do not merge branding, domains, signing keys, or release pipelines of the two
products without an explicit decision.
