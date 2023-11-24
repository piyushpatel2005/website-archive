---
title: "0119 Pascals Triangle Ii"
date: 2023-11-12T15:46:47-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Iteration"]
languages: ["Java"]
---

## Description

Given an integer rowIndex, return the rowIndexth (0-indexed) row of the Pascal's triangle.

In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:


```
            1
          1   1
        1   2   1
      1   3   3   1
    1   4   6   4   1
```

### Example 1:

```
Input: rowIndex = 3
Output: [1,3,3,1]

```

### Example 2:

```
Input: rowIndex = 0
Output: [1]
```

### Example 3:

```
Input: rowIndex = 1
Output: [1,1]
```

### Constraints:

- `0 <= rowIndex <= 33`

## Solution

It seems like we may need more space for this one to create `List<List<Integer>>` to find the solution. However, if we look at the pattern, for each `rowIndex`, the number of elements in the list will be `rowIndex + 1`. So, we can start with List of `rowIndex + 1` elements. Also, the pattern shows that the last and the first element of this list should be `1`. So, we fill the list with all elements as 1.

Next, we can iterate from element `1` to `rowIndex`, that is we skip first and last element of the list. We start with `j=i` and iterate until `j=0` and decrement `j` by 1. In each iteration, we set the value of `j`th position to `result[j-1] + result[j]`.

```
    1   1   1   1   1
    1   2   6   1   1
    1   2   3   1   1
    1   3   3   1   1
    1   3   3   4   1
    1   3   6   4   1
    1   4   6   4   1
```