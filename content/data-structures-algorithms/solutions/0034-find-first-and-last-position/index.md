---
title: "0034 Find First and Last Position"
date: 2023-10-09T15:46:00-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["Java"]
---

## Description
In this tutorial, we will learn about one of the basic algorithm question for Arrays.
Given an array of integers `nums` sorted in non-decreasing order, find the starting and ending position of a given `target` value.

<!--more-->
If `target` is not found in the array, return `[-1, -1]`.

**Constraint**: Write algorithm in `O( log n)` runtime complexity.

## Examples

### Example 1:

**Input:** `nums = [5, 7, 7, 8, 8, 10]` and `target = 8`

**Output:** `[3, 4]`

**Example:** In this case, input `nums` array contains `target` value 2 times. We need to find the lowest index position and highest index position which have this value. In this case, those are 3 and 4. So, the output is `[3, 4]`

### Example 2:

**Input:** `nums = [5, 7, 7, 8, 8, 10]` and `target = 6`

**Output:**: `[-1, -1]`

### Example 3:

**Input:** `nums = []` and `target = 5`

**Output:** `[-1, -1]`

**Explanation:**: In this case, the `target` value does not occur anytime, so the output will be `[-1, -1]`

### Constraints:

- `0 <= nums.length <= 10^5`
- `-10^9 <= nums[i] <= 10^9`
- `nums` is non-decreasing array.
- `-10^9 <= target <= 10^9`

## Brute Force Approach:

One of the approach to solving this algorithm is using Brute force approach. In this case, because the input array is arranged in ascending order. We can iterate through beginning to the end to check the positions where this value `target` occurs.

```java
public class Solution {
    public int[] searchRangeBrute(int[] nums, int target) {
        int[] result = new int[]{-1, -1};
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == target) {
                if (result[0] == -1) {
                    result[0] = i;
                    result[1] = i;
                }
                else
                    result[1] = i;
            }
        }
        return result;
    }
}
```

This code base is relatively straight forward. We iterate through each element of `nums` array. When we find that the value matches `target` value, we modify the output array element with the index position of this element. We will update both index (start and end). Next time, when we encounter the same number again, we only update the end position to get the full range of indices which have this `target` value. We start with array of `[-1, -1]` to cover the case where we do not find the `target` value in `nums` array.

This approach gives us solution with time complexity of `O(n)` because we iterate through `nums` array once.

## Better Solution

Although above approach works for getting the correct output. We can optimize the searching of the number. There is already better search algorithm out there to find a number in array (binary search). We can use that to locate occurences of `target` into our input array `nums`.

Usually when performing binary search, if the `target` is not found, we return -1. However, in this case, we want to return the left position, the position where that number would lie if it was present. That would make up the right most position for this `target` number.


```java
class Solution {
    public int[] searchRange(int[] nums, int target) {
        int startPosition = binarySearch(nums, target);
        int endPosition = binarySearch(nums, target + 1);
        return startPosition == endPosition ?
                new int[]{-1, -1} :
                new int[]{startPosition, endPosition - 1};
    }

    private int binarySearch(int[] nums, int target) {
        int left = 0, right = nums.length;
        while (left < right) {
            int middle = (left + right) / 2;
            if (nums[middle] == target)
                return middle;
            else if (nums[middle] > target) {
                right = middle;
            } else {
                left = middle + 1;
            }
        }
        return left; // return left position rather than -1
    }
}
```

This algorithm works in `O(n log n)` time complexity because of binary search for finding the index position.