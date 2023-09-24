---
title: "Loops"
date: 2023-09-12T21:43:40Z
draft: false
---

In this tutorial, we'll explore the concept of loops in the Linux Bash scripting. Loops are control structures that allow you to repeatedly execute a block of code until a certain condition is met.
<!--more-->

## Usage of Loops

Loops are commonly used in shell scripting for various purposes, such as:

- Iterating over files and directories and moving certain files
- Processing lines from a file or input stream. For example, reading each line and appending some text.
- Executing commands until a certain condition is met.
- Performing repetitive tasks with different inputs.

There are three types of loops commonly used in Bash.

## 1. For Loop

The `for` loop allows you to iterate over a sequence of values and execute a block of code for each value.

```bash
for variable in value1 value2 ... valuen
do
    # Code statements
done
```

For example, let's use a `for` loop to print the numbers from 1 to 5:

```bash
#!/bin/bash
for i in 1 2 3 4 5
do
    echo $i
done
```

If we have to iterate over many times, writing those many numbers as sequence is cumbersome. In such conditions, we can uses braces operator like this.

```bash
#!/bin/bash
for i in {1..20}
do
    echo "Number: $i"
done
```

**Output:**

```output{ .show-prompt lineNos=false }
bash script.sh
Number: 1
Number: 2
... ...
Number: 20
```

### Looping over Array

Similar to this we can iterate over array elements using `${array_name[*]}` syntax.

```bash
names=(John Jenny Zoe)
for name in ${names[*]}
do
    echo "Name: $name"
done
```

**Output:**

```output{ lineNos=false }
Name: John
Name: Jenny
Name: Zoe
```

### Looping through lines of a file

Similarly, for reading file content, we can use `for` loop along with `cat` command. We will see more examples of this in upcoming lesson.

```bash
for line in `cat /path/to/file`
do
    echo $line
done
```

## 2. While Loop

The `while` loop executes a block of code as long as a given condition is true.

```bash
while [ condition ]
do
    # Statements
done
```

Here's an example that uses a `while` loop to count down from 5 until 0.

**Example:**

```bash
#!/bin/bash
counter=5

while [ $counter -gt 0 ]
do
    echo $counter
    ((counter--))
done
```

## 3. Until Loop

Similar to the `while` loop, the `until` loop also executes a block of code repeatedly until a given condition becomes true.

```bash 
until [ condition ]
do 
   # Statements
done 
```

Below is an example where we use an `until` loop to print numbers from 1 to 3:

```bash
#!/bin/bash
number=1 

until [ $number -gt 3 ] 
do 
   echo $number 
   ((number++)) 
done 
```

**Output:**

```output{ lineNos=false }
1
2
3
```

Loops are an essential constructs in Linux Bash scripting that allow you to automate repetitive tasks and iterate over sequences of values. 