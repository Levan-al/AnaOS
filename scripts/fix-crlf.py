#!/usr/bin/env python3
from pathlib import Path
p = Path("/opt/anaos")
for f in p.glob("*.sh"):
    data = f.read_bytes().replace(b"\r\n", b"\n").replace(b"\r", b"\n")
    f.write_bytes(data)
    print("fixed", f)
