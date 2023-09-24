---
title: "Standard Streams and IO Redirection"
date: 2023-09-12T21:44:46Z
draft: false
---

In this lesson, we'll explore the concept of output redirection and input/output streams in the Linux operating system. These concepts help in managing the command line output and even managing logs of the scripts we automate.
<!--more-->

## The Three Standard Streams

In Linux, there are three standard streams that allow communication between the user, the terminal, and processes. These standard streams are:

1. **Standard Input (stdin):** This is the input stream, where data is sent to programs. The default source of this stream is the keyboard. It’s represented as file descriptor 0.
2. **Standard Output (stdout):** This is the output stream, where programs output their data. The default destination of this stream is the terminal (screen). It’s represented as file descriptor 1.
3. **Standard Error (stderr):**  This is another output stream, typically used by programs to output error messages or diagnostics. It is also displayed on the screen by default. It’s represented as file descriptor 2.

## Output Redirection

Output redirection allows you to control where the standard output (stdout) or standard error (stderr) of a command is directed. By default, both stdout and stderr are displayed on the terminal. However, with output redirection, you can redirect them to different locations.

### Redirecting Standard Output (stdout)

To redirect standard output to a file, use the `>` operator followed by the file name you want to redirect the output to. This stream is also referred using number 1.

```bash
command > filename
```

For example, let's save the output of a command that lists files in a directory to a file called `fileslist.txt`:

```bash{.show-prompt lineNos=false }
ls > fileslist.txt
```

By executing this command, the list of files in the current directory will be written to `fileslist.txt`.

You can also append output to an existing file using `>>`. This is useful if you want to add new content without overwriting existing data.

```bash
command >> filename
```

### Redirecting Standard Error (stderr)

Similar to redirecting stdout, you can redirect stderr using the `2>` operator. The stderr stream is also referred using number 2.

```bash
command 2> errors.log
```

This will send any error messages produced by the command to an `errors.log` file instead of displaying them on the terminal.

### Redirecting Both Output and Error

If you want both stdout and stderr redirected to different places or combined into one file, you can use the following syntax:

```bash
# redirect stdout to output.log and stderr to errors.log
command > output.log 2> errors.log

# combine both streams into single file
command > output-and-errors.log 2>&1
```

The `2>&1` redirects stderr to stdout, so both streams will be written to the same file (`output-and-errors.log` in this case).

### Piping output as Input to another command

Piping takes the output from one command and uses it as input for another command, connecting them through standard streams. We have used pipes earlier. For example:

```bash{.show-prompt lineNos=false }
cat /path/to/file | grep "keyword"
```

In this example, the content of `/path/to/file` is writtent to stdout and it then piped to `grep`, filtering only lines that contain "keyword" in it.

## Input Redirection

2. **Redirecting Standard Input:**
   - Redirecting standard input allows you to take user input from a file instead of the keyboard. For example:
     ```
     $ ./script.sh < input_data.txt
     ```
   - In this example, the `script.sh` script reads its input from the `input_data.txt` file instead of waiting for user input from the keyboard.


By default, a command reads its input from standard input (stdin), which is usually the keyboard. However, you can redirect stdin from a file using the `<` operator.

```bash
command < filename
```

For example, let's use the `cat` command to display the contents of a file named `data.txt`:

```bash
cat < data.txt
```

In this case, `cat` reads its input from `data.txt` instead of waiting for user input.

Redirecting standard input allows you to take user input from a file instead of the keyboard. Below example will make it little more clearer. I have file `test.txt` with content below.

```output{ lineNos=false }
name1
name2
name3
```

**Example:**

```bash
#!/bin/bash
names=(John Jenny Zoe)
for name in ${names[*]}
do
    read name
    echo "Name: $name"
done
```

In this script, even though, we have an array with names John, Jenny and Joe, on line 5, we are reading input from stdin, we can redirect the input from the file `test.txt` and it will print different name values in the output as shown below.

**Output:**

```bash {.show-prompt lineNos=false }
./script.sh < test.txt
Name: name1
Name: name2
Name: name3
```

Understanding of input/output streams in Linux is crucial for managing command line output effectively. With output redirection, we can effectively control where standard output and standard error are sent. Additionally, using input/output streams allowss to manipulate command inputs and combine outputs between commands.