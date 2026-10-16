# AnaOS parallel strategy (v2.1)

AnaOS is **not** an Android 17 clone. It tracks AOSP for compatibility, then layers
security/privacy leadership and selective innovation so the platform stays stronger
and more user-respecting than stock Android.

Three tracks run **in parallel**. Track B (security/privacy) never yields to A or C.

```text
        ┌─────────────────────────────────────────┐
        │  TRACK B — Security & privacy primacy   │  ← non-negotiable
        └───────────────┬─────────────────────────┘
                        │ gates merges
        ┌───────────────┴───────────────┐
        │                               │
┌───────▼────────┐              ┌───────▼────────┐
│ TRACK A        │              │ TRACK C        │
│ AOSP 17 speed  │              │ Innovation     │
│ adaptation     │              │ PQC + on-device │
└────────────────┘              │ AI alternatives│
                                └────────────────┘
```

## TRACK A — Fast AOSP 17 adaptation

**Goal:** Absorb Android / AOSP 17 platform changes quickly without freezing AnaOS
hardening or branding.

| Workstream | Outcome |
| --- | --- |
| Branch pin | Manifest pin to AOSP 17 / matching release tags (not only `android-latest-release`) |
| Delta rebase | GrapheneOS-inspired patches rebased onto 17 with conflict inventory |
| Compatibility | CTS/VTS + AnaOS smoke on emulator, then `shiba` |
| Monthly cadence | Security bulletin merge ≤ N days (process in TASK_090 / TASK_091) |

**Rules**

- Upstream merges land on a staging branch first; official builds stay on a signed pin.
- Branding (`Ana` / `AnaOS` / `org.anaos`) and OFFICIAL_BUILD wiring must survive every rebase.
- If an AOSP 17 change weakens isolation, Track B vetoes until mitigated.

## TRACK B — Security & privacy advantage (core value)

**Goal:** Remain strictly ahead of (or equal-best with) hardened Android peers on
memory safety, verified boot, SELinux, network/sensor isolation, and update integrity.

Non-negotiable baseline (also in `PLAN.yaml` `execution_rules`):

- hardened_malloc  
- CFI / SCS / PAC where hardware allows  
- SELinux enforcing  
- Verified boot + rollback protection  
- No production test-keys; offline signing only  

Priority themes (map to TASK_040–055, 045–049, 072–075):

1. Memory safety & exploit mitigation  
2. App / profile / storage isolation  
3. Network & sensor privacy defaults  
4. Update authenticity & attestation  
5. Minimal Google dependency surface (sandboxed Play optional, never required)

**Rules**

- Features that increase attack surface require a written threat-model delta.
- Telemetry/analytics defaults stay off; any optional diagnostics are user-gated and local-first.
- Track C features that need network or privileged APIs must pass Track B review.

## TRACK C — Innovation (PQC + AI alternatives)

**Goal:** Differentiate AnaOS with forward-looking crypto and **on-device, privacy-preserving**
assistive features — not cloud AI product lock-in.

### C1 — Post-quantum cryptography (PQC)

| Area | Direction |
| --- | --- |
| OTA / release signing | Hybrid classical + PQ signatures where tooling allows (migration plan) |
| TLS / network stack | Prefer PQ-ready or hybrid KEMs for system components when libraries mature |
| Key ceremony | Document PQ key types alongside RSA/EC in KEY_* docs |
| Attestation path | Research PQ-friendly attestation metadata without breaking Pixel AVB |

Start with **inventory + hybrid design** (no premature wholesale key rotation).

### C2 — On-device AI alternatives

Privacy-first alternatives to stock Google AI / cloud assistants:

| Capability | AnaOS direction |
| --- | --- |
| On-device inference | Optional, user-installed or clearly toggled; no silent cloud upload |
| Speech / OCR / classify | Prefer open models runnable offline; network requires explicit consent |
| System integration | Separate `org.anaos.*` APIs; no privileged phone-home |
| Scope boundary | **Not** the Qizi “AI Ops” product at qizimarket.com/anaos (see PRODUCT_SCOPE.md) |

Ship order: threat model → sandbox/SELinux domain → offline MVP → optional networked modes.

## Cross-track governance

| Decision | Owner track |
| --- | --- |
| Merge AOSP 17 API that reduces isolation | B veto |
| New app with network + ML | B review, then C |
| Release branch cut | A pin + B checklist + C features flagged experimental until signed |
| Public claims (“more secure than…”) | Only after tests (TASK_076–081) |

## Near-term deliverables (docs / process)

1. This strategy document (`docs/STRATEGY.md`) — **done**  
2. AOSP 17 adaptation playbook stub (`docs/AOSP17_ADAPTATION.md`)  
3. PQC roadmap stub (`docs/PQC_ROADMAP.md`)  
4. On-device AI alternatives stub (`docs/AI_ALTERNATIVES.md`)  
5. PLAN.yaml tasks 94+ for tracks A/B/C  

Execution of foundation TASK_001–033 continues; tracks A/B/C plan work in parallel
without skipping signing / verified-boot gates.
