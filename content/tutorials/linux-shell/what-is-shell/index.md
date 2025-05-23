---
title: "What Is Shell"
date: 2023-09-09T03:40:20Z
draft: false
---

A shell is basically a command language interpreter which translates commands passed by a user into kernel actions. These commands can be used to automate several tasks using shell scripts.
<!--more-->
## Overview

The shell is named so because it is the outermost layer around the OS kernel. It keeps user-system interaction by getting user input from command line interface and then handling output from the underlying operating system.

> In Windows operating system, we have command prompt which is different from Bash or Shell. This tutorial is targeted at UNIX style shell which are present in all Linux distributions and MacOS.

We can interact with shell to perform following operations and many more. Almost every task can be performed from shell.

- Reading files or writing files
- Reading emails
- Creating directories and files
- Making copies of a file or managing permissions of a file

## Types of Shell
In UNIX, we have different types of shell. Most of the commands will be same across all these shell. This tutorial has been developed with Bash shell.

1. Bourne Shell (sh): This is the original Unix/Linux shell and is the default shell on many Linux distributions.
2. C shell (csh): This is an alternative to Bourne shell and is working as a default for some operating systems.
3. Korn shell (ksh): This is an enhanced version of the Bourne shell and is backward-compatible with it. By default this is also included in some UNIX distributions.
4. GNU Bourne-Again shell (bash): This is a free software Unix shell that is backward-compatible with the Bourne shell and includes many features of the C shell. This shell is also the most popular one among the types of shell.

## Why learn Shell Scripting

1. With Shell scripting, a developer can automate many of their tasks. This is largely used in Cloud computing automation and other daily automation tasks at Server level. For example, cloud computing instance can be initialized with custom tools and software using initialization scripts.
2. Shell scripts are set of Shell commands which can also be used interactively.
3. Shell scripting is also relatively faster compared to other options for automation.

## Use cases for Shell Scripting

Shell scripting can be used for following tasks.

- Find active processes currently running in the background.
- Create users and groups and provide permissions
- Find available and free memory in hard-disk.
- Creating and installing application packages
- Find out all users who are logged in
- Send emails
- Copy files to and from remote server

The common terminal session looks like this.

```shell{ lineNos=false }
christian@server01:~$
```

## Find out Default Shell

To find out which default shell is setup in your system, we can use following.

```shell{ lineNos=false }
ps
    PID TTY          TIME CMD
    390 pts/3    00:00:00 bash
    839 pts/3    00:00:00 ps
```

Here, the output in second line shows `bash` in `CMD` column.

Alternatively, we can use `SHELL` environment variable to check the default shell in terminal.

```shell { lineNos=false }
echo $SHELL
/bin/bash
```

If you have any other shell as default shell and you wish to change it, then we can use `chsh` command to change login shell. For example, we have `sh` shell.

```bash{ lineNos=false }
$ ls /bin/sh
$ chsh -s /bin/sh
```

## Getting Help

1. In `bash`, we can get help for a specific command using their manual pages. These are the official documentations for the command. We can view those using `man <command>`. For example, to view information about the command `chsh`, we can use below command.

```shell{ lineNos=false }
man chsh
```

From the documentation, we can read that `-s` is  to specify name of the user's new login shell.

2. Each command will have help pages for that specific command which we can access using `--help` option. For example, to read more about `ls` command which is used to list files and directories, we can use `ls --help` and it will show small help page on this command.
