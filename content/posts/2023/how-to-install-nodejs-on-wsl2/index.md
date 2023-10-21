---
title: "How to Install Nodejs on WSL2"
date: 2023-10-19T18:25:00-04:00
draft: false
categories: ["Development Environment"]
tags: ["Windows"]
languages: ["NodeJS"]
---

## Introduction
WSL2 (Windows Subsystem for Linux 2) provides a seamless way to run a Linux environment within Windows. This allows developers to utilize tools and frameworks like Node.js on their Windows machines without the need for a separate virtual machine or dual boot setup. 
<!--more-->
This also provides developers the most familiar terminal experience of UNIX environment on Windows. In this guide, we will walk you through the process of installing Node.js on WSL2.

## 1: Update and Upgrade
Before installing any software, it's always good practice to ensure your system is up-to-date. Open your WSL2 terminal and run the following commands:

```bash
sudo apt update
sudo apt upgrade
```

## 2. Install CURL

Install cURL to be able to download content from the internet using command-line tool or terminal. For installing this, we can use simple command on WSL2 (Ubuntu).

```bash {.show-prompt lineNos=false}
sudo apt-get install curl
```
## 3: Install Node Version Manager (NVM)
NVM is a handy tool that allows you to install and manage multiple versions of Node.js. Run the following command in your WSL2 terminal:

```bash{.show-prompt lineNos=false}
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
```

This will download and execute the installation script, which will add NVM configuration to your `.bashrc` or `.zshrc` file automatically.

Once the installation is complete, close and reopen your terminal or run `source ~/.bashrc` command for changes to take effect in the currently open terminal.

```bash{.show-prompt lineNos=false }
nvm --version          
0.39.5
```

## 4: Install Node.js using NVM
Now that NVM is installed, you can easily install any version of Node.js with a single command. To see the available versions of Node.js, run:

```bash{.show-prompt lineNos=false}
nvm ls-remote
```

Choose the desired version by noting down its version number (e.g., v14.17.6).

To install a specific version, run the following command:

```bash{.show-prompt lineNos=false}
nvm install <version>
```

Replace `<version>` with the actual version number you want to install. For example:

```bash{.show-prompt lineNos=false}
nvm install v20.8.1
```

You can verify if the installation was successful by running `node -v` and `npm -v` commands, which should display the installed Node.js and NPM versions respectively.

## 5: Set Specific Version of Node.js

If you want to use any of the installed versions of Node.js for specific project, you can use below.

```bash{.show-prompt lineNos=false}
nvm use v20.8.1
```

If you plan to use a specific version of Node.js as the default version in your projects, you can set them as default.

```bash{.show-prompt lineNos=false}
nvm alias default v20.8.1
```

## Conclusion

With this you have install the Node.js in your Windows subsystem for Linux. You also have node version manager which allows you to install multiple versions of Node.js in your system and use them depending on project dependencies on specific version of Node.js.
