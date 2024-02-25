---
title: "Ansible Variables"
date: 2024-02-10T12:15:51-05:00
draft: false
---

Variables are used to store data that varies with each host. Similar to other programming languages, they store information about hosts, user, etc. In this tutorial, I explain about what are variables and how they are used in Ansible.

<!--more-->
## What are Ansible Variables?

Variables are used to store certain set of information for hosts or users. We can define variables in playbook file using `vars` section and then defining variables as key-value pairs. Alternatively, we can have variables as a separate file which defines variables in the form of key-value pairs.

Ansible variables allow for more efficient and streamlined playbooks by representing values that can change. Instead of hardcoding every value needed within the playbook itself, you can utilize variables to allow certain values to be modified according to your needs.

## Declaring Ansible Variables?
Variables in Ansible work similarly to variables in any programming or scripting language. These can be used to loop through a set of given values, process them and generate some output.

You can define variables within a playbook, an included file, or even from the command line.

```yaml
- hosts: localhost
  vars:
    message: Welcome to Ansible Tutorials
  tasks:
    - name: Print a simple variable
      debug:
        msg: "{{ message }}"
```

In this playbook, the value of `message` is printed out using the `debug` module.

Just run this script using `ansible-playbook` command and you should see "Welcome to Ansible Tutorials" printed on your screen. This shows how you can define a variable and use it inside tasks.

## Variables Types

- String are sequences of charactesr. They are used to define inventory or passed as command line arguments
- Number variables can hold integer or float values. They are used in mathematical operations.
- Boolean variables are used to hold boolean values. Either `true` or `false`. They are used in conditional statements.
- List variables can hold ordered collection of values. The values in the list can be of any of the other data type. To access specific item from the list, we can use the index for that.
- Dictionary can have key-value pairs. The key and values can be of any data type.


```yaml
user:
  name: John 
  job_role: devops
```
You may access dictionary elements by calling their keys like so - `"{{ user.name }}"`

## Variable Scopes

A quick note: The location where we declare our variables affects their scope – global or local. When keeping things organized in real-world codebases, we don’t want a variable’s presence looming everywhere if it’s not necessary.

As students begin exploring more complicated concepts such as conditional statements and loops in Ansible they'll find having an already good understanding of how variables work is vital for creating dynamic scripts that cater to different scenarios without needing multiple redundant scripts that only differ slightly from each other.