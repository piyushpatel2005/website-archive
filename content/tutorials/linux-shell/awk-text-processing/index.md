---
title: "Awk Text Processing"
date: 2023-09-12T21:50:04Z
draft: false
---

The awk command stands out as a versatile tool for text processing and data manipulation. Awk is known for its powerful capabilities to extract, transform, and analyze data. This tutorial will delve into the numerous uses of awk in various contexts, including printing output, file manipulation, statistics, and more.
<!--more-->

## Basic Usage:
The basic syntax of using awk is as follows.

```bash{ lineNos=false }
awk '<pattern> { <action> }' <file>
```

- The `<pattern>` specifies the matching pattern for selecting specific lines.
- The `{ <action> }` defines the action or command to be executed on matched lines.
- `<file>` refers to the input file(s) to be processed.

## Printing Output:
Awk provides powerful mechanisms to print output based on various conditions or criteria.

- Print Full file

```bash{ lineNos=false }
# Print full file content
awk '{print}' filename.txt

# Print specific field
awk '{print $1,$3}' filename.txt
```

- For `awk` the default column separator is space. So, above command will print first and third word from each lines of the file. If we had a different delimiter, for example, if we had CSV file and wanted to print first and third columns from the file, we could use `-F` option to specify the delimiter.

```bash{ lineNos=false }
awk -F',' '{print $1, $3}' filename.csv
```

- Print lines matching a specific pattern.

```bash{ lineNos=false }
awk '/pattern/{print}' filename.txt
```


## Conditional Operations:
Awk supports various conditional statements such as `if-else` statements and loops within its processing framework. These allow you to apply different actions based on specific conditions, enabling complex data processing tasks.

- Using if..else 

```bash{ lineNos=false }
awk '{ if ($1 > 5) print "Greater than 5"; else print "Less than or equal to 5" }' filename.txt
```

- Using logical operations using `&&` and `||`

```bash{ lineNos=false }
awk '{ if ($1 > 5 && $1 < 10) print "Between 5 and 10" }' filename.txt
```

- Ternary operator with awk

```bash{ lineNos=false }
awk '{print ($2 > 0 ? "Positive" : "Negative") }' filename.txt
```

## File Manipulation:
Awk offers robust features for manipulating files. This is used to append or prepend content to a file using `awk`, delete specific lines based on patterns, perform search and replace operations, and even create new files dynamically with `awk`.

- Append a text to each line of a file. In below example, `$0` represents full line content and we are append additional text to it.

```bash{ lineNos=false }
awk '{print $0, "new text"}' filename.txt
```

- Prepend a text to each line of a file

```bash{ lineNos=false }
awk '{print "prepend text", $0}' filename.txt
```

- Append data based on certain condition. This example verifies if the third column has a value greater than 50. If true, it appends 'true' to that line of the file.

```bash{ lineNos=false }
awk '$3 > 50 {print $0, "true"}' filename.txt
```

- Prepend data based on a pattern matching

```bash{ lineNos=false }
awk '/pattern/{print "prepended text", $0}' filename.txt
```


## Built-in Functions with `awk`:
Awk comes equipped with an extensive collection of built-in functions that make text manipulation very easy. Below examples cover some of the basic functions available with `awk`. For more functions, refer to AWK documentation.

- Find length of the string or number of elements in an array.

```bash{ lineNos=false }
awk '{print length($0)}' filename.txt
```

- Divide the string into multiple substrings and store in an array using `split()`.

```bash{ lineNos=false }
awk '{ split($0, array, ":"); print "Username:", array[1], "UID:", array[3] }' /etc/passwd
```

- Convert to uppercase or lowercase

```bash{ lineNos=false }
awk '{print tolower($1)}' filename.txt
awk '{print toupper($0)}' filename.txt
```

- Extract substring from a given string based on start position and length of characters.

```bash{ lineNos=false }
awk '{ print substr($0, 3, 5)}' filename.txt
```

## Advanced Data Analysis:
One of the strengths of awk lies in its statistical capabilities. This sections demonstrates how to use awk to calculate totals, averages, maximum and minimum values from numerical data sets. AWK can also be used to group data by one of the fields.

- Calculate sum, average and count of values in specific column.

```bash{ lineNos=false }
awk '{ sum += $1; count++ } END { print "Sum:", sum; print "Average:", sum/count; print "Count:", count }' filename.txt
```

- Find maximum and minimum value for a column

```bash{ lineNos=false }
awk 'NR == 1 { max = min = $1 } $1 > max { max = $1 } $1 < min { min = $1 } END { print "Maximum:", max; print "Minimum:", min }' filename.txt
```

- Group by and aggregate data. Below example groups values in first column and calculates sum of values in second column for each group.

```bash{ lineNos=false }
awk '{ group[$1] += $2 } END { for (key in group) print key, group[key] }' filename.txt
```

## Command Line Input:
Besides operating on files, awk can also be used interactively through command line input. This can be very useful in shell scripting as we can calculate specific value and then assign to another variable to use later.

- Get word count of given word. In this case, `NF` is one of the built-in variable with `awk`. This represents the number of fields (separated by space).

```bash
echo "Hello world" | awk '{ print NF }'
```

## Conclusion:
The `awk` command offers tremendous flexibility and efficiency for various text processing tasks in Linux bash scripting. Being able to use `awk` effectively will increase your productivity and ability to write complex bash scripts.