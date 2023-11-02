---
title: "303 Range Sum Query Immutable"
date: 2023-11-02T16:07:07-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Prefix Sum"]
languages: ["Java"]
---

## Description

Given an integer array `nums`, handle multiple queries of the following type:

Calculate the **sum** of the elements of `nums` between indices `left` and `right` inclusive where `left <= right`.
Implement the `NumArray` class:

- `NumArray(int[] nums)` Initializes the object with the integer array `nums`.
- `int sumRange(int left, int right)` Returns the sum of the elements of `nums` between indices `left` and `right` inclusive (i.e. `nums[left] + nums[left + 1] + ... + nums[right]`).

### Example 1:

```
Input:
["NumArray", "sumRange", "sumRange", "sumRange"]
[[[-2, 0, 3, -5, 2, -1]], [0, 2], [2, 5], [0, 5]]
Output:
[null, 1, -1, -3]

Explanation:
NumArray numArray = new NumArray([-2, 0, 3, -5, 2, -1]);
numArray.sumRange(0, 2); // return (-2) + 0 + 3 = 1
numArray.sumRange(2, 5); // return 3 + (-5) + 2 + (-1) = -1
numArray.sumRange(0, 5); // return (-2) + 0 + 3 + (-5) + 2 + (-1) = -3
```

### Constraints:

- `1 <= nums.length <= 10^4`
- `-10^5 <= nums[i] <= 10^5`
- `0 <= left <= right < nums.length`
- At most `10^4` calls will be made to `sumRange`.

## Solution

The brute force approach would simply initialize the `NumArray` with a member variable. However, this being array, it will not create a brand new copy of the array but will store the pointer to the original array. When we want the sum between `left` and `right`, we can simply access elements between these indices, add them up and return the value. Accessing array elements is `O(1)`, so these operations take like `O(n)` where `n = right - left` for single query.

```java
class NumArray {
    private int[] values;
    public NumArray(int[] nums) {
        this.values = nums;
    }

    public int sumRange(int left, int right) {
        int sum = 0;
        for(int i = left; i <= right; i++) {
            sum += this.values[i];
        }
        return sum;
    }
}
```

This approach does seem to work but we can improve the speed a bit. In this case, because we are having more than one query, it makes sense to calculate prefix sum and use that to answer the upcoming queries.

We start the prefixSum with 0 and have the length of the prefix sum as `nums.length + 1`. This way if we have to calculate sum of elements between `left` and `right`, it will be equal to below.

```java
int output = (prefixSum[right + 1] - prefixSum[0]) - (prefixSum[left] - prefixSum[0])
= prefixSum[right + 1] - prefixSum[left]
```