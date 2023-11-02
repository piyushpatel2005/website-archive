---
title: "1413 Minimum Value to Get Positive Step by Step Sum"
date: 2023-10-27T05:03:56-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Preprocessing", "Prefix Sum"]
languages: ["Java"]
---

## Description

Given an array of integers `nums`, you start with an initial positive value `startValue`.
In each iteration, you calculate the step by step sum of `startValue` plus elements in `nums` (from left to right).

Return the minimum positive value of `startValue` such that the step by step sum is never less than 1.

### Example 1:

**Input:** `nums = [-3,2,-3,4,2]`

**Output:** `5`

**Explanation:** If you choose `startValue = 4`, in the third iteration your step by step sum is less than 1.

**Demo walk through step by step sum**

| startValue = 4 | startValue = 5 | nums |
|:--------------|:----------------|:-----|
| (4 -3 ) = 1  | (5 -3 ) = 2    |  -3 |
| (1 +2 ) = 3  | (2 +2 ) = 4    |   2 | 
| (3 -3 ) = 0  | (4 -3 ) = 1    |  -3 |
| (0 +4 ) = 4  | (1 +4 ) = 5    |   4 |
| (4 +2 ) = 6  | (5 +2 ) = 7    |   2 |

### Example 2:

**Input:** `nums = [1,2]`

**Output:** `1`

Explanation: Minimum start value should be positive. 
### Example 3:

**Input:** `nums = [1,-2,-3]`

**Output:** `5`
 
### Constraints:

- `1 <= nums.length <= 100`
- `-100 <= nums[i] <= 100`

## Solution

The brute force algorithm would look like this. For each `minStartValue >= 1`, check if the sum of elements of `nums` return negative result. If yes, `break` out of loop else continue iterating until end of all elements of `nums`.

```pseudocode
minStartValue = 1
initialize variable to keep track of sum
initialize variable found to keep track if we found minStartValue
while true
    sum = minStartValue
    found = true
    for i = 0; i < nums.length; i++
        sum += nums[i]
        if (sum < 1)
            found = false
            minStartValue++
            break
    if found
        return minStartValue
```

```java
class Solution {
    public int minStartValueBrute(int[] nums) {
        int minStartValue = 1;
        int sum;
        boolean found;
        while (true) {
            sum = minStartValue;
            found = true;
            for (int i = 0; i < nums.length; i++) {
                sum = sum + nums[i];
                if (sum < 1) {
                    minStartValue++;
                    found = false;
                    break;
                }
            }
            if (found) {
                return minStartValue;
            }
        }
    }
}
```

### Prefix Sum - Preprocessing

In this case, we are looking for a positive number, which if added to all other numbers, will result in positive value. If we look carefully at the operation we performed on array with input `[-3,2,-3,4,2]`, we started with `5` and added each number of the input array. Thus we need to find the minimum value of prefix sum array and we want one greater than that value, this will be `1 - minSum`. This is applicable only if `1 - minSum >= 1`. That is if `minSum < 1`. If `minSum >= 1` then we can simply use `1` as the lowest value because in this case, the sum is never going below 1.

```java
class Solution {
    public int minStartValue(int[] nums) {
        int[] prefixSum = new int[nums.length];
        prefixSum[0] = nums[0];
        int minSum = prefixSum[0];

        for (int i = 1; i < nums.length; ++i) {
            prefixSum[i] += prefixSum[i - 1] + nums[i];
            minSum = Math.min(minSum, prefixSum[i]);
        }
        return minSum >= 0 ? 1 : 1 - minSum;
    }
}
```

There is little improvement we can make if we modify `nums` in place to store prefix sum. This original array is no longer used, so it can be modified in-place to save memory.

```java
class Solution {
    public int minStartValue(int[] nums) {
        int minSum = nums[0];

        for (int i = 1; i < nums.length; ++i) {
            nums[i] = nums[i - 1] + nums[i];
            minSum = Math.min(minSum, nums[i]);
        }
        return minSum >= 0 ? 1 : 1 - minSum;
    }
}
```