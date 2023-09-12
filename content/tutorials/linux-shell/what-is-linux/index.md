---
title: "Linux Intro"
date: 2023-09-09T02:45:06Z
draft: false
---

Linux is one of the most popular open source operating system. It is highly customizable and is very secure operating system. Most of the servers in the technology industry operating on one of the linux distributions.
<!--more-->

## Linux Distributions

Linux distributions are operating systems that are built on the Linux kernel. They provide a complete package of software and tools that make it easier for users to interact with the system. Each distribution is unique, offering different features, software packages, and user interfaces. Popular distributions include Ubuntu, Fedora, Debian, and CentOS.
- **Ubuntu** is known for its user-friendly interface and extensive community support. It is a great choice for beginners as it offers a wide range of pre-installed software and easy installation process.
- **Fedora** focuses on providing the latest versions of software packages and technologies. It is often used by developers due to its emphasis on cutting-edge technology.
- **Debian** is one of the oldest Linux distributions with a strong focus on stability and security. It has a vast repository of software packages and is highly customizable.
- **CentOS** is derived from Red Hat Enterprise Linux (RHEL) and shares many characteristics such as stability, security features, and long-term support.
- There are many other Linux distributions available which are used for various different purposes.

## Linux Kernel

Linux Kernel is the core of the OS. It is the main process that talks to the underlying hardware. When user sends command to shell, it sends it to kernel and communicates the same to hardware. Kennel parameters allows the hardware in certain manner.

`ping <ip_address>` will give replies from the ip address when system is available on the network. We can also disable this by changing kernel parameters. We can set kernel parameters to not respond to USB drives. So, everything is customizable on Linux.

In Linux/UNIX operating systems, there is a program called Terminal or Console which is used to interact with the system. In these operating systems, we interact with shell using these Terminal or Console applications. These are command line applications which accept user input in the form of some text input and responds depending on that command. User can interact with Shell and shell interacts with Kernel. Shell is an interpreter for user commands.

## Package Managers

Linux package managers are an essential component of any Linux distribution, as they enable users to easily install, update, and remove software packages. They handle dependencies, ensuring that all required libraries and files are installed correctly. Additionally, package managers help maintain system integrity by handling versioning conflicts and preventing the installation of incompatible software.

There are several package managers available for Linux distros, each with its own unique features and characteristics. One popular package manager is APT (Advanced Package Tool), primarily used in Debian-based distributions like Ubuntu. APT provides a simple command-line interface that allows users to search for and install packages from repositories using `apt` command.

Another widely used package manager is YUM (Yellowdog Updater Modified), commonly found in Red Hat-based systems such as Fedora and CentOS. YUM offers similar functionality to APT but focuses on providing high-performance package management with robust dependency resolution capabilities. The packages and softwares can be installed using `yum` command.

## Everything is File

In the Linux, everything is file. Not only regular files like text documents or images are represented as files, but also directories, devices, and system resources such as sockets or pipes. This concept of treating everything as a file allows for a consistent and uniform approach to interacting with different types of data and resources within the operating system. The root of the file system starts at `/`. This is similar in concept to Drive in Windows OS denotated by `C:\`. In Linux systems, traditional Windows folders are called as directories. They are used to organize files and directories in the form of trees.

A pathname describes the location of a file or directory in the file system hierarchy. There are two types of pathnames: absolute and relative. Absolute pathnames start from the root directory (`/`) and provide an exact path to a specific location. Relative pathnames start from the current working directory and provide a path relative to that location. For example, if my current directory has two subdirectories `dir1` and `dir2`, the relative path to them will be `./dir1` and `./dir2` or simply `dir1` and `dir2` respectively. 