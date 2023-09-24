---
title: "Arrays"
date: 2023-09-12T21:42:58Z
draft: false
---

Arrays are useful data structures that allow you to store multiple values under a single variable name. This can be useful when we want to perform the same set of operations on multiple items.
<!--more-->

## Creating an Array

To create an array in Bash, you can use the following syntax:

```bash{ lineNos=false }
array_name=(value1 value2 value3 ...)
```

For example, let's create an array called `names` that contains three elements.

```bash
names=(Alex Andrew Ashley)
```

## Accessing Elements of an Array

To access individual elements within an array, you can use curly brackets `{}` and specify the index of the element. Note that array indices start at zero.

```bash
echo ${array_name[index]}
```

For instance, to access the first element of our `names` array (i.e., "Alex"), we would write:

```bash
echo ${names[0]}
```

We can also print all elements of a list using `${array_name[*]}` syntax.

## Modifying Array Elements

To modify or assign new values to specific elements within an array, simply use the assignment operator (`=`) combined with the indexed value.

```bash
array_name[index]=new_value
```

If we want to change the second element of our `fruits` array from "banana" to "grape", we would execute:

```bash
names[1]=Anita
```

## Array Length

To determine the length of an array (the number of elements it contains), we can use `${#array_name[@]}` notation.

For instance, to find out how many elements are present in our `names` array, we would write:

```bash
echo ${#names[@]}
```

## Looping Through an Array

Looping through the elements of an array can be done using a `for` loop. Here's an example that prints out each element of the `names` array:

```bash
for item in "${array_name[@]}"; do
    echo $item
done
```

**Full Example:**

```bash
#!/bin/bash
names=(Alex Andrew Ashley)
echo ${names[0]}
echo "Printing all names:"
echo ${names[*]}
echo "Modified second element of names array"
names[1]=Anita
echo "Length of array: ${#names[@]}"
echo "Print Modified names:"
for name in "${names[@]}"
do
    echo $name
done
```

**Output:**

```output{ lineNos=false }
Alex
Printing all names:
Alex Andrew Ashley
Modified second element of names array
Length of array: 3
Print Modified names:
Alex
Anita
Ashley
```

In this tutorial, we covered the basics of working with arrays in Bash scripting. You learned how to create arrays, access and modify their elements, determine array length, and loop through array elements using a `for` loop. Arrays are powerful tools that allow you to work efficiently and effectively with multiple values within your shell scripts.