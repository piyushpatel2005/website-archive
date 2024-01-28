---
title: "0485 Max Consecutive Ones"
date: 2023-11-03T14:31:16-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Array"]
languages: ["Java"]
---

## Description

Given a binary array `nums`, return the maximum number of consecutive `1`'s in the array.

### Example 1:

```
Input: nums = [1,1,0,1,1,1]
Output: 3
Explanation: The first two digits or the last three digits are consecutive 1s. The maximum number of consecutive 1s is 3.
```

### Example 2:

```
Input: nums = [1,0,1,1,0,1]
Output: 2
```

### Constraints:

- `1 <= nums.length <= 10^5`
- `nums[i]` is either `0` or `1`.

## Solution

This is relatively simple case where if the number is 1, we have to increase `currentLength`. If we have found `1`s, then we increment `currentLength` and replace `maxLength` with `currentLength` if it's longer.

```java
class Solution {
    public int findMaxConsecutiveOnes(int[] nums) {
        int currentLength = 0;
        int maxLength = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 0) {
                currentLength = 0;
            } else {
                currentLength++;
                maxLength = Math.max(maxLength, currentLength);
            }
        }
        return maxLength;
    }
}
```