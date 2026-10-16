# PDF Viewer (TASK_058)

Sandboxed PDF viewing: `org.anaos.pdfviewer` (pdf.js or similar lineage later).

## Goals

- Open PDFs via content URI / SAF — no broad storage by default  
- No network unless user opens an explicit https link (prefer deny)  
- Optional OCR later via Offline AI consent (`OfflineAi`, TASK_102) — off by default  

## Threat notes

| Risk | Mitigation |
| --- | --- |
| Malicious PDF / JS | Prefer hardened renderer; disable unnecessary JS |
| Data exfil | No default network; SELinux `anaos_pdfviewer` |
| Temp file leaks | Scoped cache; clear on exit when feasible |

## Status

Scaffold at `apps/PdfViewer/`. Renderer choice TBD after Track B review.
