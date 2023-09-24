---
title: "Reading Command Line Arguments"
date: 2023-09-12T21:48:41Z
draft: false
---

When executing shell scripts, command line arguments provide a convenient way to pass data or parameters to a script. These arguments can be used to customize the behavior of the script, provide input data, or specify runtime options. In this tutorial, we will explore how to read command line arguments and explain what each of those variables represents in a shell script.
<!--more-->

## Reading Command Line Arguments:
Command line arguments are accessed through special variables provided by the shell. Here are the three main variables used for reading command line arguments in a shell script:

1. The variable `$0` represents the name of the script that is being executed. It holds the path and filename of the current script.
2. The variables `$1`, `$2`, ..., `$n` represent positional parameters passed to the script. Each number corresponds to an argument's position on the command line.
3. The variable `$#` holds the count of all command line arguments passed to the script.

## Example Usage:
Let's understand how these variables work with an example.

```shell
#!/bin/bash

echo "Script Name: $0"
echo "Number of Arguments: $#"
echo "First Argument: $1"
echo "Second Argument: $2"
```

In this example, we assume that our script is named `my_script.sh`. Now let's consider different ways to execute this script:

```bash {.show-prompt-all lineNos=false }
chmod u+x script.sh
./script.sh hello world
```

**Output:**

```{ lineNos=false }
Script Name: script.sh
Number of Arguments: 2
First Argument: hello
Second Argument: world
```

## Practical Usage

The variable `$#` is extensively used to ensure that the script is executed with specific number of command line arguments.

```bash
#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Not enough command line arguments"
    echo "Usage: ./script.sh prod docker"
    exit 1
fi
ENV=$1
SYSTEM=$2
echo "Staring $SYSTEM on $ENV environment."
```

**Output:**

```output{ .show-prompt lineNos=false }
./script.sh
Not enough command line arguments
Usage: ./script.sh prod docker
```

```output{ .show-prompt lineNos=false }
./script.sh dev mysql
Staring mysql on dev environment.
```

If some of the arguments are optional, then we can also check that it has all the required number of mandatory arguments using `-lt` check.

```bash
if [ "$#" -lt 2 ]; then
    echo "Not enough command line arguments"
    exit 1
fi
```

Command line arguments are a powerful feature in shell scripting that enable us to dynamically customize scripts based on user input. By leveraging variables like `$0`, `$1`, `$2`, and `$#`, we can read and utilize these arguments effectively.