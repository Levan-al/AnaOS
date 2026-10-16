# Security Policy

## Reporting a vulnerability

Do **not** open a public issue for security vulnerabilities.

Email: `security@anaos.org` (activate after domain registration — TASK_002 / TASK_008)

Until the public PGP key and private tracker are published (TASK_008):

1. Email a clear description, affected component, and impact
2. Include reproduction steps if safe to share
3. Allow reasonable time for triage before public disclosure

## Supported versions

Only official AnaOS builds signed with AnaOS release keys and reporting verified boot state `green` are in scope once releases begin.

## Severity

| Level | Meaning | Examples |
| --- | --- | --- |
| Critical | Immediate device/user compromise at scale | Remote code execution, verified boot bypass, signing-key compromise |
| High | Strong local compromise | Privilege escalation, sandbox escape, persistent malware without reboot |
| Medium | Meaningful privacy/integrity impact with constraints | Network deanonymization defaults broken, scoped-storage bypass |
| Low | Limited / defense-in-depth | Hardening gaps without practical exploit path |

Private tracker: GitHub Security Advisories on `Levan-al/AnaOS` (enable when ready) or email above.  
Bug bounty program: TASK_082 (not launched yet).
