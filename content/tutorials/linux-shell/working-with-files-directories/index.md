---
title: "Working With Files Directories"
date: 2023-09-12T03:03:53Z
draft: false
---

With Linux, it's very easy to navigate directories and files using just few commands. In fact, it can be even faster than normal GUI desktop. Usually, terminal operations are lot faster than GUI based operations. This lesson shows how we can read the contents of the file and how to navigate around the directories in Linux.

<!--more-->

In this lesson, we will explore some of the command we learned in the previous lesson.

```bash{ .show-prompt lineNos=false }
pwd
```

## Home Directory

By default, we are in user's home directory which looks something like below. Everytime we open Terminal session in UNIX machine, it opens in this home directory. In home directory, the current user will have all permission. We will talk about permissions in one of the later lessons.

```console{ lineNos=false }
/home/username
```

## Root Directory Structure

We can navigate to root directory using `cd /`. Here, we see all system level directories. Type `ls` to see directories available here. Below are some of the common directories in root directory of Linux system. Depending on operating system some of these may not be present.

- `/bin` (Binaries): This directory contains essential binary executables (commands) required for basic system operations. Common commands like `ls`, `cp`, `mv`, `rm` are stored here.
- `/boot`: The `/boot` directory contains files related to the boot process of the system. Bootloader configuration files, kernel images, and initial RAM disk files reside here.
- `/dev` (Device): This directory holds special device files that represent physical or virtual devices attached to the system. Devices such as hard drives (e.g., `/dev/sda`), CD-ROMs (e.g., `/dev/cdrom`), and USB devices can be accessed via these device files.
- `/etc`: This directory stores system-wide configuration files used by various applications and services. Network settings, startup scripts, user account details, etc., can be found in this directory.
- `/home`: Each user on a Linux system typically has their own home directory located under this root directory. User-specific files such as documents, downloads, configurations, and personal settings can be found here.
- `/lib` (Library): Essential shared libraries required by binaries under the `/bin` and `/sbin` directories are stored here. These libraries provide functions used by various applications at runtime.
- `/media`: This directory is used as a mounting point for removable media devices (e.g., USB drives, CD/DVDs). When a removable media device is connected to the system, it gets automatically mounted under this directory.
- `/opt` (Optional Packages): It is commonly used to store additional software packages that are not part of the core Linux distribution.
- `/proc` (Process Information): This directory provides a virtual file system that contains information about running processes and system configuration. Information about CPU, memory, hardware, and other kernel-related details can be accessed through files within this directory.
- `/root`: The root user's home directory is located here (`/root`) which may have important configuration files specific to the root user.
- `/sbin` (System Binaries): It contains essential system binaries required for administrative tasks like `mount`, `umount`, `reboot` are stored in this directory accessible only by administrators.
- `/tmp` (Temporary): It is used for temporary storage of files and directories. The contents of this directory may not persist across reboots.
- `/usr` (Unix System Resources): This holds non-essential utilities, libraries, documentation, and resources for typical users. It further subdivides into subdirectories like `/usr/bin` (user binaries), `/usr/lib` (user libraries), and so on.
- `/var` (Variable Data): This contains variable data such as `logs`, spool files, cache data, etc. It contains information that might change frequently during system operation.

To navigate back to previous directory, we can use `cd -`. This will take us to previous location, in this case the home directory.

## Absolute and Relative Path

Now that we are in the home directory the user, we can create new files and directories in two ways. If we write pathnames without prefix of `/` then that will be relative to our current path. That is also known as **relative path** in Linux.

```shell{ .show-prompt lineNos=false }
mkdir something
```

Above command will make `something` directory in the current path,. That is, it will create path `/home/username/something`. Similarly, if we were inside `/home/username/folder` and executed this command, it will create new directory relative to that location. Please, note that relative path can be specified without any prefix, but sometimes, you may notice relative path for scripts specified using `./` prefix. In Linux `.` refers to current directory. So, you can also type commands like `ls .` or `cd .`.

On the other hand, if we want to create the same directory using Absolute path, we would have to specify full path like below.

```shell{ .show-prompt lineNos=false}
mkdir /home/username/something
```

This is called **absolute path**.

## Practical Demo

Ok, let's create our directory and try to create directories and files inside it.

```bash{ .show-prompt-all lineNos=false }
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

To display only folders
Let's remove them and recreated a nested directory structure where we will create our first file.

```bash{ .show-prompt-all lineNos=false }
rmdir folder{1..3} # remove multiple empty directories
ls # No directories or files
```

```shell{ .show-prompt lineNos=false }
mkdir dir1/inside_dir1 # produces error because dir1 does not exist
mkdir: cannot create directory ‘dir1/inside_dir1’: No such file or directory
```

Above command fails because when shell tries to create child directory `inside_dir1`, it did not find the parent directory. By default, `mkdir` assumes that the parent directory exists. If we want to create parent directory if it does not exist, then we have to use `-p` option with this command.

```bash{ .show-prompt-all lineNos=false }
mkdir -p dir1/inside_dir1 # works fine because -p can create path if not exists
cd dir1/inside_dir1/
touch hello.txt # create 'hello.txt' file
echo "Hello" # prints Hello on terminal
```

To navigate back to `bash-session`, we can type `cd ..` which brings us to `dir1/` and then again `cd ..` which brings us to `bash-session` directory. Alternatively, we can type `cd ../../` which will take us two steps up.

To recursively list files and directories in current directory, we can use `-R` option with `ls` command.

```shell{ .show-prompt lineNos=false }
ls -R
```

- We can find all files or directories that start with keyword `my` using `ls my*`.
- To find items ending with numbers `2` and `3`, we can use something like `ls dir[23]`

```bash{ .show-prompt-all lineNos=false }
mkdir dir{2..5}
ls dir[23]
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


Let's say we have a file `hello.txt` with below content in it.
```console{ lineNos=false }
line 1
line 2
line 3
line 4
line 5
line 6
line 7
```

Now, to read the contents of this file, we can use below commands. Please, note that in this small file, we have only 7 lines, so `head` command by default will show all 7 lines, but if the file was larger than 10 lines, it would display only first 10 lines.

```bash{ .show-prompt-all lineNos=false }
cat hello.txt # displays full content of the file
head hello.txt # shows 10 lines, in this case, full file
head -n 5 hello.txt # shows first 5 lines
tail hello.txt # shows last 10 lines
tail -n 3 hello.txt # shows last 3 lines.
```