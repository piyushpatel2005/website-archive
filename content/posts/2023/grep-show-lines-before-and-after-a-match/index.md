---
title: "Grep Show Lines Before and After a Match"
date: 2023-08-24T07:38:45Z
draft: false
tags: ["Bash", "Shell"]
categories: ["DevOps"]
languages: ["Bash"]
---

Grep is one of the most powerful utility we have with UNIX Shell. This is used for various purposes like finding a text in a file or finding files containing certain text in a path. This comes very handy when scanning through large log files for specific information.
<!--more-->

## Overview

The description for `grep` says, it prints lines that matches certain pattern.

The normal `grep` usage looks like this.

```shell
grep 'something' /path/to/logfile
```

## Finding lines before a keyword

This will find all lines containing word `something` in the file `/path/to/logfile`. However, when scanning for errors in log files, it's usually important to be able to see what happened before the error or even in certain other conditions it may be important to see what were the lines before this line. In these situations, we can pass `-B` or `--before-context` flag to see given number of lines before certain keyword in a file.


Let's create sample server log file using numbers, so that we can see how these options work.

```shell
for i in {1..100}
do
    echo "This is line $i"
done > server.log
```

Verify the number of lines in the file.

```shell {.show-prompt lineNos=false }
cat server.log | wc -l # 100
```

If we check some content of the file,

```shell{.show-prompt  lineNos=false }
head -n 5 server.log
```

```output{ lineNos=false }
This is line 1
This is line 2
This is line 3
This is line 4
This is line 5
```

Now, let's suppose, I am looking for word `50` and I want to see 4 lines before this as well. I can run below.

```shell{ .show-prompt lineNos=false }
cat server.log | grep -B 4 50
```

The same thing can be achieved like this.

```shell{ .show-prompt lineNos=false }
grep -B 4 50 server.log
```

**Output:**

```output{ lineNos=false }
This is line 46
This is line 47
This is line 48
This is line 49
This is line 50
```

## Finding lines after a keyword

Similarly, to find lines after a certain keyword, we can use `-A` or `--after-context` flag with `grep` command.

Let's see 3 lines after line containing word `60`.

```shell{ .show-prompt lineNos=false }
grep -A 3 60 server.log
```

**Output:**

```output{ lineNos=false }
This is line 60
This is line 61
This is line 62
This is line 63
```

## Conclusion

I have used these commands quite often when digging through logs, especially those with distributed systems containing like millions of lines of code to find the root cause of an error. I hope it will be helpful to you in your search through logs.
