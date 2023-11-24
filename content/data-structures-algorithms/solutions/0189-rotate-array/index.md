---
title: "0189 Rotate Array"
date: 2023-11-13T18:48:13-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

## Description

Given an integer array `nums`, rotate the array to the right by `k` steps, where `k` is non-negative.

### Example 1:

```
Input: nums = [1,2,3,4,5,6,7], k = 3
Output: [5,6,7,1,2,3,4]
Explanation:
rotate 1 steps to the right: [7,1,2,3,4,5,6]
rotate 2 steps to the right: [6,7,1,2,3,4,5]
rotate 3 steps to the right: [5,6,7,1,2,3,4]
```

### Example 2:

```
Input: nums = [-1,-100,3,99], k = 2
Output: [3,99,-1,-100]
Explanation: 
rotate 1 steps to the right: [99,-1,-100,3]
rotate 2 steps to the right: [3,99,-1,-100]
``` 

### Constraints:

- `1 <= nums.length <= 10^5`
- `-2^31 <= nums[i] <= 2^31 - 1`
- `0 <= k <= 10^5`
 
**Follow up:**

Try to come up with as many solutions as you can. There are at least three different ways to solve this problem.
Could you do it in-place with `O(1)` extra space?

## Solution

### Brute force approach

The brute force approach would be to rotate the array as many times as needed. One optimization is if the value of `k` is more than `nums.length` then we will be iterating over the array more than once. So, we can reduce that to required number of times because going over full array once will bring th array in the original state. So, we have to iterate only `k % nums.length` times.

```java
class Solution {
    public void rotate(int[] nums, int k) {
        k = k % nums.length;
        int temp, prev;
        for (int i = 0; i < k; i++) {
            prev = nums[nums.length - 1];
            for (int j = 0; j < nums.length; j++) {
                temp = nums[j];
                nums[j] = prev;
                prev = temp;
            }
        }
    }
}
```

## Optimized solution

Another option is to rotate only required elements and come to required state. If we look at it carefully, we can come to required state by following below steps. Again, we should rotate only `k % nums.length` times only. Below is example walk through for `nums = [1, 2, 3, 4, 5, 6, 7]` and `k = 3`.

1. Reverse first `n - k` elements first. This results into `[4,3,2,1,    5,6,7]`
2. Reverse last `k` elements. This results into `[4,3,2,1,    7,6,5]`
3. Now reverse the entire array. `[5,6,7, 1,2,3,4]`

The third step can be even performed first, followed by step 1 and 2. That will also result in the same output.

```java
class Solution {
    public void rotate(int[] nums, int k) {
        // In this case, the rotation will not change array
        if(nums.length == 0 || (k % nums.length) == 0) {
            return;
        }

        k = k % nums.length;

        int n = nums.length;

        // Reverse entire array, O(n / 2)
        reverse(nums, 0, n);

        // Flip first k numbers
        reverse(nums, 0, k);

        // Reverse last n-k numbers
        reverse(nums, k, n);
    }

    // use two pointers to reverse the array in O(n / 2) time.
    private void reverse(int[] nums, int startIndex, int endIndex) {
        for (int i = endIndex - 1, j = startIndex; i > j; i--, j++) {
            int temp = nums[i];
            nums[i] = nums[j];
            nums[j] = temp;
        }
    }
}
```