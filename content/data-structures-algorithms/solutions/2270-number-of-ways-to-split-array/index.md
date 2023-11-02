---
title: "2270 Number of Ways to Split Array"
date: 2023-10-26T12:08:33-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Preprocessing", "Prefix Sum"]
languages: ["Java"]
---

## Description

You are given a 0-indexed integer array `nums` of length `n`.

`nums` contains a valid split at index `i` if the following are true:

The sum of the first `i + 1` elements is greater than or equal to the sum of the last `n - i - 1` elements.
There is at least one element to the right of `i`. That is, `0 <= i < n - 1`.
Return the number of valid splits in `nums`.

### Example 1:

**Input:** nums = [10,4,-8,7]

**Output:** `2`

**Explanation:**
There are three ways of splitting `nums` into two non-empty parts:
- Split nums at index 0. Then, the first part is [10], and its sum is 10. The second part is [4,-8,7], and its sum is 3. Since `10 >= 3`, `i = 0` is a valid split.
- Split nums at index 1. Then, the first part is [10,4], and its sum is 14. The second part is [-8,7], and its sum is -1. Since `14 >= -1`, `i = 1` is a valid split.
- Split nums at index 2. Then, the first part is [10,4,-8], and its sum is 6. The second part is [7], and its sum is 7. Since `6 < 7`, `i = 2` is not a valid split.
Thus, the number of valid splits in nums is 2.

### Example 2:

**Input:** `nums = [2,3,1,0]`

**Output:** `2`

**Explanation:** 
There are two valid splits in nums:
- Split nums at index 1. Then, the first part is [2,3], and its sum is 5. The second part is [1,0], and its sum is 1. Since `5 >= 1`, `i = 1` is a valid split. 
- Split nums at index 2. Then, the first part is [2,3,1], and its sum is 6. The second part is [0], and its sum is 0. Since `6 >= 0`, `i = 2` is a valid split.
 
### Constraints:

- `2 <= nums.length <= 10^5`
- `-10^5 <= nums[i] <= 10^5`

## Solution

A brute force approach for this would require two iterations at least.

```pseudocode
validSplitCount = 0
for i = 0; i < nums.length; i++
    find sum of left section[0, i]
    find sum of right section[i+1, nums.length]
    if leftSum greater than rightSum
        validSplitCount += 1
```

In this case, we need sum of two subarrays in each iteration. Can we store them in pre-processed array so that we can retrieve it in `O(1)` time complexity?

```pseudocode
validSplit = 0
int[] sums = new int[nums.length]
sums[0] = nums[0]
for int i = 1; i less than nums.length; i++
    sums[i] = sums[i - 1] + nums[i]
for int i = 1; i less than nums.length - 1; i++
    leftSum = sums[i]
    rightSum = sum[nums.length - 1] - sums[i]
    if leftSum greater than or equal to rightSum
        validSplit += 1
```

The implementation for above pseudocode would be something like this in Java.

```java
class Solution {
    public int waysToSplitArray(int[] nums) {
        int validWays = 0;
        int[] sums = new int[nums.length];
        sums[0] = nums[0];
        for (int i = 1; i < sums.length; i++) {
            sums[i] = sums[i - 1] + nums[i];
        }
        for (int i = 0; i < nums.length - 1; i++) {
            long leftSum = sums[i];
            long rightSum = sums[nums.length - 1] - sums[i];
            if (leftSum >= rightSum) {
                validWays += 1;
            }
        }
        return validWays;
    }
}
```
In this approach, we are iterating the original array twice but as indepedent iterations. So, the time complexity will still be `O(n)`. This problem approach we are solving by creating new pre-processed array of size `n`. So, space complexity is `O(n)`. However, because we are looking at two consecutive subarrays, we may not need this additional space.

The better approach might be something like this.

- Initialize `leftSum = nums[0]` and `rightSum = 0` variable and `validCounts` to keep track of sum of all elements and count of valid subarrays.
- First find the sum of all elements as `rightSum`.
- Iterate through all elements of `nums` and at each iteration, for `leftSum` we add new element `nums[i]` and for `rightSum` we remove `nums[i]` from `rightSum`.
- Check if it's valid, if valid add 1 to `validCounts`

```pseudocode
validCounts = rightSum = 0
leftSum = nums[0]
for num in nums
    rightSum += num
for i = 1; i < nums.length - 1; i++
    leftSum = leftSum + nums[i]
    rightSum = rightSum - nums[i]
    if leftSum greater than or equal to rightSum
        validCounts += 1
return validCounts  
```

```java
class Solution {
    public int waysToSplitArray(int[] nums) {
        long leftSum = 0;
        long rightSum = 0;
        int validWays = 0;
        for (int num: nums) {
            rightSum += num;
        }
        for (int i = 0; i < nums.length - 1; i++) {
            rightSum -= nums[i];
            leftSum += nums[i];
            if (leftSum >= rightSum) {
                validWays++;
            }
        }
        return validWays;
    }
}
```


This solution uses constant space, so space complexity improves to `O(1)`.