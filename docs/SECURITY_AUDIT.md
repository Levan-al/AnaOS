# External security audit process (TASK_081)

How AnaOS engages third-party review. Complements bug bounty (`BUG_BOUNTY.md`).

## When to audit

| Milestone | Focus |
| --- | --- |
| First signed factory + lockable VB | AVB, signing, OTA path |
| First public device release | SELinux, Updater, installers |
| Major AOSP version rebase | Diff review + regression |
| Pre–bug-bounty | Scope validation |

## Scope template

1. **In:** verified boot, offline signing flow, update client/server trust,
   SELinux policy for `org.anaos.*`, hardened_malloc/CFI enablement evidence.  
2. **Out:** proprietary vendor blobs (license/NDA limits), third-party Play apps,
   AI Ops product.  
3. **Build:** auditor receives reproducible unsigned + signed artifact hashes,
   not private keys.  

## Engagement steps

1. NDA + safe harbor.  
2. Kickoff: threat model (`THREAT_MODEL_ANDROID17.md`) + architecture.  
3. Access: source tags, public fingerprints, test device if needed.  
4. Findings → severity map → fix SLA.  
5. Public summary (optional) after embargo.  

## Internal prep checklist

- [ ] Track B gate green on release candidate  
- [ ] Fingerprints published  
- [ ] Known gaps listed honestly (no marketing fluff)  
- [ ] Contact + escrow for critical vulns  

Related: `SECURITY.md`, `SEVERITY.md`, `TESTING.md`.
