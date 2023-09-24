---
title: "Basic Math Operations"
date: 2023-09-12T21:39:42Z
draft: false
---

Bash provides the ability to perform basic math operations directly from the terminal. This allows you to easily manipulate numbers and perform calculations without the need for a separate calculator program. 

<!--more-->
In this article, we will explore some of the basic math operations you can perform using Bash.

## Addition

To add two numbers together in Bash, you can use the `+` operator.

**Example:**

```bash
#!/bin/bash
num1=5
num2=10
sum=$((num1 + num2))
echo "The sum is: $sum"
```

In this example, we declare two variables `num1` and `num2` with values 5 and 10 respectively. We then use the `$(( ... ))` syntax to perform the addition operation and assign the result to a variable `sum`. Finally, we use `echo` to display the result.

**Output:**

```output{ lineNos=false }
The sum is: 15
```

## Subtraction

Similarly, you can subtract one number from another using the `-` operator. 

**Example:**

```bash
#!/bin/bash
num1=15
num2=8
difference=$((num1 - num2))
echo "The difference is: $difference"
```

## Multiplication

To multiply two numbers in Bash, you can use the `*` operator.

```bash
#!/bin/bash
num1=7
num2=3
product=$((num1 * num2))
echo "The product is: $product"
```


## Division

Bash also supports division operations using the `/` operator. However, bash only performs integer division by default. If you want to perform floating-point division, you need to use an external tool like Basic Calculator (`bc`). 

```bash
#!/bin/bash
num1=10
num2=2
quotient=$((num1 / num2))
echo "The quotient is: $quotient"
```

### Using `bc` tool

To install `bc`, use below command.

```bash{ .show-prompt lineNos=false }
sudo apt install bc
```

This tool can be used interactively like below.

```bash{ .show-prompt lineNos=false }
bc
bc 1.07.1
Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017 Free Software Foundation, Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'. 
3 + 4
7
5 / 2
2
5 % 2
1
quit
```

If we want to use calculations like these in our script then we have to pipe these operations to `bc` command.

```bash
#!/bin/bash
echo '5/2' | bc
modulo=$(echo '5 % 2' | bc)
echo "5 % 2 = $modulo"
```

**Output:**

```output{ lineNos=false }
2
5 % 2 = 1
```

Performing basic math operations in Bash can simplify your scripting tasks and allow you to quickly perform calculations without leaving the terminal. By mastering these simple operations, you can build more complex scripts that involve mathematical computations.