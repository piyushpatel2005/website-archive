---
title: "0088 Merge Sorted Array"
date: 2023-11-03T18:26:07-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

## Description

You are given two integer arrays `nums1` and `nums2`, sorted in non-decreasing order, and two integers `m` and `n`, representing the number of elements in `nums1` and `nums2` respectively.

Merge `nums1` and `nums2` into a single array sorted in non-decreasing order.

The final sorted array should not be returned by the function, but instead be stored inside the array `nums1`. To accommodate this, `nums1` has a length of `m + n`, where the first `m` elements denote the elements that should be merged, and the last `n` elements are set to `0` and should be ignored. `nums2` has a length of `n`.

### Example 1:

```
Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
Output: [1,2,2,3,5,6]
Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.
```

### Example 2:

```
Input: nums1 = [1], m = 1, nums2 = [], n = 0
Output: [1]
Explanation: The arrays we are merging are [1] and [].
The result of the merge is [1].
```

### Example 3:

```
Input: nums1 = [0], m = 0, nums2 = [1], n = 1
Output: [1]
Explanation: The arrays we are merging are [] and [1].
The result of the merge is [1].
Note that because m = 0, there are no elements in nums1. The 0 is only there to ensure the merge result can fit in nums1.
```

### Constraints:

- `nums1.length == m + n`
- `nums2.length == n`
- `0 <= m, n <= 200`
- `1 <= m + n <= 200`
- `-10^9 <= nums1[i], nums2[j] <= 10^9`
 
**Follow up:** Can you come up with an algorithm that runs in `O(m + n)` time?

## Solution

In this case, we have to start filling the array from the end. So, we create two pointers `p1` and `p2` which point to the last element of `num1` and `num2` respectively. If `num2` has no elements, then there is nothing to modify and we break out of the loop.
If `num1` is not empty and `num1` has larger element, then we insert that element at the end of the `num1` using index `i` and reduce the corresponding pointer `p1`. On the other hand if `num2` has element which is larger then we use that element to add at the end and subsequently decrease the pointer `p2` to point to next element of `num2`.

```java
class Solution {
    public void merge(int[] num1, int m, int[] num2, int n) {
        int p1 = m - 1; // pointer for num1
        int p2 = n - 1; // pointer for num2
        for (int i = m + n - 1; i >= 0; i-- ) {
            if (p2 < 0) {
                break;
            }
            if (p1 >= 0 && num1[p1] > num2[p2]) {
                num1[i] = num1[p1];
                p1--;
            } else {
                num1[i] = num2[p2];
                p2--;
            }
        }
    }
}
```