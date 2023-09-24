---
title: "File Permissions"
date: 2023-09-12T21:30:05Z
draft: false
---

Linux is known for its robust security features, including its permission system. As a Linux user, understanding how permissions work is essential for managing files and directories effectively. In this tutorial, we'll explore how you can view and set user, group, and other permissions on files and directories in the Ubuntu Linux distribution.
<!--more-->

## Overview
In Linux, each file and directory has three types of permissions: read (`r`), write (`w`), and execute (`x`). These permissions determine what actions can be performed on the file or directory by different users.

### Listing Permissions
To view the permissions of a file or directory, you can use the `ls` command with the `-l` flag:

```bash{ .show-prompt lineNos=false }
ls -l
```

The output will display a list of files and directories with their corresponding permission settings.

### Symbolic Notation
Permissions are represented by symbols: `r` for read, `w` for write, and `x` for execute. Each permission type can have three possible values: `-` indicates that permission is not granted; `r`, `w`, or `x` indicates that permission is granted.

The order of these symbols represents the different entities or groups: owner (user), group, and others:

```output{ lineNos=false }
-rwxrwxr-x 1 user group 1024 Jul 2 10:30 example_file.txt
```

In above listing, it is space separated listing with below information.

1. First set represents user, group and other user's permissions as `-rwxrwxr-x`.
2. Link count `1`.
3. Owner of the file or directory `user`.
4. Group of the file or directory `group`.
5. File size in bytes `1024`.
6. Last modified date time `Jul 2 10:30`.
7. Filename `example_file.txt`.

We are specifically focusing on the first part of the above listing, permissions.
In the permissions section:
- The first character (`-`) represents whether it's a file (`-`) or a directory (`d`). If the listing is a directory, it will have `d` else `-` for files. There can be few other options like `l` for linked files, `c` for device or `b` for block device.
- The next nine characters represent individual permissions. These are divided into  pairs of three characters listed below.
    1. The first three characters represent that the owner also referred to as 'user' has read (`r`), write (`w`), and execute (`x`) permissions.
    2. The next three characters are for group. The group has read (`r`), write (`w`), and execute (`x`) permissions.
    3. Others have read (`r`) and execute (`x`) permissions, but no write permission represented by `-`.

## Changing Permissions with `chmod`
The `chmod` command is used to change permissions on files and directories. It can be executed in two ways: by using either the octal notation or symbolic notation.

### Octal Notation
Octal notation represents each permission group as a numeric value from 0 to 7. These are actually octal representation of 8 digit binary numbers. These values follow a specific pattern:
- `0`: No permission
- `1`: Execute permission
- `2`: Write permission
- `3`: Write and execute permissions
- `4`: Read permission
- `5`: Read and execute permissions
- `6`: Read and write permissions
- `7`: Read, write, and execute permissions

To change the permissions of a file using octal notation, use the following command:

```bash{ .show-prompt .show-prompt-even lineNos=false }
touch example_file.txt
ls -l
-rw-r--r-- 1 root root 0 Sep 15 09:56 example_file.txt
chmod 644 example_file.txt 

ls -l
-rw-r--r-- 1 root root 0 Sep 15 09:56 example_file.txt
```

There is even easier notation if this seems confusion to you, but for that notation, we have to provide specific permissions one by one, whereas with Octal notation, we can provide multiple permissions with single command.

### Symbolic Notation
Symbolic notation allows you to specify who needs their permissions changed and what changes should be made.

To change the permissions of a file using symbolic notation, use the following command:

```bash{ .show-prompt .show-prompt-even lineNos=false }
chmod u+w example_file.txt 
ls -l
-rwxr--r-- 1 root root 0 Sep 15 09:56 example_file.txt
```

In this example:
- `u` refers to the user/owner.
- `+` denotes granting additional permissions.
- `w` indicates adding write permission.
- `-` revoke specific permission.

To revoke permissions, we can use `-` instead of `+` to revoke specific permissions or we can use octal notation with corresponding number for user, group or others.

```bash{ .show-prompt-odd lineNos=false }
chmod u-x example_file.txt

ls -l
-rw-r--r-- 1 root root 0 Sep 15 09:56 example_file.txt
chmod u-w example_file.txt

ls -l
-r--r--r-- 1 root root 0 Sep 15 09:56 example_file.txt
```

## Modify File Ownership with `chown`
Sometimes you may need to change the owner or group assigned to a file or directory. The `chown` command allows you to modify ownership in Ubuntu.

To change the owner of a file, use the following syntax:

```bash{ .show-prompt lineNos=false }
sudo chown new_owner example_file.txt 
```

Similarly, you can change the group ownership with below commands:

```bash{ .show-prompt lineNos=false }
sudo chown new_owner:new_group example_file.txt 
```

Understanding Linux permissions is crucial for maintaining security and managing files and directories effectively in Ubuntu. By viewing and setting permissions using the `ls`, `chmod`, and `chown` commands, you can control access to your files according to your needs.