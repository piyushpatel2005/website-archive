---
title: "Understanding Exit Codes"
date: 2023-09-12T21:39:08Z
draft: false
---

In the Linux operating system, processes return an exit code upon completion. This exit code provides valuable information about the success or failure of a command or program execution. Understanding these exit codes can help you troubleshoot issues, automate tasks, and build robust shell scripts.
<!--more-->

## What are Exit Codes?

Exit codes are integer values ranging from 0 to 255 that represent the execution status of a process. The convention is that an exit code of `0` indicates successful execution, while non-zero values indicate various types of failures or errors during execution of a process.

## Using Exit Codes in Scripts

Knowing how to handle exit codes in scripts allows you to make decisions based on command outcomes. Below is an example bash script which prints if the comamnd `cp /path/to/input.txt /path/to/output/` is successful or not. In shell, we can check exit code of previous command by using `$?`. On line `4`, we assign this exit code to new variables `exit_code`. If this exit code is `0`, then we had success with previous command, in this case `cp /path/to/input.txt /path/to/output/`. 

Also, note that on line `3`, we have a comment. In shell scripting, we can write comments and they start with pound or hash sign (`#`). All text after this symbol is ignored in the same line. Comments are only for explanatory notes, they do not have any specific meaning.

```bash
#!/bin/bash

cp /path/to/input.txt /path/to/output/ # This can be any command
exit_code=$?

if [[ $exit_code == 0 ]]; then
    echo "Command executed successfully."
else
    echo "Command failed with exit code: $exit_code"
fi
```

Please, note that, if we execute any other code after line 4, and then we try to check the exit code, it will give the status of previous command. So, in below snippet, the `exit_code` variable will have the status of `rm some_file.txt` command because that is the line before assigning this variable.

```bash
cp /path/to/input.txt /path/to/output/ # This can be any command
rm some_file.txt
exit_code=$?
```

## Common Exit Codes and their Meanings

Here are some common exit codes and their meanings:

- **Exit Code 0**: This indicates successful execution without any errors.
- **Exit Code 1**: Typically represents generic or unspecified error conditions.
- **Exit Code 2**: Indicates an issue with command line syntax or invalid arguments.
- **Exit Code 126**: This signifies that the command was found but was unable to be executed due to permission issues.
- **Exit Code 127**: When a command is not found, this error code is returned.
- **Exit Code 128**: Represents a fatal error signal such as segmentation fault or termination by another process.
- **Exit Code 130**: When a process is terminated by pressing Ctrl+C (SIGINT signal), it returns this exit code.

Different commands and programs may use specific exit codes to convey different meanings.It's crucial to consult their documentation for accurate interpretation.
