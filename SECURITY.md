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

## Severity (draft)

| Level | Meaning |
| --- | --- |
| Critical | Remote code execution, verified boot bypass, key compromise |
| High | Local privilege escalation, sandbox escape, persistent compromise |
| Medium | Significant privacy or integrity impact with constraints |
| Low | Limited impact, defense-in-depth issues |

Exact rewards and scope for a bug bounty are defined in TASK_082.
