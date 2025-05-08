---
title: "1133 Largest Unique Number"
date: 2023-12-22T11:57:23-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing", "Array"]
languages: ["Java"]
---

## Description

Given an integer array `nums`, return the largest integer that only occurs once. If no integer occurs once, return `-1`.

### Example 1:

```
Input: nums = [5,7,3,9,4,9,8,3,1]
Output: 8
Explanation: The maximum integer in the array is 9 but it is repeated. The number 8 occurs only once, so it is the answer.
```

### Example 2:

```
Input: nums = [9,9,8,8]
Output: -1
Explanation: There is no number that occurs only once.
```

### Constraints:

- `1 <= nums.length <= 2000`
- `0 <= nums[i] <= 1000`

## Solution

This problem is again asking for counting the occurrences. So, we can use HashMap or even array to solve this.

### Using Array

We can use array of size 1001 to store the frequency of each number at their respective index position. This way we have to have array as big as the number. In this problem, we are given constraint `0 <= nums[i] <= 1000`, so it can be upto 1000 in value. So, we create an array `counts` of size 1001 which will have indices from 0 to 1000. When finding the largest unique number, we can start from the end because we want largest value, it's likely to be towards the right side of the `counts` array.

```java
class Solution {
    private static final int MAX = 1000;
    public int largestUniqueNumber(int[] nums) {
        if (nums == null || nums.length == 0) {
            return -1;
        }
        int[] counts = new int[MAX + 1];
        for (int num: nums) {
            counts[num]++;
        }
        for (int i = MAX; i >= 0; i--) {
            if (counts[i] == 1) {
                return i;
            }
        }
        return -1;
    }
}
```

- Time Complexity: We are iterating through `n` times or at least `1001` times. So, the time complexity can be `O(k)` where `k` is the largest possible value of `nums[i]` for each `i`.
- Space Complexity: We are creating an array as big as largest possible value in `nums` array. So, space complexity is `O(k)` where `k` is the largest value of `nums` array.

### Using HashMap

Another approach to this problem is to use `HashMap` to store the frequency of occurrences. This will also require two iterations. Once for inserting each value into HashMap and next time, we iterate through HashMap checking for the largest value with frequency 1.

```java
class Solution {
    public int largestUniqueNumber2 (int[] nums) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int num: nums) {
            map.put(num, map.getOrDefault(num, 0) + 1);
        }

        int largestUniqueNumber = -1;
        for (Map.Entry<Integer, Integer> entry: map.entrySet()) {
            if (entry.getValue() == 1) {
                largestUniqueNumber = Math.max(largestUniqueNumber, entry.getKey());
            }
        }
        return largestUniqueNumber;
    }
}
```

- Time Complexity: In this case, we have to iterate through each element of `nums` array. Next, we also iterate through `HashMap` but that will at most be upto `n` size. So, amortized time complexity will be `O(n)`.
- Space Complexity: We are using additional map to store key-value pairs. In worst case, it can be with all unique keys so the space complexity is `O(n)`.
