---
title: "Regular Expressions With Grep"
date: 2023-09-12T21:33:42Z
draft: false
---

Regular expressions are powerful tools for pattern matching and text manipulation. In the Linux world, two widely used commands for leveraging regular expressions are `grep` and `egrep`. This tutorial aims to provide a comprehensive guide on how to effectively use regular expressions with both `grep` and `egrep` commands in Linux.
<!--more-->

## What are Regular Expressions?
Regular expressions, also known as regex or pattern matching, is a sequence of characters that forms a search pattern. It allows you to match, search, and manipulate strings based on specific patterns. These patterns usually include various symbols from the keyboard.

## Installing Grep and eGrep
Before we begin, let's make sure we have the `grep` and `egrep` commands installed on our Ubuntu distribution. Most of the times, `grep` will come installed with the OS.

To install `grep`, open your terminal and run the following command:

```bash{ lineNos=false }
sudo apt-get install grep
```

To install `egrep`, open your terminal and run the following command:

```bash{ lineNos=false }
sudo apt-get install grep
```

## Basic Usage of Grep
The `grep` command is used to search for patterns within files. Here's an example of how to use `grep`:

```bash{ lineNos=false }
grep "pattern" file.txt
```

In its simplest form, you can use regular expressions to match a specific pattern within a file. We have a file `names.txt` which contains below lines.

```output{ lineNos=false }
Andrew
Joseph
Jenny
Zoe
Jennifer
Alex
Alexandra
```

For example, let's say we want to search for the word "Alex" in a file named `names.txt`. We can use the following command:

```bash { .show-prompt lineNos=false }
grep "Alex" names.txt
Alex Alexandra
```

## Matching on Patterns

Character classes allow you to match a set of characters or ranges of characters. For example, if you want to match any names that contains characters 'a' or 'i' in a given string, you can use the following command:

```bash {.show-prompt lineNos=false }
egrep "[ai]" names.txt
Jennifer
Alexandra
```

This command returns output which is case-sensitive. That means, it does not match with words like `Alex` because it has `A` uppercase. To ignore case, we can use option `-i`.

```bash{ .show-prompt lineNos=false }
grep -i [ai] names.txt
Andrew
Jennifer
Alex
Alexandra
```

Quantifiers specify the number of occurrences of a pattern that you want to match. For example, if you want to find all words that contain two consecutive vowels, you can use the following command.

```output{ lineNos=false }
egrep "[na]{2}" names.txt
```

This command returns all names that have either 'a' or 'n' occuring twice in their names.

**Alternation** allows you to specify multiple patterns and matches if any of them are found. **Grouping** helps with capturing parts of the matched pattern for further manipulation. For example, we have `adjectives.txt` file with below content.

```bash{.show-prompt lineNos=false }
cat adjectives.txt 
beautiful texas
vibrant mumbai
multicultural toronto
scenic San Dieg
```

```bash {.show-prompt lineNos=false }
egrep "(vibrant|beautiful) mumbai" adjectives.txt
vibrant mumbai
```

**Anchors and boundaries** are used to specify the position or surroundings where a match should occur. 
- `^` indicates the start of a line.
- `$` indicates the end of a line.
- `\b` indicates a word boundary.


For example, get names starting with 'Je' in `names.txt` file.

```bash{.show-prompt lineNos=false }
egrep "^Je" names.txt
Jenny
Jennifer
```

Get names ending with character `e` in `names.txt` file.

```bash{ .show-prompt lineNos=false }
egrep "e$" names.txt
Zoe
```

Metacharacters have special meanings in regular expressions and are used to represent certain patterns or characters.
- `.` matches any character except a newline.
- `*` matches zero or more occurrences of the preceding pattern.


```bash{ .show-prompt lineNos=false }
grep "J.n" names.txt
Jenny
Jennifer
```

```bash{ .show-prompt lineNos=false }
grep "Ale*" names.txt
Alex
Alexandra
```

## Character Classes

Some characters are widely availble as common references. These can be checked using their character class name.

- `[[:alnum:]]`: Matches alphanumeric characters [a-zA-Z0-9] 
- `[[:alpha:]]`: Alphabetic characters [A-Za-z] 
- `[[:digit:]]`: Digits: 0 1 2 3 4 5 6 7 8 9 
- `[[:blank:]]`: Blank characters: space and tab 
- `[[:lower:]]`: Lower-case letters [a-z] 
- `[[:upper:]]`: Upper-case letters [A-Z] 
- `[[:punct:]]`: Punctuation characters 
- `[[:xdigit:]]`: Hexadecimal digits [0-9A-Fa-f]

These can be used as below.

```bash {.show-prompt-all lineNos=false }
egrep "[[:alnum:]]" names.txt
egrep "[[:punct:]]" names.txt
```

These are just some of the basics of using regular expressions with `grep` and `egrep` commands in Linux. As you continue your journey, you'll discover many more powerful features and techniques.