---
title: "0560 Subarray Sum Equals K"
date: 2023-12-10T00:49:53-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing", "Prefix Sum", "Preprocessing"]
languages: ["Java"]
---

## Description

Given an array of integers `nums` and an integer `k`, return the total number of subarrays whose sum equals to `k`.

A subarray is a contiguous non-empty sequence of elements within an array.

### Example 1:

```
Input: nums = [1,1,1], k = 2
Output: 2
```

### Example 2:

```
Input: nums = [1,2,3], k = 3
Output: 2
```

### Constraints:

- `1 <= nums.length <= 2 * 10^4`
- `-1000 <= nums[i] <= 1000`
- `-10^7 <= k <= 10^7`

## Solution

The brute force approach would take us very long time as we will have to find all possible subarray combinations and calculate the sum of each subarray by iterating over those subarrays one by one. This would take us `O(n^2)` time complexity.

### Brute Force 

We can optimize this a little bit, if we can find all subarrays and find the ones matching with `sum = k` in the same iteration. Let's see how we can do that. We can use two pointers for doing this where we start `left` and `right` pointers at the `0` index position.

```java
class Solution {
    public int subarraySumBrute(int[] nums, int k) {
        int count = 0;
        for (int left = 0; left < nums.length; left++) {
            for (int right = left + 1; right <= nums.length; right++) {
                int currentSum = 0;
                for (int i = left; i < right; i++) {
                    currentSum += nums[i];
                }
                if (currentSum == k) {
                    count++;
                }
            }
        }
        return count;
    }
}
```

In this case, we keep track of how many subarrays have sum equal to `k` in `count` variable. We start from `left=0` and `right=1` and for each value of `left`, we find all possible subarrays by moving `right` until the end of the array. For each of those subarrays, we calculate `sum` and check if this `sum` matches `k`. If yes, then increment `count` variable else move on to next subarray.

We can improvise this a little bit in that we can find the `currentSum` directly inside the inner loop where we create those subarrays for specific value of `left` position, but that will not change the time complexity.

```java
        for (int left = 0; left < nums.length; left++) {
            int currentSum = 0;
            for (int right = left; right < nums.length; right++) {
                currentSum += nums[right];
                if (currentSum == k) {
                    count++;
                }
            }
        }
```

- Time Complexity: `O(n^2)`
- Space Complexity: `O(1)`

### Better Approach

We can use idea of prefix sum to calculate all subarrays with sum equal to `k`. We start off with first key value pair as `(0, 1)`. Next, for each number in `nums`, we calculate prefix sum and update its frequency. The `nums` array can have positives and negatives, hence we may come across the same prefix sum multiple times depending on how negatives are positioned in `nums` array. At each step, we have to look back in HashMap if we have seen a prefix sum which equals `currentSum - k`. If yes, then that many number of subarrays are already seen before this iteration and we increment the `count` by those many numbers.

```
nums = [1, -1, 3, 4, -2, 3, -1], k = 3
prefixSum = [1, 0, 3, 7, 5, 8, 7]
For each i, j as indices, the sum will be equal to prefixsum[j] - prefixSum[i - 1] where prefixSum[-1]=0
sum = prefixSum[j] - prefixSum[i - 1]
So, for each j, we have to check if we have seen prefixSum[i - 1] - k previously
```

```java
class Solution {
    public int subarraySum(int[] nums, int k) {
        int count = 0, sum = 0;
        Map<Integer, Integer> prefixSumFrequency = new HashMap<>();
        prefixSumFrequency.put(0, 1);
        for (int num: nums) {
            sum += num;
            if (prefixSumFrequency.containsKey(sum - k)) {
                count += prefixSumFrequency.get(sum - k);
            }
            prefixSumFrequency.put(sum, prefixSumFrequency.getOrDefault(sum, 0) + 1);
        }
        return count;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`