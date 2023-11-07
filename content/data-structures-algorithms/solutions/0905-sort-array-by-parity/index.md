---
title: "0905 Sort Array by Parity"
date: 2023-11-06T13:46:18-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Iteration", "Two Pointers"]
languages: ["Java"]
---

## Description 

Given an integer array `nums`, move all the even integers at the beginning of the array followed by all the odd integers.

Return any array that satisfies this condition.

### Example 1:

```
Input: nums = [3,1,2,4]
Output: [2,4,3,1]
Explanation: The outputs [4,2,3,1], [2,4,1,3], and [4,2,1,3] would also be accepted.
```

Example 2:

```
Input: nums = [0]
Output: [0]
```

### Constraints:

- `1 <= nums.length <= 5000`
- `0 <= nums[i] <= 5000`

## Solution

The important point for this problem is that the order of array elements do not matter. The only point is that even numbers need to be before odd numbers. In this case, we can use two pointers, one from `left` and another from `right`. If we find a number which is even from left, we simply increment `left`. If it's odd and at the same time if the number on the `right` pointer is even, swap the numbers at `nums[left]` and `nums[right]` and move both pointers. If the number at right is already odd, then simply increment `right`.

```java
class Solution {
    public int[] sortArrayByParity(int[] nums) {
        if (nums == null || nums.length == 0)
            return nums;
        int left = 0, right = nums.length - 1;
        while (left < right) {
            if (nums[left] % 2 == 0) {
                left++;
            } else if (nums[right] % 2 == 0){
                int temp = nums[right];
                nums[right--] = nums[left];
                nums[left++] = temp;
            } else {
                right--;
            }
        }
        return nums;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`