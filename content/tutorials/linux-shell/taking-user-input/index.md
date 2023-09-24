---
title: "Taking User Input"
date: 2023-09-12T21:41:03Z
draft: false
---

Shell scripts are a powerful way to automate tasks on the command line. To make these scripts more interactive and versatile, it's often necessary to prompt the user for input. In this tutorial, we'll explore different methods of taking user input in shell scripts.
<!--more-->

## 1. Using `read` Command

The most common method to obtain user input in shell scripts is by using the `read` command. The `read` command allows you to prompt the user for input and store their response into a variable.

**Example:**

```bash
#!/bin/bash

echo "Please enter your name:"
read name

echo "Hello, $name! Nice to meet you."
```

**Output:**

```output{ .show-prompt lineNos=false }
bash script.sh
Please enter your name:
Anita
Hello, Anita! Nice to meet you.
```

In this script, the `read` command is used to store the user's input into the `$name` variable. The input can be any text entered by the user.

To ensure that users provide valid or expected inputs, we can combine the `read` command with conditional statements. For example:

```bash
#!/bin/bash

read -p "Enter your age: " age

if [[ $age =~ ^[0-9]+$ ]]; then
    echo "Your age is valid."
else
    echo "Invalid age provided. Age should be numeric only."
fi
```

In this script snippet, the `read` command is used to capture the user's input into the `$age` variable. The subsequent if-statement checks whether the input consists only of digits using regular expressions.

**Output:**

```output{ .show-prompt lineNos=false }
bash script.sh
Enter your age: 22
Your age is valid.
```

```output{ .show-prompt lineNos=false }
bash script.sh
Enter your age: twenty
Invalid age provided. Age should be numeric only.
```

## 2. User Input from Command Line Arguments

Another way to get user input is using command line arguments which are passed to the script being executed. Bash scripts can access command line arguments through special variables: `$1`, `$2`, `$3`, and so on. We will learn about them in the later lesson but they are just positional arguments passed into the script. 

`$0` represents the  script filename itself, while `$1` and `$2` hold the first and second command line arguments passed when running the script. We can also pass more than 2 arguments, but this example demonstrates only two command line arguments.

```bash
#!/bin/bash

echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
```

**Output:**

```output{ .show-prompt lineNos=false }
bash my_script.sh Robert 23
Script name: my_script.sh
First argument: Robert
Second argument: 23
```
