---
title: "Variables and Basic Input/Output"
date: 2023-09-12T21:37:01Z
draft: false
---

In this tutorial, we'll explore how to declare variables and perform basic input and output operations in the Linux terminal.

<!--more-->
## Declaring Variables

To declare variables in Linux, you can use the `=` assignment operator. Here's an example:

```bash
name="John"
age=25
echo $name $age
```

**Output:**

```shell{ .show-prompt lineNos=false }
John 25
```

In the above example, we've declared two variables: `name` and `age`. The value of `name` is set to "John", while the value of `age` is set to 25. 

### Using the `local` keyword

The `local` keyword allows you to declare a variable with local scope within a function or script. Here's an example:

```bash
my_function() {
  local variable_name="value"
}
```

In the above example, we define a shell function called `my_function`. Inside the function, we use the `local` keyword to declare a variable named `variable_name` and assign it the value "value". 

Note that variables declared with `local` are only accessible within the function or script in which they are defined.

### Using the `let` keyword

The `let` keyword is used for arithmetic operations and variable assignment. It allows you to perform calculations and update variable values in a concise manner. Here's an example:

```bash
let "result = 5 + 3"
```

In this example, we use the `let` keyword to perform addition (`5 + 3`) and assign the result to the variable named `result`.

You can also use variables in arithmetic expressions with the help of `$` sign:

```bash
a=5
b=3
let "result = $a + $b"
```

This will add the values of variables `$a` and `$b`, storing the result in `$result`.

The advantage of using the `let` keyword is that it eliminates the need for explicit command substitution or quoting.

When using these keywords, it is important to follow proper syntax rules, including any necessary quotation marks or mathematical expressions.

With this knowledge of declaring variables using `local` and performing arithmetic operations using `let`, you can enhance your Linux shell scripts and functions. 

You can also assign the output of a command to a variable using command substitution using `$`.

```bash
current_date=$(date +%Y-%m-%d)
echo $current_date
```

In this case, the current date will be stored in the `current_date` variable. Again, to print the value of a variable we can use `echo` command and prefix the variable name with `$` symbol.

## Basic Input and Output

There are basically two methods to accept user input.

### Taking User Input

To get input from the user in Linux, you can use either the `read` command or by passing arguments directly from the command line. 

Using the `read` command:

```bash
read -p "Enter your name: " name
echo "Hello $name!"
```

**Output:**

```bash{ .show-prompt lineNos=false }
bash main.sh
Enter your name: George
Hello George!
```

The `-p` option allows you to display a prompt message before accepting user input.

Another way to get input is by passing arguments to bash script directly from the command line.

```bash
echo "Hello $1!"
```

**Output:**

```bash{ .show-prompt lineNos=false }
bash main.sh Alex
Hello Alex
```

Here, `$1` represents the first argument passed to our script or command. You can pass multiple arguments separated by spaces.

#### Printing output 

For displaying output in Linux, you can use the `echo` or `printf` commands:

```bash
echo "Hello World"
printf "Welcome to my blog!"
```

Both commands will display their respective messages on the terminal.