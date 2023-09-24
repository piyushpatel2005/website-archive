---
title: "Background Processes"
date: 2023-09-12T21:52:08Z
draft: false
---

Background processes play a vital role in optimizing system resources and improving productivity. Learning how to run processes in the background can help you efficiently manage tasks and make your workflow more seamless.
<!--more-->

## Overview
When executing commands or running scripts in a terminal session, each process has its own execution flow. A foreground process takes control of the terminal until it completes, while a background process runs independently without blocking the current session.

### Benefits of Running Processes in Background:
Running processes in the background offers several advantages.
1. Uninterrupted Workflow: You can continue working on other tasks while long-running programs execute silently.
2. Resource Optimization: Background processes consume fewer system resources by avoiding unnecessary blocking.
3. Automating Tasks: By executing scripts or commands as background processes, you can schedule them at specific times or intervals.

## Running Processes in Background:

### 1: Using '&' symbol
The easiest way to run a command or script as a background process is to append an `&` symbol at the end of the command. 

```bash{ .show-prompt lineNos=false }
./myscript.sh &
```

### 2: Ctrl + Z & 'bg' Command
Another approach is to pause a foreground process by pressing `Ctrl + Z` and then resume it as a background task using the `bg` command.

1. Start a foreground task: `./script.sh`
2. Hit 'Ctrl + Z' to pause it.
3. Run `bg` command to restart it as a background process.

To demonstrate this, below is the script for validation. This script prints messages and in between it sleeps for 1 minute. So, we have to check below steps within minute of starting it.

```bash
#!/bin/bash
echo "Starting"
sleep 1m
echo "Finished"
```

Start script using `./script.sh`. Hit `Ctrl + Z` to pause it. Type `bg` to restart in background.
At this point, the script is running in the background. You can check it running using `ps -ef | grep script.sh` command. After about a minute, you will see "Finished" message on the terminal along with message like below.

```output { lineNos=false }
[1]+  Done                    ./script.sh
```

## Monitoring Background Processes:

To view all active background processes at any time, use the `jobs` command.

Additionally, you can bring a background process to the foreground using the `fg` command, allowing you to interact with it again.

- `jobs` - Lists all active background processes.
- `fg <job>` - Brings a specific background process to the foreground.
- `bg <job>` - Resumes a paused process in the background.

Alternatively, we can use `ps -ef` to check running processes and `grep` for specific process that we want to monitor.
