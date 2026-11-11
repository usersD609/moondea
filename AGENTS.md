# Engineering constraints
Use MoonBit >=0.10.18. Each top-level MoonBit block begins with `///|`.
After changes run `moon info`, inspect interfaces, `moon fmt`, strict checks and tests.
Do not turn numerical/iteration failures into success. Keep applications and credentials outside this repository.
Tests assert expected values and invariants, not just execution. No generated padding or copied upstream implementations.
