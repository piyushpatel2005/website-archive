---
title: "0713 Subarray Product Less Than K"
date: 2023-10-21T15:04:09-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Sliding Window"]
languages: ["Java"]
---

## Description

Given an array of integers `nums` and an integer `k`, return the number of contiguous subarrays where the product of all the elements in the subarray is strictly less than `k`.

### Example 1:

**Input:** `nums = [10,5,2,6]`, `k = 100`

**Output:** `8`

**Explanation:** The 8 subarrays that have product less than 100 are:
`[10], [5], [2], [6], [10, 5], [5, 2], [2, 6], [5, 2, 6]`

Note that `[10, 5, 2]` is not included as the product of 100 is not strictly less than `k`.

### Example 2:

**Input:** `nums = [1,2,3]`, `k = 0`

**Output:** `0`
 
### Constraints:

- `1 <= nums.length <= 3 * 10^4`
`1 <= nums[i] <= 1000`
`0 <= k <= 10^6`

## Solution:

This problem can be solved using sliding window. In this case, we have to find the number of subarrays, we don't need to store those subarrays. So, we just need to keep track of the number.

We can start with two pointers `left = right = 0` and initial `count = 0`. We can iterate `right` pointer from 0 to `nums.length - 1`. In each iteration, we add one element into the window. If window becomes invalid (i.e. `product > k`), we know that we have reached the maximum array length. At this stage, we have to calculate how many valid subarrays are possible till now and add them to the `count` variable. One of the properties of arrays is that number of subarrays ending at index position `right` will be `(right - left) + 1`. So, at each stage, we can determine valid number of subarrays and add them to current `count`. When we see that the subarray has become invalid, we start removing elements from `left` until it becomes valid again.

```markdown
left = right = 0
count = 0
currentProduct = 1
while right less than nums.length
    currentProduct *= nums[right]
    while (currentProduct >= k)
        currentProduct /= nums[left]
        left++
    count += (right - left) + 1 
    right++
```

```java
class Solution {
    public int numSubarrayProductLessThanK(int[] nums, int k) {
        int left = 0, right = 0;
        int currentProduct = 1;
        int count = 0;
        while (right < nums.length) {
            currentProduct *= nums[right];
            while (left <= right && currentProduct >= k) {
                currentProduct /= nums[left];
                left++;
            }
            count += (right - left) + 1;
            right++;
        }
        return count;
    }
}
```