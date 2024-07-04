---
title: "1512 Number of Good Pairs"
date: 2023-12-27T10:25:09-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given an array of integers `nums`, return the number of good pairs.

A pair `(i, j)` is called good if `nums[i] == nums[j]` and `i < j`.


### Example 1:

```
Input: nums = [1,2,3,1,1,3]
Output: 4
Explanation: There are 4 good pairs (0,3), (0,4), (3,4), (2,5) 0-indexed.
```

### Example 2:

```
Input: nums = [1,1,1,1]
Output: 6
Explanation: Each pair in the array are good.
```

### Example 3:

```
Input: nums = [1,2,3]
Output: 0
```

### Constraints:

- `1 <= nums.length <= 100`
- `1 <= nums[i] <= 100`

## Solution

### Brute Force

The brute force approach would require two iterations through `nums` array. For each given number, check how many times it occurs other than this index position. Everytime we see the number again, we add 1 to `count`.

```java
class Solution {
    public int numIdenticalPairs (int[] nums) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i; j < nums.length; j++) {
                if ((nums[i] == nums[j]) && (i < j)) {
                    count++;
                }
            }
        }
        return count;
    }
}
```

### Using Hashing

This problem is essentially asking us to check how many times, we see number which was already seen before. Now, if we have seen a number 2 times before, that means the current number could form two good pairs. In below code, the number at index position 5 could form two good pairs using `(1, 5)` and `(3,5)`. The number at index position 6 could form 3 good pairs as `(1,6)`, `(3,6)` and `(5,6)`. 

```
 1 3 5 3 2 3 3
```

So, each time, we encounter a number, we have to add how many times we have seen this number before current on to `count` variable. This way we will eventually have number of good pairs count.

```java
class Solution {
    public int numIdentialPairs (int[] nums) {
        Map<Integer, Integer> map = new HashMap<>();
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            count += map.getOrDefault(nums[i], 0);
            map.put(nums[i], map.getOrDefault(nums[i], 0) + 1);
        }
        return count;
    }
}
```

- Time Complexity: `O(n)` since we have to iterate through `nums` array to populate `map` and count good pairs.
- Space Complexity: `O(n)`. In worst case, we may not find any good pairs and all numbers might be unique.