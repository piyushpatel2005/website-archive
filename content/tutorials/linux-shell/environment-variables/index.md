---
title: "Environment Variables"
date: 2023-09-12T21:27:39Z
draft: false
---

The Linux operating system is highly customizable, and one of its powerful features is the use of environment variables. Environment variables play a crucial role in configuring and controlling various aspects of the Linux system. In this lesson, we will explore what environment variables are and how they work in the Linux environment.
<!--more-->

## What are Environment Variables?
Environment variables are dynamic values stored within the operating system that can affect the behavior of processes and applications running on a Linux system. They provide a way to configure settings, define user preferences, and share information between different programs.

How are Environment Variables Defined?
In Linux, environment variables are represented as key-value pairs. The variable name acts as the key, while its associated value represents the data stored within it. These variables can be set at different scopes: globally for all users or specific to individual users.

## Common Environment Variables:
There are some very commonly used environment variables which you can find in any UNIX environment.

1. PATH
   - The PATH variable specifies which directories contain executable files.
   - When a command is entered in the terminal, the shell searches through these directories to find the corresponding executable file.

2. HOME
   - The HOME variable indicates the user's home directory.
   - This variable helps programs reference configuration files or store user-specific data.

3. SHELL
   - This stores the the path of the current user's shell. This can be `/bin/bash` or `/bin/zsh` or any other shell.

4. PS1
   - The PS1 variable controls the prompt display in the terminal.
   - By modifying this variable's value, users can customize their shell prompt appearance.

5. PWD
   - This prints the current working directory

6. UID
   - User's unique identifier - This is usually a numeric ID for the current user.

7. HOSTNAME
   - Device's hostname on the network

5. LD_LIBRARY_PATH
   - The `LD_LIBRARY_PATH` variable specifies additional paths for shared libraries.
   - It tells programs where to find required libraries during runtime.

## Working with Environment Variables:

We can view environment variables in at least two different ways. 
### Viewing Environment Variables
1. If we type `echo $` followed by two tabs, we can see all environment variables available. Two Tabs are used for auto-completion in bash session. If we write `cd` followed by two tabs, it will try to list the available directories it the current directory. 
2. We can use `printenv` or `env` command to dispaly the list of currently defined environment variables and their values.

### Setting and Updating Environment Variables

1. Setting Variables:
   - To set an environment variable, use the `export` command followed by the variable name and its value.
   - For example: `export ENV_VARIABLE=my_value`

2. Modifying Variables:
   - Use the `export` command again with a new value to modify an existing variable.
   - For example: `export ENV_VARIABLE=new_value`

To make variables persist across terminal sessions or reboots, define them in profile files like `~/.bashrc` or `~/.bash_profile`.
   
Understanding Linux environment variables is essential for system administrators, developers, and power users alike. These variables play a significant role in customizing and configuring various aspects of the Linux system. By mastering environment variables, you can wield greater control over your Linux environment and enhance your productivity.