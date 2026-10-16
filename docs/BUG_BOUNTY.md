# Bug bounty program (TASK_082)

Launch only after a public release channel and triage capacity exist.

## Launch gates

- [ ] Domains + `security@` (or GitHub Security Advisories) live  
- [ ] Scope document published (in / out of scope)  
- [ ] Severity rubric linked (`SEVERITY.md`)  
- [ ] Safe harbor statement  
- [ ] At least one person on triage rota  

## In-scope (intended)

- Remote code execution in AnaOS components  
- Verified boot / OTA signature bypass  
- SELinux / sandbox escapes on official builds  
- Updater host pinning bypass  
- Cryptographic failures in release metadata verify  

## Out-of-scope (intended)

- Issues only on unlocked / test-keys builds  
- Stock AOSP bugs with no AnaOS delta (report upstream)  
- Social engineering / physical theft without crypto break  
- qizimarket AI Ops (separate product)  

## Process

1. Report via SECURITY.md channel.  
2. Triage with `SEVERITY.md`.  
3. Fix → embargo → advisory → credit.  
4. Payout table TBD at launch (honest: not funded until then).  

Do not promise bounties before launch gates clear.
