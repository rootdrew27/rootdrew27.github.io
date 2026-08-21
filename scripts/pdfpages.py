#!/usr/bin/env python3
"""Print a PDF's page count. Handles the compressed object streams Tectonic emits,
which a plain regex over the raw bytes misses."""
import re
import sys
import zlib

data = open(sys.argv[1], "rb").read()

# Uncompressed objects, plus the contents of every object stream we can inflate.
blobs = [data]
for m in re.finditer(rb"stream\r?\n", data):
    start = m.end()
    end = data.find(b"endstream", start)
    if end == -1:
        continue
    try:
        blobs.append(zlib.decompress(data[start:end]))
    except zlib.error:
        pass

haystack = b"".join(blobs)
# /Type /Pages carries /Count N, the authoritative total; fall back to counting leaves.
counts = [int(n) for n in re.findall(rb"/Count\s+(\d+)", haystack)]
pages = max(counts) if counts else len(re.findall(rb"/Type\s*/Page[^s]", haystack))
print(pages if pages else "?")
