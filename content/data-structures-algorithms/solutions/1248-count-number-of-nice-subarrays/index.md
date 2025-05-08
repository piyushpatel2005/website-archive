---
title: "1248 Count Number of Nice Subarrays"
date: 2023-12-10T03:28:27-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given an array of integers `nums` and an integer `k`. A continuous subarray is called nice if there are `k` odd numbers on it.

Return the number of nice sub-arrays.

### Example 1:

```
Input: nums = [1,1,2,1,1], k = 3
Output: 2
Explanation: The only sub-arrays with 3 odd numbers are [1,1,2,1] and [1,2,1,1].
```

### Example 2:

```
Input: nums = [2,4,6], k = 1
Output: 0
Explanation: There is no odd numbers in the array.
```

### Example 3:

```
Input: nums = [2,2,2,1,2,2,1,2,2,2], k = 2
Output: 16
```

### Constraints:

- `1 <= nums.length <= 50000`
- `1 <= nums[i] <= 10^5`
- `1 <= k <= nums.length`

## Solution

The solution to this problem is not clearly visible. However, if we convert each number in the input array `nums` to either 0 or 1 depending on whether they are even or odd respectively. Then it becomes relatively easier one. Here, we want to track how many odd numbers, so we have to somehow convert our prefix sum to track that which can be done by converting even numbers to 0 and odd numbers to 1. What we put in prefix sum depends on the constraint we are provided.

Let's work through couple of examples.

Let's take first example.
- `nums = [1, 1, 2, 1, 1]` and `k = 3`
- Convert `nums` into array of 0s and 1s. If the number is even, mark it as `0` else `1`. `[1, 1, 0, 1, 1]`
- Next, calculate the prefix sum for this array. `[1, 2, 2, 3, 4]`
- Now, we have to find subarrays where `k = 3`. So, in this case, we get 2 subarrays which is the output.

Let's take another example.

- `nums = [2,2,2,1,2,2,1,2,2,2]` and  `k = 2`
- convert `nums` to array of 0s and 1s. `[0, 0, 0, 1, 0, 0, 1, 0, 0, 0]`
- Calculate the prefix sum for this arary. `[0, 0, 0, 1, 1, 1, 2, 2, 2, 2]`
- Find count of subarrays where `k = 2`. In this case, we have to first -1 index with value 0 which is not shown in the array above.

```java
class Solution {
    public int numberOfSubarrays(int[] nums, int k) {
        int count = 0, sum = 0;
        Map<Integer, Integer> prefixOddFrequency = new HashMap<>();
        prefixOddFrequency.put(0, 1);
        for (int num: nums) {
            sum += num % 2;
            if (prefixOddFrequency.containsKey(sum - k)) {
                count += prefixOddFrequency.get(sum - k);
            }
            prefixOddFrequency.put(sum, prefixOddFrequency.getOrDefault(sum, 0) + 1);
        }
        return count;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`