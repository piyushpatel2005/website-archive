---
title: "Break and Continue Statements"
date: 2023-09-12T21:44:00Z
draft: false
---

In Bash scripting, the `continue` and `break` keywords are control flow statements that allow you to alter the execution of loops. They are typically used within loop structures to skip specific iterations or completely exit a loop when certain conditions are met.
<!--more-->

## `continue` keyword:
The `continue` keyword is used to skip the current iteration of a loop and move on to the next one. It is particularly useful when you want to bypass certain iterations based on specific conditions.

Here's an example that demonstrates the usage of this keyword.

```bash
#!/bin/bash

for num in {1..10}
do
    if ((num % 2 == 1))
    then
        continue
    fi
    echo $num
done
```

**Explanation:**

In this script, we use a `for` loop to iterate from 1 to 10. The condition `((num % 2 == 1))` checks if the current number `num` is not divisible by 2, that is if the number is odd. If this condition evaluates to true, (if `num` is odd) the `continue` keyword will be executed which will skip that particular iteration. If the condition evaluates to false, we print out the value of `num`.

**Output:**

```
2
4
6
8
10
```

## `break` keyword:

The "break" keyword allows you to exit out of a loop completely when certain conditions are met. It can be useful when you need to terminate a loop prematurely. 

```bash
#!/bin/bash

for num in {1..10}
do
    if ((num % 4 == 0))
    then
        break
    fi
    echo $num
done 
```

**Output:**

```output{ lineNos=false }
1
2
3
```

Above code is similar to previous one. In this case as soon as we encounter the value which is divisible by 4, we exit the iteration. The first value will be 4, so the output is 1 to 3.

This is quite useful when we are creating some interactive script where user can input data.

```bash
#!/bin/bash
echo "Please talk to me..."
while true
do
	read input
	case $input in
		hello)
			echo "Hello there!"
			;;
		bye)
			echo "See you again!"
			break
			;;
		*)
			echo "Sorry, I don't understand"
			;;
	esac
done
```

**Explanation:**

In above script, we have infinite loop with `while true`. This loop never terminate itself. Inside the `while` loop, we accept user input and store in a variable `input`. We then perform conditional checks on this variable value and check if it is string 'hello', 'bye' or something else using `case` statements. We perform action corresponding to each of those. If it's 'bye', then we want to exit the `while` loop, so we have `break` statement in that conditional check.

**Output:**

```output{ .show-prompt lineNos=false }
bash script.sh
Please talk to me...
hello
Hello there!
how are you?
Sorry, I don't understand
bye
See you again!
```
