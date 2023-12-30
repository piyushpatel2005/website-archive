---
title: "1207 Unique Number of Occurrences"
date: 2023-12-27T02:51:31-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given an array of integers `arr`, return `true` if the number of occurrences of each value in the array is unique or `false` otherwise.

### Example 1:

```
Input: arr = [1,2,2,1,1,3]
Output: true
Explanation: The value 1 has 3 occurrences, 2 has 2 and 3 has 1. No two values have the same number of occurrences.
```

### Example 2:

```
Input: arr = [1,2]
Output: false
```

### Example 3:

```
Input: arr = [-3,0,1,-3,1,1,1,-3,10,0]
Output: true
```

### Constraints:

- `1 <= arr.length <= 1000`
- `-1000 <= arr[i] <= 1000`

## Solution

In this problem, we need to track the frequency of each number in an array `arr`. To do this, we have to store the frequencies in a map `frequencyMap`. This way we will have a number and the number of times that number occurred in the `arr`. The problem asks us to verify if the values of these map are all unique. In order to do that, as a next step we will have to store the values separately and verify if those values are unique.

In order to check if the values are unique, we can store those values in a `HashSet` data structure in `frequencySet`. We could store one value at a time and check if the value exists already in the set. However, the intuition is that if the values are unique, it's size should be same as the number of keys from the `frequencyMap`. This way the size of `frequencyMap` is same as `frequencySet`, we have all unique occurrences.

```java
class Solution {
    public boolean uniqueOccurrences(int[] arr) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : arr) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
        }
        Set<Integer> frequencySet = new HashSet<>(frequencyMap.values());
        return frequencyMap.size() == frequencySet.size();
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`