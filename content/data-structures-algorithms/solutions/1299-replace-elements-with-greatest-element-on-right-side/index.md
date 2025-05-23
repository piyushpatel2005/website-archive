---
title: "1299 Replace Elements With Greatest Element on Right Side"
date: 2023-11-05T15:25:40-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Array"]
languages: ["Java"]
---

## Description

Given an array `arr`, replace every element in that array with the greatest element among the elements to its right, and replace the last element with `-1`.

After doing so, return the array.

### Example 1:

```
Input: arr = [17,18,5,4,6,1]
Output: [18,6,6,6,1,-1]
Explanation: 
- index 0 --> the greatest element to the right of index 0 is index 1 (18).
- index 1 --> the greatest element to the right of index 1 is index 4 (6).
- index 2 --> the greatest element to the right of index 2 is index 4 (6).
- index 3 --> the greatest element to the right of index 3 is index 4 (6).
- index 4 --> the greatest element to the right of index 4 is index 5 (1).
- index 5 --> there are no elements to the right of index 5, so we put -1.
```

### Example 2:

```
Input: arr = [400]
Output: [-1]
Explanation: There are no elements to the right of index 0.
```

### Constraints:

- `1 <= arr.length <= 10^4`
- `1 <= arr[i] <= 10^5`

## Solution

Although this problem looks like sorting, it's not exactly. In this case, we can start iterating from the right and keep track of the max number seen so far in a variable. This is the value we have to insert at each stage in the iteration. So, the problem becomes trivial with single iteration through the array. The important point is that we have start iterating from the end and not from the beginning.

```java
class Solution {
    public int[] replaceElements(int[] arr) {
        int maxSoFar = -1, index = arr.length - 1;
        while (index >= 0) {
            int temp = arr[index];
            arr[index--] = maxSoFar;
            maxSoFar = Math.max(maxSoFar, temp);
        }
        return arr;
    }
}
```