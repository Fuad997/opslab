# Understanding CI Feedback

Two GitHub Actions workflows run when you push or open a PR.

---
## 1. Linting Workflow

- [x] Checks:
    - ShellCheck
    - shfmt formatting
    - Required features (camelCase, shuf, getopts, case/esac, parameter expansion, etc)

- [x] If there are errors, the PR comment shows messages like:
```
❌ Missing camelCase variables
❌ getopts not found
❌ ShellCheck error SC2086
```
---
## 2. Grading Workflow

- [x] Runs on:
    - **Debian Trixie** → authoritative grade
    - Ubuntu-latest → comparison only

- [x] A PR comment will show:
```
Grade (Debian): 9/10
Summary:
<list of tests>
```
---
# Fixing Issues

- [x] Run locally:
```bash
./tests/studentAdvancedDiagnostics
./tests/studentTestHarness
./tests/gradeHangMan.pl
```
- [x] Fix issues, push again.
