"""Reproducible conservative source/history inventory (no credentials)."""
from pathlib import Path
import json
import re
import subprocess
root = Path(__file__).resolve().parents[1]
rows = []
for path in sorted(root.glob('*.mbt')):
    if path.name.endswith(('_test.mbt', '_wbtest.mbt')):
        continue
    lines = path.read_text(encoding='utf-8').splitlines()
    substantive = sum(bool(re.search('[A-Za-z0-9_]', line)) for line in lines if line.strip() and not line.strip().startswith('//'))
    rows.append({'path':path.name, 'physical':len(lines), 'substantive_nonblank':substantive})
count = int(subprocess.check_output(['git','rev-list','--count','HEAD'],cwd=root,text=True))
result = {'core_files':rows, 'production_physical':sum(r['physical'] for r in rows), 'substantive_nonblank':sum(r['substantive_nonblank'] for r in rows), 'commits':count, 'excluded':'tests, generated interfaces, examples, Python verification, docs and configuration'}
print(json.dumps(result,indent=2))
assert result['production_physical'] >= 1500
assert result['substantive_nonblank'] >= 1400
