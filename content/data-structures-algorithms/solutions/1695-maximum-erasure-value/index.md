---
title: "1695 Maximum Erasure Value"
date: 2023-12-27T15:57:54-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing", "Sliding Window"]
languages: ["Java"]
---

## Description

You are given an array of positive integers `nums` and want to erase a subarray containing unique elements. The score you get by erasing the subarray is equal to the sum of its elements.

Return the **maximum score** you can get by erasing **exactly one** subarray.

An array `b` is called to be a subarray of `a` if it forms a contiguous subsequence of `a`, that is, if it is equal to `a[l],a[l+1],...,a[r]` for some `(l,r)`.

### Example 1:

```
Input: nums = [4,2,4,5,6]
Output: 17
Explanation: The optimal subarray here is [2,4,5,6].
```

### Example 2:

```
Input: nums = [5,2,1,2,5,2,1,2,5]
Output: 8
Explanation: The optimal subarray here is [5,2,1] or [1,2,5].
```

### Constraints:

- `1 <= nums.length <= 10^5`
- `1 <= nums[i] <= 10^4`

## Solution

### Brute Force

In Brute force approach, we can iterate through each element of the `nums` array. Inside this iteration, we still have to iterate through `nums` again to create small windows. In each iteration, we check if these numbers are unique. If they are, add them to `currentSum`. To keep track of unique numbers we have to store them a set so that we can retrieve this in constant time. If we found duplicate, we clear our `set`, modify the `maxSum` and update the `currentSum` to zero. At this point, we can move on to next index position in the inner loop.

```java
class Solution {
    public int maximumUniqueSubarray(int[] nums) {
        int maxSum = 0, currentSum = 0;
        Set<Integer> set = new HashSet<>();
        for (int i = 0; i < nums.length; i++) {
            for (int j = i; j < nums.length; j++) {
                if (set.contains(nums[j])) {
                    set.clear();
                    maxSum = Math.max(maxSum, currentSum);
                    currentSum = 0;
                    break;
                } else {
                    set.add(nums[j]);
                    currentSum += nums[j];
                }
            }
            maxSum = Math.max(maxSum, currentSum);
        }
        return maxSum;
    }
}
```

- Time Complexity: `O(n^2)`
- Space Complexity: `O(n)`


### Using Two pointers with HashSet

In this approach, we start with two pointers `left` and `right` both initialized to index 0. Now, we iterate through each element of `nums` using `right` pointer. Every time we move one position, we have to make sure current window only contains unique numbers. For this, we can store all elements of the window into a set `seen`. As long as it's not present in `seen` set, we keep increasing `right` pointer and adding each number to `currentSum`. Also, each time we increase `currentSum`, we also have to update `maxSum`.

When we find number which is already present in `seen`, we will have to decrease the window by incrementing `left` until that repeated element is removed from the set. For that we increase `left` and decrease `currentSum` as well as from set remove element at `nums[left]`. Now, it's not always going to be the element at index `left` so we have to keep iterating until we have removed that repeated element from the set. Once, that element is removed, we are back to unique elements and we keep increasing `right` pointer again.

```java
class Solution {
    public int maximumUniqueSubarray(int[] nums) {
        int currentSum = 0, maxSum = 0, left = 0;
        Set<Integer> seen = new HashSet<>();
        for (int right = 0; right < nums.length; right++) {
            while (seen.contains(nums[right])) {
                seen.remove(nums[left]);
                currentSum -= nums[left];
                left++;
            }
            seen.add(nums[right]);
            currentSum += nums[right];
            maxSum = Math.max(maxSum, currentSum);

        }
        return maxSum;
    }
}
```

- Time Complexity: We have to iterate through all elements, so time complexity is `O(n)`
- Space Complexity: We might end up having all unique elements in the `nums` array in which case worst case space complexity is `O(n)`
