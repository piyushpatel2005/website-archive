---
title: "0747 Largest Number Atleast Twice of Others"
date: 2023-11-09T16:31:26-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Binary Search", "Array"]
languages: ["Java"]
---

## Description

You are given an integer array `nums` where the largest integer is unique.

Determine whether the largest element in the array is at least twice as much as every other number in the array. If it is, return the index of the largest element, or return `-1` otherwise.

### Example 1:

```
Input: nums = [3,6,1,0]
Output: 1
Explanation: 6 is the largest integer.
For every other number in the array x, 6 is at least twice as big as x.
The index of value 6 is 1, so we return 1.
```

### Example 2:

```
Input: nums = [1,2,3,4]
Output: -1
Explanation: 4 is less than twice the value of 3, so we return -1.
``` 

### Constraints:

- `2 <= nums.length <= 50`
- `0 <= nums[i] <= 100`
- The largest element in `nums` is unique.

## Solution

This can be solved using binary search or by using `HashSet` or `HashMap` to store previously seen elements.

### 1. Using Sorting

```java
class Solution {
    public int dominantIndex(int[] nums) {
        int max = Integer.MIN_VALUE;
        int index = -1;
        for (int i = 0; i < nums.length; i++) {
            if (max < nums[i]) {
                index = i;
                max = nums[i];
            }
        }
        Arrays.sort(nums);
        if (max < 2 * nums[nums.length - 2])
            return -1;
        else
            return index;
    }
}
```

### 2. Using Single Iteration

In this case, starting from the beginning, we will have to track largest number and second largest number. At the end, if largest number is at least 2 times more than second largest number, we return the index of largest number else -1.

```pseudocode
Initialize max = Integer.MIN_VALUE, secondLargest = Integer.MIN_VALUE
int index = -1
for i = 0; i < nums.length; i++
    if (nums[i] > max)
        secondLargest = max
        max = nums[i]
        index = i
    else if (nums[i] > secondLargest)
        secondLargest = nums[i]
return max >= 2 * secondLargest ? index : -1
```

```java
class Solution {
    public int dominantIndex2(int[] nums) {
        int max = Integer.MIN_VALUE, secondLargest = Integer.MIN_VALUE, index = -1;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] > max) {
                secondLargest = max;
                max = nums[i];
                index = i;
            } else if (nums[i] > secondLargest) {
                secondLargest = nums[i];
            }
        }
        return max < 2 * secondLargest ? -1 : index;
    }
}
```