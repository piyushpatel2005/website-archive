---
title: "Working With Files Directories"
date: 2023-09-12T03:03:53Z
draft: false
---

With Linux, it's very easy to navigate directories and files using just few commands. In fact, it can be even faster than normal GUI desktop. Usually, terminal operations are lot faster than GUI based operations. This lesson shows how we can read the contents of the file and how to navigate around the directories in Linux.

<!--more-->

In this lesson, we will explore some of the command we learned in the previous lesson.

```bash{ lineNos=false }
pwd
```

By default, we are in user's home directory which looks something like below.

```console{ lineNos=false }
/home/username
```

Ok, let's create our directory and try to create directories and files inside it.

```bash{ lineNos=false }
mkdir bash-session # create directory
cd bash-session # change into new directory
mkdir folder1
mkdir folder{2..3}
ls # list current directory
```

Here, we have three directories.

```console{ lineNos=false }
folder1 folder2 folder3
```

Let's remove them and recreated a nested directory structure where we will create our first file.

```bash{ lineNos=false }
rmdir folder{1..3} # remove multiple empty directories
ls # No directories or files
```

```shell{ lineNos=false }
mkdir dir1/inside_dir1 # produces error because dir1 does not exist
mkdir: cannot create directory ‘dir1/inside_dir1’: No such file or directory
```

Above command fails because when shell tries to create child directory `inside_dir1`, it did not find the parent directory. By default, `mkdir` assumes that the parent directory exists. If we want to create parent directory if it does not exist, then we have to use `-p` option with this command.

```bash{ lineNos=false }
mkdir -p dir1/inside_dir1 # works fine because -p can create path if not exists
cd dir1/inside_dir1/
touch hello.txt # create 'hello.txt' file
echo "Hello" # prints Hello on terminal
```

Before, we go further, we have to learn few more Linux commands.

### `echo`: Printing
The `echo` command is used to display text on the terminal or redirect it into a file.
- Syntax: `echo [OPTIONS] [STRING]`
- Usage: 
    - Writing to the console: `echo "Hello World"`
    - Writing to a file: `echo "Linux is awesome" > linux.txt`

### `cat`: Read files and Display content
The `cat` command is used for reading files sequentially and displaying their contents on the terminal.
- Syntax: `cat [OPTIONS] [FILE(S)]`
- Usage:
    - Read file content and display on terminal: `cat file.txt`
    - Combine two files into single file: `cat file1.txt file2.txt > combined.txt`

### `head`: Print first part of file
The `head` command displays the beginning lines of a file. By default, it shows the first 10 lines but can be customized using options.
- Syntax: `head [OPTIONS] [FILE(S)]`
- Usage:
    - Display first 10 lines: `head file.txt`
    - Display first 5 lines: `head -n 5 file.txt`

### `tail`: Print last part of file
Description: The `tail` command displays the ending lines of a file. By default, it shows the last 10 lines but can be customized using options.
- Syntax: `tail [OPTIONS] [FILE(S)]`
- Usage:
    - Display last 10 lines of a file: `tail file.txt`
    - Display last 3 lines of a file: `tail -n 3 access.log`


```bash{ lineNos=false }
echo "Hello" > hello.txt # Write "Hello"
echo "Hi there" > hello.txt
echo "How are you?" >> hello.txt
echo "I'm learning Bash scripting" >> hello.txt
cat hello.txt
```

```console{ lineNos=false }
Hi there
How are you?
I'm learning Bash scripting
```

https://www.tutorialspoint.com/unix/unix-directories.htm
https://www.tutorialspoint.com/unix/unix-file-management.htm