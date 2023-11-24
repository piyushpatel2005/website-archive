---
title: "0001 Two Sum"
date: 2023-10-16T15:26:18-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given an array of integers `nums` and an integer `target`, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice. You can return the answer in any order.

### Example 1:

**Input:** `nums = [2,7,11,15]`, `target = 9`

**Output:** `[0,1]`

**Explanation:** Because `nums[0] + nums[1] == 9`, we return `[0, 1]`.

### Example 2:

**Input:** nums = `[3,2,4]`, `target = 6`

**Output:** `[1,2]`

### Example 3:

**Input:** `nums = [3,3]`, `target = 6`

**Output:** `[0,1]`
 

### Constraints:

- \\(2\\; <=\\; nums.length\\; <=\\; 10^4\\)
- \\(-10^9\\; <=\\; nums[i]\\; <=\\; 10^9\\)
- \\(-10^9\\; <=\\; target\\; <=\\; 10^9\\)

Only one valid answer exists.

## Brute Force

In brute force approach, we can iterate through the `nums` array twice. In each iteration, we can validate that `nums[i] + nums[j] = target`. If we find any pair for which the sum of corresponding array elements is `target` then we also have to make sure that we are not using the same element twice by verifying `i != j`. If we find such pairs of indices, then we add those indices to `result` array and return that array.

```java
public class Solution {
    public int[] twoSumsBrute(int[] nums, int target) {
        int[] result = {-1, -1};
        for (int i = 0; i < nums.length; i++) {
            for (int j = 0; j < nums.length; j++) {
                if (nums[i] + nums[j] == target && i != j) {
                     result[0] = i;
                     result[1] = j;
                     return result;
                }
            }
        }
        return result;
    }
}
```

With this approach we can quadratic time complexity.
- Time Complexity: `O(n^2)`

- Space Complexity: `O(1)`

## Better Solution

In this case, the better idea is to use `HashMap` to keep track of numbers already seen with their index position.

```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            System.out.println(map
            );
            if (map.containsKey(target-nums[i])) {
                return new int[] {map.get(target-nums[i]), i};
            } else {
                map.put(nums[i], i);
            }
        }
        return new int[] {-1, -1};
    }
}
```
