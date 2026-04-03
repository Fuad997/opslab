# Student Advanced Diagnostics

This is not a grader, rather it  focuses on:
- Deeper structural correctness analysis
- Verifying required blocks are present
- Checking ordering expectations
- Verifying that you didn’t “hack around” required parts
- Giving actionable suggestions
- Still revealing nothing about the solution logic

Run:
```bash
tests/studentAdvancedDiagnostics
```

## 🎯 This script goes well beyond the basic diagnostic:

### 1. Verifies presence of required functions  
- usage
- incrementGuess
- endGame
- writeWord  
- etcetera

### 2. Identifies missing structural blocks  
- getopts
- case/esac
- shuf
- parameter expansion
- camelCase variables
- gameplay loop  
- etcetera

### 3. Flags “suspicious” commands 
- [x] You must use POSIX shell fundamentals 
    -  if you try to build a HangMan by outsourcing work like word masking to sed, awk, or grep, this script gently warns you.

### 4. Ensures code structure matches your expectations (suggested in scaffold)
This protects academic integrity and prevents “creative interpretations” that bypass intended learning outcomes.

### 5. Syntax check  
Equivalent to bash -n.

### 6. Smoke launch test  
Confirms ./hangMan.ghc -d runs without crashing.

### 7. No solution hints  
All the hints are in the scaffolding, where they belong
