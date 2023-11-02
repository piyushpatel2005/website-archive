---
title: "0209 Minimum Size Subarray Sum"
date: 2023-10-23T16:22:52-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Sliding Window"]
languages: ["Java"]
---

## Description

Given an array of positive integers `nums` and a positive integer `target`, return the minimal length of a subarray whose sum is greater than or equal to `target`. If there is no such subarray, return `0` instead.

### Example 1:

**Input:** `target = 7`, `nums = [2,3,1,2,4,3]`

**Output:** `2`

**Explanation:** The subarray `[4,3]` has the minimal length under the problem constraint.

### Example 2:

**Input:** `target = 4`, `nums = [1,4,4]`

**Output:** `1`

### Example 3:

**Input:** `target = 11`, nums = `[1,1,1,1,1,1,1,1]`

**Output:** `0`
 
### Constraints:

- `1 <= target <= 10^9`
- `1 <= nums.length <= 10^5`
- `1 <= nums[i] <= 10^4`

## Solution

This can be solved using sliding window operations. We start with two pointers `left = right = 0`. In this case, subarray is valid as long as the sum of all elements of subarray is less than or equal to `target`. We move the right pointer towards right as long as it is valid subarray. When it becomes invalid (sum of elements greater than `target`), we start incrementing `left` pointer until the array becomes valid again.

```markdown
minimumLength = minimum possible value
left = right = 0
currentSum = 0
while right less than nums.length
    currentSum += nums[right]
    while currentSum >= target
        minimumLength = minimum of minimumLength and (right - left + 1)
        currentSum -= nums[left]
        left++  
    right++
    if minimumLength == minimum value 
        return 0
    else
        return minimumLength
```

```java
class Solution {
    public int minSubArrayLen(int s, int[] nums) {
        int minimumLength = Integer.MAX_VALUE;
        int left = 0, right = 0;
        int currentSum = 0;
        while (right < nums.length) {
            currentSum += nums[right];
            while (currentSum >= s) {
                minimumLength = Math.min(minimumLength, right - left + 1);
                currentSum -= nums[left];
                left++;
            }
            right++;
        }
        return minimumLength == Integer.MAX_VALUE ? 0 : minimumLength;
    }
}
```