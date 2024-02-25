---
title: "Ansible Configuration Files"
date: 2024-02-07T09:32:39-05:00
draft: false
---

Ansible is highly configurable and we can configure different parameters of Ansible using simple configuration file. These configuration options include parallelism, default log location, timeout, etc. This file controls the default behavior of Ansible.

<!--more-->
## Overview

When you install Ansible, it creates default configuration files at `/etc/ansible/ansible.cfg` location. This file is divided into several sections like default, inventory, privilege_escalation, etc. Each of these sections have default configurations for Ansible.

Ansible's configuration settings are mainly defined in INI-style configuration files. The primary configuration file is `ansible.cfg`, which can be present in three different locations, including the current working directory, user's home directory, or `/etc/ansible/` directory (in that order of precedence). This allows for flexibility and customization at various levels.

### Default Sections in ansible.cfg
The following are some default sections present in `ansible.cfg` file.

- **[defaults]**: This section holds general settings such as the location of inventory files and roles path.
- **[privilege_escalation]**: Specifies options for privilege escalation.
- **[ssh_connection]**: Defines parameters related to SSH connections.
- **[persistent_connection]**: Includes settings for persistent connections.

## Configuration Settings
You can customize a wide range of parameters within these configuration files, including:
- Control Persistence Behavior
- SSH Connection Options
- Custom Module Paths
- Threading Controls

## Resolving Configurations in Ansible

When it comes to resolving configurations, Ansible follows specific rules to determine the effective configuration settings.

1. **Precedence Hierarchy**: 
   Configuration settings are resolved based on a precedence hierarchy:
   - Command Line Options: Parameters specified directly through command line have the highest priority.
   - Playbook Keywords: Within playbooks, certain keywords can override global defaults.
   - Environment Variables: Environment variables exert influence over configurations.
   - Local Configuration File: Any local `ansible.cfg` file takes precedence over global configurations.
   - Global Configuration File: Finally, global configurations defined in `/etc/ansible/ansible.cfg`.

2. **Overriding Defaults**:
   For any particular setting, you can easily override its default value by specifying it explicitly in the higher-precedence level.

3. **Flexible Customization**:
   Using either environment variables or command line options allows for dynamic and flexible customization of configurations depending on various factors such as runtime environment or specific use cases.

By understanding these principles of configuration resolution in Ansible, you can effectively manage and tailor your automation workflows according to your requirements.


```shell
ansible-config list # lists all configuration with default values
ansible-config view # shows the current config file
ansible-config dump # shows the current settings
```