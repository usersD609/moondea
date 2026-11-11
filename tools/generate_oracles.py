"""Independent synthetic DEA fixtures from SciPy/HiGHS, seed 6092026.
No production MoonBit coefficients or solver code are imported.
Run from repository root with Python 3.9+ and scipy==1.14.1.
"""
import json
import random
from pathlib import Path
import numpy as np
from scipy.optimize import linprog


def optimize(x, y, x0, y0, scale, mode):
    n, m, s = len(x), len(x0), len(y0)
    extra = mode in ("input", "output", "directional")
    cols = n + int(extra)
    a, b, c = [], [], [0.0] * cols
    for j in range(m):
        row = [x[i][j] for i in range(n)]
        if extra:
            row.append(-x0[j] if mode == "input" else x0[j] if mode == "directional" else 0.0)
        a.append(row)
        b.append(0.0 if mode == "input" else x0[j])
    for j in range(s):
        row = [-y[i][j] for i in range(n)]
        if extra:
            row.append(y0[j] if mode in ("output", "directional") else 0.0)
        a.append(row)
        b.append(0.0 if mode == "output" else -y0[j])
    if scale in ("VRS", "NIRS"):
        a.append([1.0] * n + ([0.0] if extra else []))
        b.append(1.0)
    if scale in ("VRS", "NDRS"):
        a.append([-1.0] * n + ([0.0] if extra else []))
        b.append(-1.0)
    if extra:
        c[-1] = 1.0 if mode == "input" else -1.0  # scipy minimizes
    else:
        c = [sum(x[i][j] / x0[j] for j in range(m)) - sum(y[i][j] / y0[j] for j in range(s)) for i in range(n)]
    r = linprog(c, A_ub=np.array(a), b_ub=np.array(b), bounds=(0.0, None), method="highs",
                options={"primal_feasibility_tolerance": 1e-9, "dual_feasibility_tolerance": 1e-9})
    if not r.success:
        raise RuntimeError((scale, mode, r.message))
    return float(r.x[-1]) if extra else float(-r.fun + m - s)


def mbt(value):
    return json.dumps(value, ensure_ascii=False, separators=(",", ":"))


def main():
    rng = random.Random(6092026)
    blocks = ["// Independently generated synthetic oracle fixtures. Regenerate with tools/generate_oracles.py."]
    cases = []
    for case in range(32):
        n, m, s = 5 + case % 4, 1 + case % 3, 1 + (case // 3) % 3
        x = [[float(rng.randint(1, 16)) for _ in range(m)] for _ in range(n)]
        y = [[float(rng.randint(1, 16)) for _ in range(s)] for _ in range(n)]
        unit = case % n
        lines = ["///|", 'test "independent HiGHS fixture %02d" {' % case,
                 '  let d=Dataset::new(%s,%s,%s).unwrap()' % (mbt(["u%d" % i for i in range(n)]), mbt(x), mbt(y))]
        expected = []
        for scale in ("CRS", "VRS", "NIRS", "NDRS"):
            for mode in ("input", "output", "additive", "directional"):
                v = optimize(x, y, x[unit], y[unit], scale, mode)
                expected.append({"returns": scale, "model": mode, "value": v})
                if mode == "input": expr = 'input_radial(d,%d,d,%s).unwrap().factor' % (unit, scale)
                elif mode == "output": expr = 'output_radial(d,%d,d,%s).unwrap().factor' % (unit, scale)
                elif mode == "additive": expr = 'additive(d,%d,d,%s).unwrap().normalized_gain' % (unit, scale)
                else: expr = 'directional(d,%d,d,%s,%s,%s).unwrap().distance' % (unit, scale, mbt([1.0]*m), mbt([1.0]*s))
                lines.append('  near(%s, %s)' % (expr, repr(v)))
        lines.append('}')
        blocks.append('\n'.join(lines))
        cases.append({"case": case, "unit": unit, "inputs": x, "outputs": y, "expectations": expected})
    root = Path(__file__).resolve().parents[1]
    (root / 'oracle_wbtest.mbt').write_text('\n\n'.join(blocks)+'\n', encoding='utf-8')
    (root / 'tools' / 'oracle-fixtures.json').write_text(json.dumps({"seed":6092026,"cases":cases}, indent=2)+'\n', encoding='utf-8')
    print('generated 32 panels / 512 independent HiGHS model optima')

if __name__ == '__main__':
    main()
