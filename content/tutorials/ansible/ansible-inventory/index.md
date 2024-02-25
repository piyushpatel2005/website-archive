---
title: "Ansible Inventory"
date: 2024-02-08T07:29:40-05:00
draft: false
---

Every Ansible task runs against an inventory. An Inventory is a list of hosts that you wish to run an automation task on. In this tutorial, I will explain what inventory is and what are different inventory formats.

<!--more-->

## What is Ansible Inventory?

Ansible inventory is an important component while managing and orchestrating IT infrastructure. It serves as a source of truth for Ansible, enabling you to define the hosts and groups of hosts that Ansible can manage.

Ansible inventory is a file or set of files that contain information about the nodes or hosts that Ansible can manage. This includes IP addresses, FQDNs (Fully Qualified Domain Names), aliases, variables, and groupings of hosts. With this information, Ansible understands the infrastructure it needs to configure and the tasks it needs to accomplish. Ansible supports wide range of inventory formats which includes dynamic inventories. Dynamic inventories can populate themselves dynamically from an orchestration provider. Dynamic inventory plugins are written for most cloud providers as well as on-prem systems like Openstack and OpenShift.

**Inventory Structure**
An Ansible inventory file follows an INI format or YAML format. The inventory file is simply a list of servers that you want to manage. The INI format uses simple key-value pairs to define host entries and groups while YAML format uses a more structured approach with indentation.

In an INI-based file:
```INI
[webservers]
host1.example.com
host2.example.com

[dbservers]
db1.example.com
db2.example.com
```

In a YAML-based file:
```yaml
all:
  children:
    webservers:
      hosts:
        host1.example.com:

    dbservers:
      hosts:
        db1.example.com:
```

Each approach has its own advantages based on complexity and readability requirements. Choose a format that aligns with your team's preferences and your infrastructure's intricacy. In practice, when we want to structure small number of hosts, INI format is usually sufficient, but for large corporations, they might want to subdivide the hosts into department, groups, teams, etc. which is where YAML format provides lot more flexibility.

Ansible commands and playbooks can be run against an entire inventory (on all servers), one or more groups (for example, webservers or dbservers) or even single server. We can target the servers using group name in the command-line parameters. Ansible being an open source software has lots of modules to automate different tasks. As long as Ansible control node can communicate with the managed nodes in the inventory, you can automate any tasks.

**Setting Up Inventory**
The default location for the inventory file is at `/etc/ansible/hosts`. However, you can specify a different location using the `-i` option when running commands with ansible or by defining `ANSIBLE_HOSTS` environment variable.

To create a basic inventory file in INI format:

```INI
web1.server.com
web2.server.com
web3.server.com
```

Adding alias to servers using below syntax

```INI
web1 web1.server.com
web2 web2.server.com
web3 web3.server.com
db db.server.com
```

Adding additional inventory parameters. Note that when connecting with Windows system, we need to specify connection as `winrm`.

```INI
# Web Servers
web1 ansible_host=server1.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web2 ansible_host=server2.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web3 ansible_host=server3.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
db1 ansible_host=server4.company.com ansible_connection=winrm ansible_user=administrator ansible_password=Dbp@ss123!
```

## Grouping and Parent-child relationship

Grouping hosts using groups

```INI
# Web Servers
web1 ansible_host=server1.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web2 ansible_host=server2.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web3 ansible_host=server3.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!

# Database Servers
db1 ansible_host=server4.company.com ansible_connection=winrm ansible_user=administrator ansible_password=Password123!


[web_servers]
web1
web2
web3

[db_servers]
db1
```

Create new group from groups. Syntax looks like:

```INI
[parent_group:children]
group1
group2
```

```INI
# Web Servers
web1 ansible_host=server1.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web2 ansible_host=server2.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web3 ansible_host=server3.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!

# Database Servers
db1 ansible_host=server4.company.com ansible_connection=winrm ansible_user=administrator ansible_password=Password123!


[web_servers]
web1
web2
web3

[db_servers]
db1

[all_servers:children]
web_servers
db_servers
```

```INI
# Web Servers
web_node1 ansible_host=web01.xyz.com ansible_connection=winrm ansible_user=administrator ansible_password=Win$Pass
web_node2 ansible_host=web02.xyz.com ansible_connection=winrm ansible_user=administrator ansible_password=Win$Pass
web_node3 ansible_host=web03.xyz.com ansible_connection=winrm ansible_user=administrator ansible_password=Win$Pass

# DB Servers
sql_db1 ansible_host=sql01.xyz.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Lin$Pass
sql_db2 ansible_host=sql02.xyz.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Lin$Pass

[db_nodes]
sql_db1
sql_db2

[web_nodes]
web_node1
web_node2
web_node3

[boston_nodes]
sql_db1
web_node1

[dallas_nodes]
sql_db2
web_node2
web_node3

[us_nodes:children]
boston_nodes
dallas_nodes
```

```INI
[web]
host1.example.com ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/private.pem

[db]
db1.example.com ansible_user=centos ansible_ssh_private_key_file=~/.ssh/key.pem
```

Here we've defined two groups: 'web' and 'db', along with their respective hosts and additional connection options like SSH user and private key path.

If you prefer using YAML format for better organization and flexibility:
```yaml
all:
  children:
    web:
      hosts:
        host1.example.com: 
          ansible_user: ubuntu
          ansible_ssh_private_key_file: ~/.ssh/private.pem

    db:
      hosts: 
        db1.example.com: 
          ansible_user: centos 
          ansible_ssh_private_key_file: ~/.ssh/key.pem
```

Once your inventory file is set up, you can proceed with testing its connectivity using the ping module to ensure proper communication between the control node and managed nodes:

For INI-based inventory:

```bash
ansible all -i /path/to/inventory -m ping
```

For YAML-based inventory:

```bash
ansible all -i /path/to/inventory.yaml -m ping
```

**Grouping Hosts**
You can organize your hosts into arbitrary groups based on practical categorization such as role, environment(like production or staging), location or application.
It provides an organized approach when you have multiple servers belonging to different environments/application/services etc., in which they belong to through groupings.

For example:

```INI
[web]
host1.example.com

[db]
db1.example.com

[staging]
host2.staging-domain-example.net

[production]
host3.prod-domain-example.net

[databaseservers:dbservers] # Group Alias & Group Name separated by colon (:)
db4.servers.net # Hostname belongs to more than one group.
```

If you have multiple servers such as databaseservers & also app serves where these servers are common across Groups then creating an alias dbservers could be beneficial as it helps reduce duplication of list maintaining in both other categories namely databaseservers & appserver (or) webserver etc.,
Aliases also comes handy when saying that there are specific `dbservers` perform some role so such scenarios best suit this option.


After grouping servers under specified heading/group name now we specify same grouped server operations together as specified below:


```bash 
ansible-playbook - i /etc/hosts all --list-hosts | grep "webservers"
ansible-playbook - i /etc/hosts all --list-hosts | grep "databaseservers" # Reports dbs clustername if any created under dbs alias.
 ```