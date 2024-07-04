---
title: "0217 Contains Duplicate"
date: 2023-12-26T18:17:33-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given an integer array `nums`, return `true` if any value appears at least twice in the array, and return `false` if every element is distinct.

### Example 1:

```
Input: nums = [1,2,3,1]
Output: true
```

### Example 2:

```
Input: nums = [1,2,3,4]
Output: false
```

### Example 3:

```
Input: nums = [1,1,1,3,3,4,3,2,4,2]
Output: true
```

### Constraints:

- `1 <= nums.length <= 10^5`
- `-10^9 <= nums[i] <= 10^9`

## Solution

### Using Sorting and two pointers

One approach to solve this problem is to first sort the `nums` array and then use two pointers to check if the number is same as next number.

```java
class Solution {
    public boolean containsDuplicate(int[] nums) {
        if (nums == null || nums.length == 0) return false;
        Arrays.sort(nums);
        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] == nums[i + 1])
                return true;
        }
        return false;
    }
}
```

- Time Complexity: `O(n log n)` because of sorting operation on `nums` array
- Space Complexity: `O(1)`

### Using Hash Data structure

The problem requires us to track if the number occurs more than once. We can use HashMap or HashSet to keep track of which numbers we have seen so far. While iterating through `nums` array, we check these hash data structure to check if this number was already seen. If yes, return `false` else at the end of iteration, we return `false`.

```java
class Solution {
    public boolean containsDuplicate(int[] nums) {
        if (nums == null || nums.length == 0) return false;
        Set<Integer> set = new HashSet<>();
        for (int num: nums) {
            if (set.contains(num)) return true;
            set.add(num);
        }
        return false;
    }
}
```

- Time Complexity: `O(n)`. The lookup operation is `O(1)` from this set.
- Space Complexity: `O(n)` because in worst case all elements may be unique and we may end up saving `n` numbers in set.