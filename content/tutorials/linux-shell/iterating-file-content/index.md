---
title: "Iterating File Content"
date: 2023-09-12T21:47:16Z
draft: false
---

There are several ways to process the contents of a file in bash scripts. You might want to perform actions such as reading and manipulating data line by line or extracting specific information. This tutorial explores different methods to iterate through file content in a Bash script.
<!--more-->

## 1: Using a while loop
One common approach is using a while loop along with the `read` command. Here's an example:

```bash
#!/bin/bash

while read -r line && [[ -n "$line" ]]; do
    # Process line
    echo "Processing: $line"
done < "filename.txt"
```

**Explanation:**

In this case, `while` loop reads each line from the file specified after the input redirection (`<`) symbol. The `read -r line` command assigns each line to the variable `line`. Inside the loop, we are simply printing the line content, but we can perform any other operations too.

## 2: Using a for loop

Another way to iterate through file content is by using a for loop with the `cat` command.

```bash
#!/bin/bash

for line in $(cat filename.txt); do
    # Process line
    echo "Processing: $line"
done
```

**Explanation:**

The `cat` command reads and outputs the entire contents of the file.  The for loop iterates over each item separated by whitespace (default behavior of `$(cat filename.txt)`).

## 3: Using IFS and readarray (or mapfile) 
If you want to read all lines of a file into an array, you can use IFS (Internal Field Separator) along with `readarray` or `mapfile` commands. 

```bash
#!/bin/bash

# Read the file into an array
readarray -t lines < "filename.txt"

for line in "${lines[@]}"; do
    # Process line
    echo "Processing: $line"
done
```

Here, The `readarray -t lines < "filename.txt"` reads the lines into an array named `lines`. The `for` loop iterates over each element of the array. 

If we have different delimiter than new line, we can use `IFS` to modify to that specific value.
