---
title: "0283 Move Zeroes"
date: 2023-10-19T15:30:37-04:00
draft: true
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

## Description

Given an integer array `nums`, move all `0`'s to the end of it while maintaining the relative order of the non-zero elements.

Note that you must do this in-place without making a copy of the array.

### Example 1:

**Input:** `nums = [0,1,0,3,12]`

**Output:** `[1,3,12,0,0]`

### Example 2:

**Input:** `nums = [0]`

**Output:** `[0]`
 
### Constraints:

- `1 <= nums.length <= 10^4`
- `-2^31 <= nums[i] <= 2^31 - 1`
 
**Follow up:** Could you minimize the total number of operations done?

## Solution

If we were asked to return a new array, then we could initialize new array `result` with same length as the original array `nums`. We could simply walk through the array from beginning to end and add non-zero elements to new `result` array. Integer arrays have default values of `0`, so at the end the remaining elements would have `0` by default and we would get the expected array. The solution would look like below in this case.

```java
class Solution {
    public int[] moveZeroesBrute(int[] nums) {
        int[] result = new int[nums.length];
        int j = 0;
        for (int i = 0; i < nums.length; i++) {
            if(nums[i] != 0)
                result[j++] = nums[i];
        }
        return result;
    }
}
```

However, in the question, we are asked to modify the array in-place. So, this makes it little challenging.

### Modify Array in Place

In this case, we need to preserve the order as it is and we need to move all zeroes to the end. So, we can have two pointers starting from the `left` and every time we encounter non-zero element, we swap two numbers pointed by `left` and `right` indices. `right` index keep moving along the array until the end of the array and `left` only moves when it's non-zero, thus providing the index position to where the next non-zero element should be inserted.

```java
class Solution {
    public void moveZeroes(int[] nums) {
        int left = 0;
        for (int right = 0; right < nums.length; right++) {
            if (nums[right] != 0) {
                int temp = nums[left];
                nums[left++] = nums[right];
                nums[right] = temp;
            }
        }
    }
}
```