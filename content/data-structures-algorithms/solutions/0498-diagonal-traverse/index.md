---
title: "0498 Diagonal Traverse"
date: 2023-11-07T16:25:11-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["Java"]
---

## Description

Given `m x n` matrix `mat`, return an array of all elements of array in a diagonal order.

### Example 1

```
        1 2 3
        4 5 6
        7 8 9

Input: mat = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,2,4,7,5,3,6,8,9]
```

### Example 2:

```
Input: mat = [[1,2],[3,4]]
Output: [1,2,3,4]
```

### Constraints:

- `m == mat.length`
- `n == mat[i].length`
- `1 <= m, n <= 10^4`
- `1 <= m * n <= 10^4`
- `-10^5 <= mat[i][j] <= 10^5`

## Solution

This is plain iteration problem with some conditionals. If we look at the pattern carefully, we can see that the direction changes from up to down at the edges and vice a versa. So, we have to have those as conditionals and we can iterate through all elements of the arrray.

```java
class Solution {
    public int[] findDiagonalOrder(int[][] matrix) {
        int rows = matrix.length;
        int cols = matrix[0].length;
        int[] result = new int[rows * cols];
        int i = 0; // keep track of rows
        int j = 0; // keep track of columns
        int k = 0; // index for inserting into new array
        boolean up = true; // toggle to decided if we need to move up or down
        while (k < rows * cols) {
            result[k++] = matrix[i][j];
            if (up) {
                if (j == cols - 1) {
                    up = false;
                    i++;
                } else if (i == 0) {
                    up = false;
                    j++;
                }  else if (i == rows - 1 || j == 0) {
                    up = true;
                    j++;
                    i--;
                } else {
                    i--;
                    j++;
                }
            } else {
                if (i == rows - 1) {
                    up = true;
                    j++;
                } else if (j == 0) {
                    i++;
                    up = true;
                }else {
                    i++;
                    j--;
                }
            }
        }
        return result;
    }
}
```