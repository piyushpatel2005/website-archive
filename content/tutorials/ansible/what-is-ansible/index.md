---
title: "What Is Ansible"
date: 2024-02-07T09:13:49-05:00
draft: false
---

Ansible is an open-source automation tool that facilitates the orchestration and configuration management of computer systems. It allows users to automate tasks such as application deployment, configuration management, and cloud provisioning.
<!--more-->

## Overview

In the past, IT administrators used to write complex scripts for automating certain tasks on nodes. Using this approach, it required coding skills with complex logic and was very time consuming process. Also, these scripts needed to be maintained overtime. Ansible removes these complexities and provides a very simple approach to defining configurations and automations using playbooks. Ansible can be used to manage single host or even thousands of remote hosts from single control machine.

Ansible is written in Python and can run on a wide range of systems. For Windows, there is no native Ansible build. Due to this, for running Ansible on Windows, you may have to install WSL (Windows Subsystem for Linux). Ansible is divided into two separate packages. These are **ansible-core** which contains just `ansible-playbook` command with some built-in functionality essential to playbooks and roles. Another package is called **Ansible community package** which follows semantic versioning scheme. Each release of this community package depends on a specific version of the ansible-core package.

## Features of Ansible

1. **Simple and Agentless**: Ansible does not require any agents to be installed on remote systems, making it easy to set up and use. It utilizes SSH for communication.
2. **Playbooks**: Users can define their infrastructure as code using simple YAML files called playbooks. YAML is human-readable data serialization language used to define configurations.
3. **Idempotent**: Ansible ensures that the system will be in a desired state regardless of its current state, reducing potential errors caused by repeated execution. A specific operation can be executed multiple times without altering the desired final state if the system is already in that state.
4. **Easy To Learn**: The learning curve for Ansible is relatively low due to its simple syntax and declarative nature.
4. **Extensible**: It supports a wide range of modules to manage system resources, allowing for seamless integration with various technologies.

## Usage of Ansible

Ansible is commonly used for:
- **Provisioning**: Creating new servers or instances across various cloud providers.
- **Configuration Management**: Ensuring consistent configurations across all servers.
- **Application Deployment**: Streamlining the deployment process for applications.
- **Orchestration**: Coordinating multiple systems as part of a complex workflow.

## How Ansible Works?

The fundamental architecture of Ansible consists of:
- The Control Node: This is where Ansible is installed and from where all tasks are orchestrated. The Ansible commands are executed from this node.
- Invetory: These are list of managed nodes that are logically organized. These are created on the control node and organized into groups such as "web servers", "db servers", etc. This way we can perform certain configurations on a group of machines and not all of them.
- Managed Nodes: These are the remote systems that are managed by the control node through SSH connections.
  
### Communication Method
Ansible communicates with managed nodes over SSH using Python. It pushes small programs called "Ansible modules" to these nodes and executes them remotely, thereby facilitating seamless and secure communication without necessitating any additional custom security infrastructure.

### Agentless Design
Unlike some other configuration management tools, such as Puppet or Chef, Ansible operates without agent software on managed nodes. By leveraging existing SSH infrastructure and executing commands through SSH directly onto remote machines. This streamlined approach eliminates the need for agents running on each managed system.

By incorporating these components into its design, such as its agentless nature, straightforward communication methodology via SSH, and comprehensive library of modules, Ansible has established itself as a robust and versatile automation tool, empowering organizations to achieve efficiency in managing their IT infrastructures while significantly reducing complexity and repetitive manual tasks.

## Installing Ansible

Ansible can be installed using native package managers on Linux distributions such as `yum`, `dnf` or `apt`. We could also install Ansible using `pip`. To install Ansible using `pip`, follow these steps.

```shell
python -V # verify python installation
python -m pip -V
# install ansible
python -m pip install --user ansible
ansible --version
```

This will install ansible in `/home/$USER/.local/bin/` directory. Include this in the `PATH` variable in order to run `ansible-playbook` command from anywhere.
If you want to install any other version of ansible, you can specify the version using below command.

```shell
python -m pip install --user ansible==6.2.0
# upgrade ansible
python -m pip install --user --upgrade ansible
```