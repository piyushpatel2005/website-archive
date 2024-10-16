---
title: "0035 Search Insert Position"
date: 2024-10-08T15:30:17-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["Java"]
---

## Description

Given a sorted array of distinct integers and a `target` value, return the index if the `target` is found. If not, return the index where it would be if it were inserted in order.

You must write an algorithm with `O(log n)` runtime complexity.


### Example 1:

```plaintext
Input: nums = [1,3,5,6], target = 5
Output: 2
```

### Example 2:

```plaintext
Input: nums = [1,3,5,6], target = 2
Output: 1
```

### Example 3:

```plaintext
Input: nums = [1,3,5,6], target = 7
Output: 4
```

### Constraints:

- `1 <= nums.length <= 10^4`
- `-104 <= nums[i] <= 10^4`
- `nums` contains distinct values sorted in ascending order.
- `-10^4 <= target <= 10^4`

## Solution

This problem can be solved using binary search. This is not like normal binary search where we return the index of the target element if found. In this case, we can keep reducing the search space until we find the index where the target element is present. If there is no such element in the array, we can return the index where it should be inserted. This second case is interesting because that means we may not end up finding the index for the `target` value. If we don't find it, then when do we terminate the loop? This would be when our `left` and `right` pointers have crossed over. At that point, we can return the `left` pointer as the index where the `target` value should be inserted.

```java
class Solution {
    public int searchInsert(int[] nums, int target) {
        int left = 0;
        int right = nums.length - 1;
        int middle = 0;

        while (left <= right) {
            middle = left + (right - left) / 2;
            if (nums[middle] == target) {
                return middle;
            } else if (nums[middle] < target) {
                left = middle + 1;
            } else {
                right = middle - 1;
            }
        }
        return left;
    }
}
```

- Time Complexity: `O(n log n)`
- Space Complexity: `O(1)`