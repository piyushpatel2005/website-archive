---
title: "Bash Basic Commands"
date: 2023-09-10T02:45:06Z
draft: false
---

Bash commands are used to interact with the system. Whether we want to write a file, copy a file or creating new documents, etc can be done using Terminal with Bash. In this lesson, we look at basic Bash commands.

<!--more-->

## General Syntax 
The general syntax for bash commands look like below. Terminal and console are the terms used interchangeably.

```bash{ lineNos=false }
command [-options] [arguments]
```

Here, `command` is the command name that we want to execute. Each command may have separate options. When we add specific option, the behavior of the command changes. Some commands also take arguments. Options are arguments are optional components of bash commands. Let's see a simple example of `ls` command. This command outputs the listing of a directory. Again, we can read the documentation of the command using `man ls` command on the terminal. The manual pages are divided into sections. These sections contain information about Exit status, Return Value, Description, Configuration, Synopsis, etc.

Below command shows an example of options with arguments. Here is `-l` option shows directory listing in long format. Argument `/home/admin/Downloads/` makes sure that we are getting directory list for this specific directory in the system.

```bash{ .show-prompt lineNos=false }
ls -l /home/admin/Downloads/
```

## Common Bash Commands

- `ls`: List files and directories
- `mkdir`: Make directory
- `pwd`: Print working directory
- `cp`: Copy file or directory
- `mv`: Move file or directory
- `touch`: Create an empty file passed as argument
- `head`: Print first few lines of a file
- `cat`: Print contents of a file on console
- `tail`: Print last few lines of a file on console.

Let's experiment with these commands on the terminal.

### `mkdir`: Make Directory
The `mkdir` command is used to create new directories.
- Syntax: `mkdir [options] [directory]`
- Usage:
    - Create a new directory in the current working directory: `mkdir new_directory`
    - Create nested directories (if they don't exist): `mkdir -p path/to/new_directory`

### `ls`: List Files
The `ls` command is used to list files and directories in the current working directory or a specified directory.
- Syntax: ls [options] [directory]
- Usage:
    - List files and directories in the current working directory: `ls`
    - List files and directories in a specific directory: `ls /path/to/directory`
    - List files with detailed information (including permissions, size, modification date): `ls -l`
    - List all files (including hidden files): `ls -a`
    - List all files and directories of all child directories: `ls -R`

### `cd`: Change Directory
The `cd` command is used to change the current working directory. When we open the terminal for the first time, by default, it starts in the user home directory. This is usually under the path `/home/<username>` location in the system. This is also denoted by `~`.
- Syntax: `cd [directory]`
- Usage:
    - Change to a specific directory: `cd /path/to/directory`
    - Change to the parent directory: `cd ..`
    - Change to the home directory: `cd ~` or just `cd`

### `pwd`: Print Working Directory
It is used to display the absolute path of the current working directory in the Linux shell.
- Syntax: `pwd [options]`
- Usage: 
    - Display full path of the current working directory: `pwd`

### `touch`: Create empty files
The `touch` command is used to create an empty file or update the timestamp of an existing file in the Linux shell.
- Syntax: `touch [options] filename`
- Usage:
    - Create an empty file: `touch filename.txt`
    - Update access and modification time for existing file: `touch existing_file.txt`
    - Create multiple files with single command: `touch file{1..5}.txt`

### `rm`: Remove
The `rm` command is used to remove specified files or directories.
- Syntax: rm [options] [file/directory]
- Usage:
    - Remove a file: `rm file.txt`

{{< admonition "warning" >}}
Be cautious when using this command as it permanently deletes files.
{{</ admonition >}}

### `rmdir`: Remove directory
The `rmdir` command is used to remove empty directories in the Linux shell.
- Syntax: `rmdir [options] directory_name`
- Usage:
    - Remove empty directory: `rmdir dirname`
    
{{< admonition "tip" >}}
`rmdir` command removes only empty directory. If directory contains files or other directories, to remove all sub-directories, we have to use `rm -r` to recursively remove all contents within the directory.
{{</ admonition >}}

### `mv` Move or Rename
The `mv` command is used to move or rename files. This command cane be used to rename by moving the file to a file with different name.
1. Move Command:
    - Syntax for moving a file/directory: `mv [options] source destination`
    - Usage:
        - Move a file to another directory: mv file.txt /path/to/destination
        - Move multiple files to a directory: mv file1.txt file2.txt /path/to/destination
2. Rename Command:
    - Syntax for renaming a file/directory: `mv [options] old_name new_name`
    - Usage:
        - Rename a file: `mv old_file.txt new_file.txt`
        - Rename a directory: `mv old_directory new_directory`

These are just some of the basic commands used in Linux shell scripting. There are many more commands and options available. It's important to refer to the documentation using `man` command or use the `--help` option for each command to get details about their usage and options.