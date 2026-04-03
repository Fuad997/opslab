# Student Test Harness
This is not a grader,

```bash
tests/studentTestHarness
```

But it does give you the ability to smoke test:
-script execution
-command-line parsing
-text prompts
-input validation flow
-basic gameplay loop assumptions

🎯 Why This Harness Is “Minimal but Helpful”
## This harness:

✔ Validates the basics
- Script is executable
- Usage message exists
- -d debug mode launches
- Prompt appears
- Basic input validation works (space, blank, multi‑char, non-alpha)

✔ Does NOT reveal:
- correct word
- testWords order or content
- any grading logic
- expected outputs in deterministic form
- the solution
- any end‑game text

✔ Does NOT interfere with grader
- The harness does not depend on:
    - number of wrong guesses
    - word masking logic
    - win/loss detection
    - file selection
    - or any test scenario used by the official grader

✔ Uses Expect safely
- The harness only checks for the presence of error tokens (❌2, ❌3…)
  not logic tied to the solution.

✔ You get sanity checks
- This should dramatically reduce “my script doesn’t run at all” questions.

