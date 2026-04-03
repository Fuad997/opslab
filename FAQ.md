# FAQ — HangMan Assignment

---
## ❓ CI says I'm missing camelCase variables.

+ Use names like:
```
wrongGuesses
pickedWord
minWordLength
```
---
## ❓ CI says parameter expansion not found.

+ Make sure you use patterns like:
```bash
${string//[^${guess,,}]/_}
${value#prefix}
```
---
## ❓ Why Debian and Ubuntu?

+ Debian Trixie is the authoritative grading environment.
+ Ubuntu is for portability.

---
## ❓ My script works locally but fails CI!

+ You must satisfy both functional and stylistic requirements.
+ Run locally:
```bash
./tests/studentAdvancedDiagnostics
./tests/studentTestHarness
./tests/gradeHangMan.pl
```
---
## ❓ I still don't understand my CI error.

Re-read:
- STYLE_GUIDE.md
- FEATURE_REQUIREMENTS.md
- TEST_HARNESS.md
- ASSIGNMENT.md
- HOW_TO_INTERPRET_CI.md
- README.md

** Ask early — don’t wait until the deadline. **
