# Offline AI MVP scaffold (TASK_102 / TRACK C2)

Package intent: `org.anaos.ai.ocr` / `org.anaos.ai.stt` (names TBD).

This directory is a **planning + consent UX stub** only. No model weights and
no network inference in the scaffold.

## MVP order

1. On-device OCR (gallery / PDF adjacency)  
2. Offline STT toggle for accessibility  
3. Explicit, revocable consent screens before first use  

## Rules

- Default offline; no cloud endpoints in manifests.  
- Separate from qizimarket AI Ops (`docs/AI_ALTERNATIVES.md`).  
- SELinux app domains per `docs/SELINUX_APP_DOMAINS.md` / `docs/AI_THREAT_MODEL.md`.  
- Track B gate before any system-server hooks.

## Next implementation steps

- [ ] Minimal Android app module with consent Activity  
- [ ] Model packaging story (size, license, update channel)  
- [ ] Wire OCR behind feature flag in PdfViewer / Gallery adjacency  

Do not ship debug APKs that phone home.
