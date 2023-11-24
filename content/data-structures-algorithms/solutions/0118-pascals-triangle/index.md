---
title: "0118 Pascals Triangle"
date: 2023-11-11T17:34:26-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Iteration"]
languages: ["Java"]
---

## Description

Given an integer `numRows`, return the first `numRows` of Pascal's triangle.

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
Input: numRows = 5
Output: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
```

### Example 2:

```
Input: numRows = 1
Output: [[1]]
```

### Constraints:

- `1 <= numRows <= 30`

## Solution

This one requires two iterations.

```java
class Solution {
    public List<List<Integer>> generate(int numRows) {
        List<List<Integer>> result = new java.util.ArrayList<>();
        for (int i = 0; i < numRows; i++) {
            System.out.println(result);
            List<Integer> row = new ArrayList<>();
            for (int j = 0; j <= i; j++) {
                if (j == 0 || j == i) {
                    row.add(1);
                } else {
                    List<Integer> prevRow = result.get(i - 1);
                    row.add(prevRow.get(j - 1) + prevRow.get(j));
                }
            }
            result.add(row);
        }
        return result;
    }
}
```
