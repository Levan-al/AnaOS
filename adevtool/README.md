# adevtool (TASK_027)

AnaOS vendor extraction / device-tree generation tool.

## Status (Phase D)

Runnable **meta scaffold** (no proprietary blobs in git):

```bash
python3 adevtool/adevtool.py list-devices
python3 adevtool/adevtool.py fetch 'https://dl.google.com/dl/android/aosp/example.zip'
python3 adevtool/adevtool.py verify-hashes adevtool/example-hash-manifest.json
python3 adevtool/adevtool.py extract --device shiba --factory-image /path/to/factory.zip
python3 -m unittest discover -s adevtool -p 'test_*.py' -v
```

- GitHub: https://github.com/Levan-al/adevtool (stub)  
- Upstream reference fork: https://github.com/Levan-al/grapheneos_adevtool  
- Device stubs: `device/anaos/shiba/`  
- Living checklist: [`CHECKLIST.md`](CHECKLIST.md)  
- Extract policy: [`docs/VENDOR_EXTRACT.md`](../docs/VENDOR_EXTRACT.md)  

Implement full extract against AOSP pin `android-17.0.0_r1`.
Do not claim Pixel support until Track B gate + signed image path exist.
