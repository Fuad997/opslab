[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/YnujQj3v)
# HangMan Assignment (Shell Scripting)

[Definitive Specificaitons](ASSIGNMENT.md)


Welcome to your HangMan assignment! This repository contains all the starter
files, tests, and automated grading workflows you will need.

Your task is to **complete `hangMan.ghc`** so that it:

- behaves correctly as a HangMan game,
- uses required shell‑scripting features,
- passes the automated tests,
- follows the required style guidelines.


---
## 📦 Repository Structure
```
./
├── hangMan.ghc             # edit this file, don't edit others
├── README.md               # read the markdown files (md)
├── ADVANCED_DIAGNOSTICS.md
├── ASSIGNMENT.md
├── FAQ.md
├── FEATURE_REQUIREMENTS.md
├── HOW_TO_INTERPRET_CI.md
├── STYLE_GUIDE.md
├── TEST_HARNESS.md
├── LICENSE                 # read the license
├── autograde_results
├── feedback
├── tests
│   ├── gradeHangMan.pl
│   ├── studentAdvancedDiagnostics
│   └── studentTestHarness
└── words
    └── testWords.7
    └── add your word files here
```

---
## ▶️ Running Your Program

```bash
chmod +x hangMan.ghc
./hangMan.ghc -s 5      # choose word length
./hangMan.ghc -d        # use testWords.7 for predictable behaviour
```
---
## 🧪 Running Tests Locally

```bash
./tests/studentTestHarness
./tests/studentAdvancedDiagnostics
./tests/gradeHangMan.pl
```
This runs:
+ two local tests with local feedback
+ a similar grading test used by the GitHub CI.

---
## 📣 CI Feedback on Pull Requests
When you push to GitHub or open a Pull Request, two workflows run:

### 1. **Lint Workflow**
Checks:
- ShellCheck
- shfmt
- Required features:
  - camelCase variables
  - `getopts`
  - `case/esac`
  - parameter expansion
  - use of `shuf`
  - etcetera

### 2. **Grading Workflow**
- [x] Runs your script on:
    - **Debian Trixie** → authoritative grade check
    - Ubuntu-latest → portability check

- [x] A bot posts a comment in your PR with:
    - your numeric grade
    - test summaries
    - linting errors (if any)

## 🚨 Files You Should Modify

- [x] You should only modify:

    - **`hangMan.ghc`**
    - add yor four wordlist files  inside `words/`


- [x] Do NOT modify:
    - anything else
- [x] modifying tests, or workflows, can constitute an Academic Integrity Violation (e.g. cheating)

---
See additional documentation:  
[Definitive Specificaitons](ASSIGNMENT.md)  
[Student Test Harness](TEST_HARNESS.md)  
[Student Advanced Diagnostics](ADVANCED_DIAGNOSTICS.md)  
[Style Guide](STYLE_GUIDE.md)  
[Feature Requirements](FEATURE_REQUIREMENTS.md)  
[What CI Results Mean](HOW_TO_INTERPRET_CI.md)  
[Assignment FAQ](FAQ.md)  

