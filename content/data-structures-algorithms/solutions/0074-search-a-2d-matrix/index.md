---
title: "0074 Search a 2d Matrix"
date: 2024-10-01T02:20:06-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["Java"]
---

## Description

You are given an `m x n` integer matrix matrix with the following two properties:

- Each `row` is sorted in non-decreasing order.
- The first integer of each row is greater than the last integer of the previous row.
Given an integer `target`, return `true` if `target` is in matrix or `false` otherwise.

You must write a solution in `O(log(m * n))` time complexity.


### Example 1:

```plaintext
Input: matrix = [
    [1,3,5,7],
    [10,11,16,20],
    [23,30,34,60]
], target = 3
Output: true
```

### Example 2:

```plaintext
Input: matrix = [
    [1,3,5,7],
    [10,11,16,20],
    [23,30,34,60]
], target = 13
Output: false
```

### Constraints:

- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 100`
- `-10^4 <= matrix[i][j], target <= 10^4`

## Solution

This problem can be solved using binary search. Here, you can think of this 2D matrix as a 1D array. The idea is to start the binary search from first row last element. If the `target` is greater than the last element of the row, then we move to the next row. If the `target` is less than the last element of the row, then we perform binary search on that row.

```java
class Solution {
    public boolean searchMatrix(int[][] matrix, int target) {
        int row = 0;
        int col = matrix[0].length - 1;

        while (row < matrix.length && col >= 0) {
            if (matrix[row][col] == target) {
                return true;
            } else if (matrix[row][col] < target) {
                row++;
            } else {
                return binarySearch(matrix[row], target);
            }
        }
        return false;
    }

    private boolean binarySearch(int[] arr, int target) {
        int start = 0;
        int end = arr.length - 1;

        while (start <= end) {
            int mid = start + (end - start) / 2;
            if (arr[mid] == target) {
                return true;
            } else if (arr[mid] < target) {
                start = mid + 1;
            } else {
                end = mid - 1;
            }
        }
        return false;
    }
}
```

- Time Complexity: `O(log(m * n))`
- Space Complexity: `O(1)`