---
title: "0001 Two Sum"
date: 2023-10-16T15:26:18-04:00
draft: true
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Two Pointers"]
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
            for (int j = 1; j < nums.length; j++) {
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

The better idea would be to use two pointers and use them to navigate closer to the result. In this case, we have sorted array as input and this allows us to use two pointers, because we know in which direction the numbers will be larger. The basic algorithm for this looks like below.

```markdown
Initialize one pointer left = 0
Initialize another pointer right = nums.length - 1
while left less than right
    Check if nums[left] + nums[right] greater than target
        right = right + 1
    Else if nums[left] + nums[right] less than target
        left = left + 1
    Else 
        return [left, right]
If we didn't find a pair, return false
```

Let's convert this pseudo code into actual Java program.

```java
class Solution {
    public int[] twoSums(int[] nums, int target) {
        int[] result = {-1, -1};
        int left = 0, right = nums.length - 1;
        while (left < right) {
            if (nums[left] + nums[right] > target) {
                right--;
            } else if (nums[left] + nums[right] < target) {
                left++;
            } else {
                result[0] = left;
                result[1] = right;
                return result;
            }
        }
        return result;
    }
}
```

Also, to cover the edge case, we have initialized `result` array with index positions `[-1, -1]`. So, if we didn't find any indices which satisfies the condition, we return `[-1, -1]` invalid indices.