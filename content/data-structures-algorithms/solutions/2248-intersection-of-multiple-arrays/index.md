---
title: "2248 Intersection of Multiple Arrays"
date: 2023-12-09T14:41:35-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given a 2D integer array `nums` where `nums[i]` is a non-empty array of distinct positive integers, return the list of integers that are present in each array of `nums` sorted in ascending order.
 
### Example 1:

```
Input: nums = [[3,1,2,4,5],[1,2,3,4],[3,4,5,6]]
Output: [3,4]
Explanation: The only integers present in each of nums[0] = [3,1,2,4,5], nums[1] = [1,2,3,4], and nums[2] = [3,4,5,6] are 3 and 4, so we return [3,4].
```

### Example 2:

```
Input: nums = [[1,2,3],[4,5,6]]
Output: []
Explanation: There does not exist any integer present both in nums[0] and nums[1], so we return an empty list [].
```

### Constraints:

- `1 <= nums.length <= 1000`
- `1 <= sum(nums[i].length) <= 1000`
- `1 <= nums[i][j] <= 1000`
- All the values of `nums[i]` are unique.

## Solution

This problem has constraint that each of the numbers are less than 1001. This means we can store them in an array of size `1001` where each element at a specific index will be the one from input array. Now, we iterate through the input array `nums` and update the frequency in our newly created array `count`. Once we have iterated through all elements of the `nums` array, the frequency for the common elements in the `count` array will be equal to `nums.length`. This gives us advantage in that we don't have to sort the result before inserting into output linked list. However, the problem with this approach is that even if we have let's say only 3 elements in each array of `nums`, we will end up creating this `count` array of size 1001. If there was constraint that each element can be up to 100000, then this solution would become prohibitively expensive in terms of space complexity.

```java
class Solution {
    public List<Integer> intersection(int[][] nums) {
        if (nums == null || nums.length == 0) {
            return null;
        }
        int[] count = new int[1001];
        List<Integer> result = new ArrayList<>();
        int length = nums.length;
        // Add count of each of the element. This can grow up to 1000 because max size is 1000
        for (int i = 0; i < length; i++) {
            for (int j = 0; j < nums[i].length; j++) {
                count[nums[i][j]]++;
            }
        }
        for (int i = 0; i < 1001; i++) {
            if (count[i] == length) {
                result.add(i);
            }
        }
        return result;
    }
}
```

Another option is to use `HashMap` to store the frequency. This gives us advantage that we will end up having only as many keys as the number of unique elements in `nums` array. This saves us in terms of space complexity. However, at the end once we have inserted all frequencies, we will still have to sort the keys of this HashMap because the problem has asked us to return the output in the ascending order which adds a bit of time complexity.

```java
class Solution {
    public List<Integer> intersection(int[][] nums) {
        if (nums == null || nums.length == 0)
            return null;
        Map<Integer, Integer> map = new HashMap<>();
        List<Integer> result = new ArrayList<>();
        int length = nums.length;
        // Add count of each of the element. This can grow up to 1000 because max size is 1000
        for (int i = 0; i < length; i++) {
            for (int j = 0; j < nums[i].length; j++) {
                map.put(nums[i][j], map.getOrDefault(nums[i][j], 0) + 1);
            }
        }
        for (int i = 0; i < 1001; i++) {
            if (map.getOrDefault(i, 0) == length) {
                result.add(i);
            }
        }
        return result;
    }
}
```

- Time Complexity: `O(m x n)`
- Space Complexity: `O(1)` because at most we can have upto 1000 keys stored in HashMap.