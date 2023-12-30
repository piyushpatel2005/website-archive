---
title: "0930 Binary Subarrays With Sum"
date: 2023-12-27T13:16:58-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing", "Prefix Sum"]
languages: ["Java"]
---

## Description

Given a binary array `nums` and an integer `goal`, return the number of non-empty **subarrays** with a sum `goal`.

A subarray is a contiguous part of the array.

### Example 1:

```
Input: nums = [1,0,1,0,1], goal = 2
Output: 4
Explanation: The 4 subarrays are bolded and underlined below:
[1,0,1]
[1,0,1,0]
[0,1,0,1]
[1,0,1]
```

### Example 2:

```
Input: nums = [0,0,0,0,0], goal = 0
Output: 15
```

### Constraints:

- `1 <= nums.length <= 3 * 10^4`
- `nums[i]` is either `0` or `1`.
- `0 <= goal <= nums.length`

## Solution

This problem could be solved using prefix sum operations. In this case, we want to find number of subarrays where sum of its elements is equal to `goal`. If we calculate the prefix sum for input array `[1, 0, 1, 0, 1]`, we get `[1, 1, 2, 2, 3]`.

```
input: [1, 0, 1, 0, 1]
prefixsum: [1, 1, 2, 2, 3]
prepend 1: [1, 1, 1, 2, 2, 3]
Even though we inserted 1 for key=0, currSum checks from index position 1
Number of subarrays where sum will be 2 are below from prefix sum
[0, 1, 1, 2]        => [1, 0, 1]
[0, 1, 1, 2, 2]     => [1, 0, 1, 0]
[1, 1, 2, 2, 3]     => [0, 1, 0, 1]
[1, 2, 2, 3]        => [1, 0, 1]
```

```java
class Solution {
    public int numSubarraysWithSum(int[] nums, int goal) {
        Map<Integer,Integer> map = new HashMap<>();

        int currSum = 0, count = 0;
        map.put(0, 1);
        for (int i = 0; i < nums.length; i++) {
            currSum = currSum + nums[i];
            count += map.getOrDefault(currSum - goal,0);
            map.put(currSum, map.getOrDefault(currSum, 0) + 1);
            System.out.println(map + " count: " + count + " currSum: " + currSum);
        }
        return count;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`
