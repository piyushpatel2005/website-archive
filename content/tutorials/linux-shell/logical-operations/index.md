---
title: "Logical Operations"
date: 2023-09-12T21:41:26Z
draft: false
---

In the Linux Bash scripting, logical operations are used to combine conditional statements and perform actions based on their outcomes. Learning how Logical operations can be performed in Bash enahnces our ability to write efficient and powerful scripts.
<!--more-->

In Bash scripting, boolean values are represented as either `true` or `false`. However, the shell doesn't natively support boolean types. Instead, integer values are used to represent boolean logic. 

## Logical Operators

There are three main logical operators available in Bash scripting:

- **AND Operator (`&&`)**: Denoted by `&&`, the AND operator evaluates two conditions and returns `true` only if both conditions are true.

**Example:**

```bash
age=19
gender="male"
if [ $age -gt 18 ] && [ $gender == "male" ]; then
    echo "You are a male adult."
fi
```

- **OR Operator (`||`)**: Denoted by `||`, the OR operator evaluates two conditions and returns `true` if either of the conditions is true.

**Example:**

```bash
country="India"
if [ $country == "USA" ] || [ $country == "Canada" ]; then
    echo "You are in North America."
fi
```

- **NOT Operator (`!`)**: Denoted by `!`, the NOT operator negates a condition. If a condition is true, applying the NOT operator will make it false, and vice versa.

**Example:**

```bash
country="UK"
if ! [ $country == "India" ]; then
    echo "This is not India."
fi
```

Below is a common script explaining different operations.

```bash
#!/bin/bash
echo I will succeed
echo $?
# The same kind of status codes exist for true and false
# true has status code of 0
# Based on these status codes it will decide further action
# Bash supports logical operations like && and ||
true # This has exit code 0
echo "Status code after true $?"

false # This has exit code 1
echo "Status code after false $?"
```

Logical operators can be combined to create more complex expressions. Parentheses can be used to group conditions and control their precedence.

**Example:**

```bash
if [ $age -gt 18 ] && ( [ $gender == "male" ] || [ $gender == "female" ] ); then
    echo "You are an adult."
fi
```

## Short-circuit operations

Something that's very common in shell scripting is to use these operations to short-circuit execution of commands. For example, if we want second command to run only when first command has failed, in that case, we can use `||`. This OR operation evaluates second expression only if first one fails. Similarly, if we want both expression to run only if first expression is true, then we can use `&&`. In this case, if first expression results in `false` then second expression is not evaluated at all. Below script demonstrates examples.

```bash
echo Hello && echo Hi
echo Hi || echo Hello
```

This pattern can be used for short-circuit evaluations

```bash
cp test.txt another.txt && echo "Copied script text.txt" || echo "Copy failed"
```

In above example snippet, if the copy succeeds, it produces output "Copied script test.txt" but if it fails, it produces output "Copy failed". You may notice this kind of short-circuit pattern in some of the bash scripts.

Logical operations in Linux Bash terminal provide a powerful way to evaluate conditions and control the flow of your scripts. By utilizing these logical operators effectively, you can make flexible shell scripts.