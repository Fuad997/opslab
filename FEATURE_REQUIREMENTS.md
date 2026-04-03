# Feature Requirements

- [x] Your script **must** demonstrate the following features.
- [x] These are automatically checked in CI.

---
## ✔ 1. Parameter Expansion

- [x] Valid examples:
```bash
${var}
${value#prefix}
${value%%suffix}
${string//pattern/replacement}
```
---
## ✔ 2. Use of shuf

```bash
pickMe=$(shuf -i 1-${recordSize} -n 1)
```
---
## ✔ 3. camelCase Variables

- [x] Examples:
    - wrongGuesses
    - pickedWord
    - minWordLength
---
## ✔ 4. getopts

- [x] You must parse arguments using getopts.
---
## ✔ 5. case/esac Block

- [x] Used for decision flow.

---
Missing any required feature will cause the lint workflow to fail.
