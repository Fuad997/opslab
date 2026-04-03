# Shell Script Style Guide

This assignment enforces specific shell‑scripting style standards.

---
# 🎯 Required Style Elements

## 1. camelCase Variable Names
Correct:
```bash
wrongGuesses=0
pickedWord="triangle"
minWordLength=3
```
Incorrect:
```
WRONG_GUESSES=0
picked_word="triangle"
min_word_length=3
```

---
## 2. Parameter Expansion
You must demonstrate meaningful usage
As example:
```bash
modifiedValue="${someVariable//[^${anotherVariable,,}]/_}" #n.b. note how this deals with case
extension="${filename##*.}"
partialValue="${colonDelimitedRecord#*:}"
```

---
## 3. Use of shuf
Must select a random word using `shuf`
As example:
```bash
arbitraryValue=$(shuf -i 1-${numberOfRecords} -n 1)
```

---
## 4. getopts
As example:
```bash
while getopts ":a:b:cde" switch; do
  case "$switch" in
    ## more code
  esac
done
```

---
## 5. case/esac
```bash
  case "$switch" in
    a) assignValue="$OPTARG" 
       ;;
    b) assignValue="$OPTARG" 
       ;;
    c) # do something 
       ;;
    d) # do something 
       ;;
    e) # do something 
       ;;
    :) echo "Missing argument" ; 
       exit 1 
       ;;
    ?) echo "Invalid flag" ; 
       exit 1 
       ;;
  esac
```

---
## 6. C‑Style Blocks
```bash
if [[ condition ]]; then
  action
fi

if [ condition ]; then
  action
fi
```

---
## 7. Regexp binding to variables
```bash
if [ $variable =~ ^$ ]; then
  action
fi
```

---  

## 8. General Hygiene
- consistent indentation (2 spaces recommended)
- meaningful variable names
- comments for major logic blocks
- efficiency, e.g.avoid unnecessary pipes and subshells

---
## 9. Cardinality
- code must be cardinally correct
