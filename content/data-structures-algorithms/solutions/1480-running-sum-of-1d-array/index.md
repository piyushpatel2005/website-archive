---
title: "1480 Running Sum of 1d Array"
date: 2023-10-27T04:50:00-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Preprocessing", "Prefix Sum"]
languages: ["Java"]
---

## Description

Given an array `nums`. We define a running sum of an array as `runningSum[i] = sum(nums[0]…nums[i])`.
Return the running sum of `nums`.

### Example 1:

**Input:** `nums = [1,2,3,4]`

**Output:** `[1,3,6,10]`

**Explanation:** Running sum is obtained as follows: `[1, 1+2, 1+2+3, 1+2+3+4]`.

### Example 2:

**Input:** `nums = [1,1,1,1,1]`

**Output:** [1,2,3,4,5]

**Explanation:** Running sum is obtained as follows: `[1, 1+1, 1+1+1, 1+1+1+1, 1+1+1+1+1]`.

### Example 3:

**Input:** `nums = [3,1,2,10,1]`

**Output:** `[3,4,6,16,17]`

### Constraints:

- `1 <= nums.length <= 1000`
- `-10^6 <= nums[i] <= 10^6`

## Solution

This is relatively straight forward one. We can create a new array `sums` and calculate the running sum using `sums[i] = sums[i - 1] + nums[i]`. 

```java
class Solution {
    public int[] runningSum(int[] nums) {
        int[] runningSum = new int[nums.length];
        runningSum[0] = nums[0];
        for (int i = 1; i < nums.length; i++) {
            runningSum[i] = runningSum[i - 1] + nums[i];
        }
        return runningSum;
    }
}
```

This approach works in `O(n)` time complexity and `O(n)` space complexity. There is not much improvement we can make in time complexity, but can we modify the array in place and reduce the space complexity to `O(1)`?

In this case, yes we can modify array in place. The improved solution looks like this.

```java
class Solution {
    public int[] runningSum(int[] nums) {
        for (int i = 1; i < nums.length; i++) {
            nums[i] = nums[i - 1] + nums[i];
        }
        return nums;
    }
}
```