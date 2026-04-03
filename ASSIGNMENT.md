=== **BASH or ksh LAB**: hangman app


Complete the development of the hangman app started in class.  


## **Must use:**

- [x] camel case
- [x] proper linting (indentation)
- [x] proper comment block
- [x] self-documenting code (style)
- [x] best practice use of variables, etcetera
- [x] good programming "hygiene"
- [x] c-style blocks (not shell style blocks)
- [x] test(), eval() and expr() as needed
- [x] numeric and text operators properly
- [x] you may not use grep(), sed(), awk() 
- [x] shell parameter interpolation match/substitution:

```bash
    # use a scalar to store user input**
        guess+=$userInput
        echo "$\{string//\[^$guess\]/\\\#\}"
    ## or
    # use an array to store user input
        guess+=($userInput)
        echo "$\{string//\[^$\{guessArray\[-\]\}\]/\\\#\}" 
    ## other uses
        $\{string%% -\} \# parameter match rejects after \[space\]
        $\{string\#- \} \# parameter match rejects up to \[space\]
```

- [x] win or lose, the game must exit with this code:

```bash
# **Force output to flush before exiting**
    sleep 1.0
    echo "" >&2
    echo "" >&1
    sync

	exit 
```

## **Potential Grade - D**

### The prototype must use:

- [x] a unique wordlist or four sets of wordlists to pick from (short, regular, long, xl); minimum 100 words in each list
	- [x] sanity check that wordlist being used is not empty
	- [x] user can chose length of word to pick using switch s \[e.g -s 5\] 

### Feedback 

    - [x]  feedback strings for incorrect guesses must begin with the following utf-8 prefix, followed by a space, and then the feedback of your choosing:  

>        null                - ❌2:  
>        space               - ❌3:  
>        multiple chars      - ❌4:  
>        non-alphabetic      - ❌5:  
>        previously guessed  - ❌6:  
>        word file not found - ❌7:  

    - [x]  feedback strings for correct guesses must begin with the utf-8 char ✅, followed by a space and then feedback of your choosing:  

>            found in word   - ✅  

    - [x] user feedback on winning or losing, must begin with the corresponding utf-8 chars:  

>            win    - 🎉  
>            lose   - 💀  


## **Potential Grade – C**

- [x] development done using github (GHEC and EMU)
- [x] minimal/infrequent commits


## **Potential Grade – B**

- [x] evidence of iterative development using many/frequent commits
- [x] includes a README.md file explaining the gameplay


##**Potential Grade - A**

additional elements:
- [x] additional programmer built functions
- [x] use of associative array
- [x] pass arguments in, and/or return values from a programmer built function
- [x] add colour coding to your output


###Submit your solution.
- Indicate as a comment, either in the code block or in a separate COMMENTS.md, what potential grade you were attempting to achieve.


