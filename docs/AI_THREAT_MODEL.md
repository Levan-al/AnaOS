# On-device AI alternatives — threat model draft (TRACK C / TASK_101)

Companion to `AI_ALTERNATIVES.md`. Track B must ACK before any privileged integration.

## Assets

| Asset | Sensitivity |
| --- | --- |
| Mic / camera buffers | High |
| Notifications / SMS / contacts | High |
| Photos / PDFs for OCR | Medium–High |
| Model weights + update channel | Medium (integrity) |
| User prompts / transcripts | High |

## Adversaries

1. Malicious or compromised model update package  
2. App abusing an AnaOS AI binder API  
3. Network observer if optional online mode is enabled  
4. Local malware with accessibility / overlay privileges  

## Controls (required)

| Control | Requirement |
| --- | --- |
| Default mode | Offline; no network sockets in base service |
| Consent | Per-capability, revocable, shown before first use |
| SELinux | Dedicated domain; no untrusted_app → raw mic without consent path |
| Updates | Signed like other AnaOS components; hash-pinned models |
| Scope split | No shared keys/endpoints with qizimarket AI Ops |

## Non-goals

- Cloud training on AnaOS user data by default  
- Silent assistant always listening  

## Open questions

- Which first MVP (OCR vs STT)? → prefer OCR (no always-mic).  
- Model license compatibility with Apache-2.0 / user redistribution.  
