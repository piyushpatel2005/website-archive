---
title: "2352 Equal Row and Column Pairs"
date: 2023-12-24T10:56:48-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given a 0-indexed `n x n` integer matrix `grid`, return the number of pairs `(ri, cj)` such that row `ri` and column `cj` are equal.

A row and column pair is considered equal if they contain the same elements in the same order (i.e., an equal array).

### Example 1:

```
Input: grid = [
    [3,2,1],
    [1,7,6],
    [2,7,7]
]
Output: 1
Explanation: There is 1 equal row and column pair:
- (Row 2, Column 1): [2,7,7]
```

### Example 2:

```
Input: grid = [
    [3,1,2,2],
    [1,4,4,5],
    [2,4,2,2],
    [2,4,2,2]
]
Output: 3
Explanation: There are 3 equal row and column pairs:
- (Row 0, Column 0): [3,1,2,2]
- (Row 2, Column 2): [2,4,2,2]
- (Row 3, Column 2): [2,4,2,2]
```
 

### Constraints:

- `n == grid.length == grid[i].length`
- `1 <= n <= 200`
- `1 <= grid[i][j] <= 10^5`

## Solution

In this problem, if we can somehow store combination of numbers in rows in a HashMap, then we can look up those keys when checking columns. The lookup will be constant time. Also, we need HashMap and not HashSet because the same combination of numbers can occur in multiple rows, so we will have to store their frequency too. 

Now in order to store a row as a column, we have create them as a string. We can do so using some delimiter between each number.

```java
class Solution {
    public int equalPairs (int[][] grids) {
        int gridsLength = grids.length;
        if (grids == null || gridsLength == 0) {
            return 0;
        }
        int count = 0;
        Map<String, Integer> map = new HashMap<>();
        String currentRow = "";
        for (int[] grid : grids) {
            currentRow = String.join(", ", Arrays.stream(grid).mapToObj(String::valueOf).toArray(String[]::new));
            map.put(currentRow, map.getOrDefault(currentRow, 0) + 1);
        }

        // Create column as array and check their string representation in map
        for (int col = 0; col < gridsLength; col++) {
            int[] columnArray = new int[gridsLength];
            for (int row = 0; row < gridsLength; row++) {
                columnArray[row] = grids[row][col];
            }
            currentRow = String.join(", ", Arrays.stream(columnArray).mapToObj(String::valueOf).toArray(String[]::new));
            count += map.getOrDefault(currentRow, 0); // If there are two row, we can have 2 pairs for single matching column
        }
        return count;
    }
}
```

- Time Complexity: `O(n^2)`
- Space Complexity: `O(n^2)` since we are storing in map as key and value pairs