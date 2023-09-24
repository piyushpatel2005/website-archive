---
title: "Functions"
date: 2023-09-12T21:48:54Z
draft: false
---

Bash functions are a powerful tool in shell scripting that allow you to organize and reuse code. They provide modularity, enhance readability, and make scripts easier to maintain. In this tutorial, we will learn how to define function and use them in your bash scripts.
<!--more-->

## Defining Functions:
To define a function in Bash, we use function name followed by pair of parentheses. We use a code block using curly braces. The code between these curly braces is the function body.

```bash
function_name () {
  # Function body
  # Execute commands
}
```

Another way to define a function in bash is using reserved keyword `function`.

```bash
function func_name() {
    # function body
}
```

## Passing Arguments:
Bash allows you to pass arguments to functions when they are called. These arguments can be accessed within the function using special variables like command line arguments.

1. `$1`, `$2`, `$3`, etc. represent command line arguments passed to the function.
2. `$@` represents all arguments passed as an array.
3. `$#` represents the total number of arguments passed.

Here's an example that demonstrates how to pass and access arguments within a bash function:

```bash
#!/bin/bash
my_function() {
  echo "The first argument is: $1"
  echo "The second argument is: $2"
}

my_function hello world
```

**Output**

```output{ lineNos=false }
The first argument is: hello
The second argument is: world
```

## Returning Values from Functions:
In Bash, values can be returned from a function using the `return` statement followed by an integer value representing an exit code. The exit code conveys the outcome or status of the function execution.

```bash
my_function() {
  # Perform actions or calculations
  return 42
}

result=$(my_function)
echo "Return value: $result"
```

## Understanding Exit Codes:
Exit codes have several purposes when it comes to bash functions.

1. An exit code of `0` indicates success or that the function executed without encountering any errors.
2. Non-zero exit codes, typically in the range 1-255, indicate an error or some other specific condition.
3. Exit codes can be used to control the flow of a script by checking for specific conditions or handling errors.

To access the exit code of a function, you can use `$?`, which captures the last command's exit status in Bash.

```bash
my_function
if [[ $? -eq 0 ]]; then
  echo "Function executed successfully"
else
  echo "Function encountered an error"
fi
```

