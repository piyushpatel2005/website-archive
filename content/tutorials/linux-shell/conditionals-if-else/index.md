---
title: "Conditional Statement using If Else"
date: 2023-09-12T21:42:05Z
draft: false
---

In Linux bash programming, the `if-else` statement allows you to execute different parts of a script based on certain conditions. If conditional check results in true, it executes one part of code and if false, executes another section of code. In this tutorial, we'll explore how to use `if-else` statements for decision making in bash scripts.
<!--more-->

## Basic Syntax

The basic syntax of the `if-else` statement in bash scripts lok like below.

```bash
if condition
then
    # code block executed if condition is true
else
    # code block executed if condition is false
fi
```

The `condition` can be any expression that evaluates to either true or false. If the condition is true, the code block following the `then` keyword will be executed. Otherwise, the code block following the `else` keyword will be executed (if present). The `fi` keyword indicates the end of the `if-else` statement.

## Arithmetic operation: Check Even/Odd

Let's consider an example where we prompt the user for a number and determine whether it's even or odd using an `if-else` statement:

```bash
#!/bin/bash

echo "Enter a number:"
read num

if ((num % 2 == 0))
then
    echo "The number $num is even."
else
    echo "The number $num is odd."
fi
```

**Output:**

```output{.show-prompt lineNos=false }
bash script.sh
Enter a number:
3
The number 3 is odd.
```

In this script, we use the `%` operator to calculate the remainder when dividing `$num` by 2. If the remainder is 0, then `$num` is even and we display a corresponding message. Otherwise, `$num` is odd and we display another message. Here, pair of parenthesis (`(( arithmetic_operation ))`) are used to perform arithmetic operations.

## Nested `If...else` Statements

Bash scripting also allows nested `if-else` statements, where an inner `if-else` statement is placed within the code block of an outer `if` or `else` block. This allows for more complex decision making based on multiple conditions.

```bash
#!/bin/bash

echo "Enter your age:"
read age

if [[ $age -ge 18 ]]
then
    echo "You are eligible to vote."

    if [[ $age -ge 60 ]]
    then
        echo "You are also a senior citizen."
    fi
else
    echo "You are not eligible to vote."
fi
```

In this example, we check if the user's `age` is greater than or equal to 18 using the outer `if` statement. If it is, we display a message indicating that they are eligible to vote. Additionally, we have an inner `if` statement to check if their age is also greater than or equal to 60, in which case we display another message indicating that they are a senior citizen.

Here, we used expressions using double square brackets `[[ conditional ]]`. The same could have been written using arithmetic operation like `((age >= 60))`.

**Output:**

```output{ .show-prompt lineNos=false }
bash script.sh
Enter your age:
63
You are eligible to vote.
You are also a senior citizen.
```

With the `if-else` statements and optionally nested structures, you can make complex decisions and execute different parts of your bash script accordingly.

## `If-ElIf-Else` Example

Optionally, we can check multiple conditions using `if..elif..else`. We can add as many `elif` blocks as we want.

```bash
#!/bin/bash
echo "Start program"
value=4
if [[ $value -eq 4 ]]
then 
	echo "You entered $value"
elif [[ $value -gt 3 ]]
then
	echo "The argument is greater than 3"
else
	echo "This will run if statement if you pass 4 as command line argument"

fi
echo "End program"
```

Again as previously, we could use the arithmetic operations using `((value == 4))`.

**Output:**

```output{ lineNos=false }
Start program
You entered 4
End program
```

## Other conditionals

Other than arithmetic conditional checks, we may have to perform checks for if file exists or directory exists, if file is readable etc. We can check such conditional using `test` command. The basic syntax for this looks like `test EXPRESSION`.

```bash {.show-prompt-odd lineNos=false}
test -e /path/to/file && echo "File exists" || echo "File does not exist"
File exists # If file exists
test -d /path/to/directory && echo "Directory" || echo "File"
Directory # if this is directory
```

When using in the script, we can use it like this.

```bash
#!/bin/bash
if [ -e $1 ]
then
    echo "File exists"
else
    echo "File does not exist"
fi
```

Below is a list of all conditions we can perform. 

- `[num1] -eq [num2]`: True if `num1` is equal to `num2`.
- `[num1] -ne [num2]`: True if `num1` is not equal to `num2`.
- `[num1] -lt [num2]`: True if `num1` is less than `num2`.
- `[num1] -gt [num2]`: True if `num1` is greater than `num2`.
- `[num1] -ge [num2]`: True if `num1` is greater than or equal to `num2`.
- `[num1] -le [num2]`: True if `num1` is less than or equal to `num2`.
- `! [expr]`: True if `expr` is false.
- `[expr1] -a [expr2]`: True if `expr1` and `expr2` are true.
- `[expr1] -o [expr2]`: True if `expr1` or `expr2` is true.
- `-b [file]`: True if `file` is a block device.
- `-d [path]`: True if `path` exists and is a directory.
- `e [path]`: True if `path` exists, regardless of whether it is a directory or a file.
- `f [file]`: True if `file` exists and is a regular file.
- `r [file]`: True if `file` exists and is readable.
- `-s [file]`: True if `file` exists and has a size greater than zero.
- `w [file]`: True if `file` exists and is writable.
- `x [file]`: True if `file` exists and is executable.
- `O [file]`: True if `file` exists and is owned by the user id.
- `G [file]`: True if `file` exists and is owned by the group id.
- `[file1] -nt [file2]`: True if `file1` is newer than `file2`.
- `[file1] -ot [file2]`: True if `file1` is older than `file2`.
- `-z [string]`: True if the length of the `string` is zero.
- `n [string]`: True if the length of the `string` is non-zero.