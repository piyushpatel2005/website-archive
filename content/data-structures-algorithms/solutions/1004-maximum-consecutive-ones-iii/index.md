---
title: "1004 Maximum Consecutive Ones Iii"
date: 2023-10-22T00:36:41-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Sliding Window"]
languages: ["Java"]
---

## Description

Given a binary array `nums` and an integer `k`, return the maximum number of consecutive `1`'s in the array if you can flip at most `k` 0's.

### Example 1:

**Input:** `nums = [1,1,1,0,0,0,1,1,1,1,0]`, `k = 2`

**Output:** `6`

**Explanation:** `[1,1,1,0,0,1,1,1,1,1,1]`
Bolded numbers were flipped from 0 to 1.

### Example 2:

**Input:** `nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1]`, `k = 3`

**Output:** `10`

**Explanation:** `[0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1]`
Bolded numbers were flipped from 0 to 1.
 
### Constraints:

- `1 <= nums.length <= 10^5`
- `nums[i]` is either 0 or 1.
- `0 <= k <= nums.length`

## Solution

In this case, it's mentioned that we can flip `k` numbers to achieve maximum subarray of 1's. In a sense, we can say that we are looking for longest subarray which contains at most `k` 0's. Now, this problem becomes similar to sliding window problem where we can have two pointers, `left` and `right`. `right` pointer moves forward keeping track of largest subarray. In this case, subarray becomes invalid when numbers of 0's become more than `k`. In this at every point, we can find the current number of 1's using `(right - left) + 1`. We also keep track of zero count, because we are allowed to flip `k` zeroes.

```markdown
left = right = zeroCount = 0
maxCount = minimum value
while (right less than nums.length)
    if nums[right] equal to 0
        zeroCount++
    while zeroCount > k
        if nums[left] == 0
            zeroCount--
        left++
    maxCount = max of maxCount and (right - left) + 1
    right++
return maxCount
```

Alternatively, we can use for loop for `right` pointer.

```markdown
left = zeroCount = 0
maxCount = minimum value possible
for (right = 0; right less than nums.length; right++)
    if nums[right] is 0
        zeroCount++
    while zeroCount > k
        if nums[left] == 0
            zeroCount--
        left++
    maxCount = max of maxCount and (right - left + 1)
return maxCount
```

This algorithm implemention looks like this in Java.

```java
class Solution {
    public int longestOnes(int[] nums, int k) {
        int left = 0, zeroCount = 0;
        int maxCount = Integer.MIN_VALUE;
        for (int right = 0; right < nums.length; right++) {
            if (nums[right] == 0) {
                zeroCount++;
            }
            while (zeroCount > k) {
                if (nums[left] == 0)
                    zeroCount--;
                left++;
            }
            maxCount = Math.max(maxCount, right - left + 1);
        }
        return maxCount;
    }
}
```