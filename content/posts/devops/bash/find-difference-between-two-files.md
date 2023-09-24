---
title: "Find difference between two Files"
date: 2023-09-08T19:18:20Z
draft: false
tags: ["Bash", "Shell"]
categories: ["DevOps"]
---

Often times, we want to find the difference between two files to compare the output of something. This is very useful in debugging issues when we want to check for what's the difference. We can use different Bash tools for this. That is what we are going to discuss in this post.
<!--more-->

## Overview

First we can check if there is a difference between two files by checking their line counts.

```bash{ .show-prompt-all lineNos=false }
cat file1.txt | wc -l
cat file2.txt | wc -l
```

Let's say we have two files with below contents.

```shell { .show-prompt lineNos=false }
cat file1.txt 
1
3
4
2
5
4
```

```shell { .show-prompt lineNos=false }
cat file2.txt 
5
3
4
0
```

## Diff: Compare line by line

First option is to check GNU `diff` command. This command compares files line by line. When we run `diff file1.txt file2.txt` we get below output. The `diff` command outputs lines unique to `file1.txt` with `>`. Each line starting with `>` will be the line which is available in only `file1.txt` but not present in `file2.txt` file. Again this checks line by line, so if both files do not have same content on same line number, that will be output.

```shell{ .show-prompt lineNos=false }
diff file2.txt file1.txt | grep '^>'
> 1
> 2
> 5
> 4
```

From below table, the line 1, 4, 5, 6 do not match with corresponding lines from `file2.txt`. So, those are output as a result of the above.

| file1.txt | file2.txt |
|:---------:|:---------:|
| 1 | 5 |
| 3 | 3 |
| 4 | 4 | 
| 2 | 0 |
| 5 | | 
| 4 | |

If we want the lines from `file2.txt` which are not matching with `file1.txt`, then we can check for lines starting with `<`

```shell{ .show-prompt lineNos=false }
diff file2.txt file1.txt | grep '^<'
< 5
< 0
```

To get the actual content of those lines, we can use `awk` or `cut` command.

```shell{ .show-prompt lineNos=false }
diff file2.txt file1.txt | grep '^<' | awk '{print $2}'
5 
0
```

```shell{ .show-prompt lineNos=false }
diff file2.txt file1.txt | grep '^<' | cut -d' ' -f 2
5
0
```

### Find different lines regardless of line number

If we want to get only unique lines which do not match between two files, then we have to first sort the files and then compare.

```shell{ .show-prompt lineNos=false }
diff <(sort file1.txt) <(sort file2.txt) | grep "^<" | awk '{print $2}'
1
2
4
```

## Comm: Compare Sorted files

This command line utility `comm` can be used to compare two sorted files line by line. The important point with this tool is that the files have to be sorted in order. The general syntax for usage of this looks like below from `man` pages.

- `-1`: suppress column 1 (lines unique to FILE1)
- `-2`: suppress column 2 (lines unique to FILE2)
- `-3`: suppress column 3 (lines that appear in both files)

So, if we want to find lines which are present in `file1.txt` but not in `file2.txt` then we can use options `3` (remove common lines) and `2` (remove lines present in file2). Unlike `diff` command, this command only gives the content of those lines which didn't match.

```shell{ .show-prompt lineNos=false }
comm -23 <(sort file1.txt) <(sort file2.txt)
1
2
4
```

Similarly, to find lines present in only `file2.txt`, use below command. Here, we kept the sequence of files same but only changed the option from `2` to `1` to remove lines which are present in `file1.txt`.

```shell{ .show-prompt lineNos=false }
comm -13 <(sort file1.txt) <(sort file2.txt)
0
```

## Conclusion

These options are quite useful in daily life of Devops Engineer. I have used these commands quite often when I have to validate some data issues and I have to check difference between two files in large files.