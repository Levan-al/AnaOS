## Summary

<!-- What and why -->

## Track

- [ ] A — AOSP 17 adaptation
- [ ] B — Security / privacy
- [ ] C — PQC / on-device AI
- [ ] Foundation / docs / infra

## Track B gate (required if A or C)

See `docs/SECURITY_MERGE_GATE.md`. Paste checklist results or link.

- [ ] B gate N/A (docs-only / no platform impact)
- [ ] B gate completed — threat-model delta + reviewer ACK
- [ ] No new privileged network endpoints without consent
- [ ] SELinux / AVB / hmalloc not weakened “to fix the build”
- [ ] No `.pk8` / private keys in the diff

## Test plan

- [ ] `bash scripts/check-security-gate.sh`
- [ ] Other:
