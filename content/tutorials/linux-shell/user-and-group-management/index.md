---
title: "User and Group Management"
date: 2023-09-12T21:29:49Z
draft: false
---

In Linux, user and group management allows administrators to control access, assign permissions, and ensure proper security measures are in place. This tutorial will cover the basics of managing users and groups in the Linux distribution, specifically Ubuntu.
<!--more-->

Please note that these commands need root level permissions with `sudo` or you can login as `root` user and run these commands without `sudo` prefix. All example commands are executed after logging in as a root user using `sudo su -`. Therefore, they do not have `sudo` prefix with them.

## User Management

This section explains how we can create user and manage their information and password. 

### 1. Creating Users

To create a new user, use the `adduser` command followed by the desired username like below:

```bash{ lineNos=false }
sudo adduser <username>
```

```bash { .show-prompt lineNos=false }
adduser user1
Adding user `user1' ...
Adding new group `user1' (1000) ...
Adding new user `user1' (1000) with group `user1' ...
Creating home directory `/home/user1' ...
Copying files from `/etc/skel' ...
New password: 
Retype new password: 
passwd: password updated successfully
Changing the user information for user1
Enter the new value, or press ENTER for the default
        Full Name []: User1
        Room Number []: 1
        Work Phone []: 
        Home Phone []: 
        Other []: 
Is the information correct? [Y/n] 
```

This command prompts you to enter additional information like password, full name, contact number, etc.

### 2. Managing User Passwords

To set a password for a user or change an existing user password, use the `passwd` command:

```bash{ lineNos=false }
sudo passwd <username>
```

As a root user, this command will allow you to change the user password without knowing user's existing password. You'll be only asked to enter a new password for that user. 

```shell{ .show-prompt lineNos=false }
passwd user1
New password: 
Retype new password: 
passwd: password updated successfully
```

Alternatively, if you're already logged in as a user and want to change your user's password, you can simply type `passwd` command and you will be prompted for existing password and new password. Once, everything is verified, your password will be changed to new password.

To login as this new user, you can use, `su user1`. This will change the prompt to `user1@server01`

### 3. Modify User Information

To modify user information such as their username or contact details, use the `usermod` command:

```bash{ lineNos=false }
sudo usermod -l <new_username> <old_username>
```
Replace `<new_username>` with the desired new username and `<old_username>` with the current username.

**Example:**

```bash{ .show-prompt .show-prompt-even lineNos=false }
usermod -l user2 user1
su user1
su: user user1 does not exist or the user entry does not contain all the required fields
su user2
su: user user2 does not exist or the user entry does not contain all the required fields
```

### 4. Deleting Users

To delete a user account, use the `userdel` command:

```bash{ lineNos=false }
sudo userdel <username>
```

{{< admonition "warning" >}}
Be cautious as this action permanently deletes the user's files and directories.
{{</ admonition >}}

**Example:**

```bash{ .show-prompt-all lineNos=false }
userdel user2
su user2 # user user2 does not exist
```

## Group Management

In Linux, usually user permissions are managed using groups. This way if we want multiple users to be assigned the same kind of permissions, those can easily be managed by assigning a group to the user. If a person leaves organization, then only remove the user from the corresponding group to revoke their permissions.

### 1. Creating Groups

To create a group, use the `groupadd` command followed by the desired group name:

```bash{ lineNos=false }
sudo groupadd <group_name>
```
This creates a new group with the specified name.

**Example:**

```bash{ .show-prompt-all lineNos=false }
groupadd devops # add devops group
adduser demouser # add demouser
```

### 2. Managing Group Memberships

To add or remove users from a group, use the `usermod` command:

- Add a user to a group:
```bash{ lineNos=false }
sudo usermod -aG <group_name> <username>
```

We can check currently assigned groups to a user using `id` command.

```shell{ .show-prompt lineNos=false }
id demouser
uid=1000(demouser) gid=1002(demouser) groups=1002(demouser)
```

**Example:**

```bash{ .show-prompt .show-prompt-even lineNos=false }
usermod -aG devops demouser
id demouser
uid=1000(demouser) gid=1002(demouser) groups=1002(demouser),1001(devops)
```

- Remove a user from a group:
```bash{ lineNos=false }
sudo deluser <username> <group_name>
```

```bash{ .show-prompt-odd lineNos=false }
deluser demouser devops
Removing user `demouser' from group `devops' ...
id demouser
uid=1000(demouser) gid=1002(demouser) groups=1002(demouser)
```


### 3. Assigning Permissions with File Ownership & Group Ownership

To assign file ownership to a user or group, use the `chown` command:

```bash{ .show-prompt lineNos=false }
sudo chown <owner>:<group> <file_path>
```

Replace `<owner>` with the username or `<group>` with the group name, and `<file_path>` with the path to the file.

This tutorial covers the basics of user and group management in Linux using Ubuntu distribution.