---
title: "1208 Get Equal Substrings Within Budget"
date: 2023-10-23T18:17:41-04:00
draft: true
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Sliding Window"]
languages: ["Java"]
---

## Description

You are given two strings `s` and `t` of the same length and an integer maxCost.

You want to change `s` to `t`. Changing the `i`th character of `s` to `i`th character of `t` costs `|s[i] - t[i]|` (i.e., the absolute difference between the ASCII values of the characters).
Return the maximum length of a substring of `s` that can be changed to be the same as the corresponding substring of `t` with a cost less than or equal to `maxCost`. If there is no substring from `s` that can be changed to its corresponding substring from `t`, return `0`.

### Example 1:

**Input:** `s = "abcd"`, `t = "bcdf"`, `maxCost = 3`

**Output:** `3`

**Explanation:** "abc" of s can change to "bcd".
That costs 3, so the maximum length is 3.

### Example 2:

**Input:** `s = "abcd"`, `t = "cdef"`, `maxCost = 3`

**Output:** `1`

**Explanation:** Each character in s costs 2 to change to character in t,  so the maximum length is 1.

### Example 3:

**Input:** `s = "abcd"`, `t = "acde"`, `maxCost = 0`

**Output:** 1

**Explanation:** You cannot make any change, so the maximum length is 1.

### Constraints:

- `1 <= s.length <= 10^5`
- `t.length == s.length`
- `0 <= maxCost <= 10^6`
- `s` and `t` consist of only lowercase English letters.

## Solution

To simply this problem, we can iterate through each elements of `s` and `t` to find difference between respective character of each of those strings. We will store those differences in new array called `differences`. This way we will get an array of integers. Now, the problem becomes something like find maximum sum of `differences` such that the sum of subarray is less than or equal to `maxCost`. Even though in this case, we will be iterating same size array twice, the amortized time complexity will be `O(n)`.

```markdown
initialize new array 'differences' with same size as s
for i = 0; i < s.length(); i++
    differences[i] = s[i] - t[i]
int left = currentSum = 0
int maxLength = 0
for right = 0; right < differences.length; right++
    currentSum += differences[right]
    if currrentSum <= maxCost
        maxLength = max of maxLength and (right - left + 1)
    while currentLength > maxCost
        currentLength = differences[left]
        left--
return maxLength   
```

In this case, after finding the `differences` array, the array becomes invalid if `currentSum > maxCost`. So, we need to track `currentSum` and we want to find `maxLength`, so every time we have to check if length is more than current `maxLength` and if it is modify to new `maxLength`.

```java
class Solution {
    public int equalSubstring(String s, String t, int maxCost) {
        int[] differences = new int[s.length()];
        for (int i = 0; i < s.length(); i++) {
            differences[i] = Math.abs(s.charAt(i) - t.charAt(i));
        }
        // find max subarray such that sum of elements is less than or equal to maxCost
        int left = 0, maxLength = 0, currentSum = 0;
        for (int right = 0; right < differences.length; right++) {
            currentSum += differences[right];
            if (currentSum <= maxCost) {
                maxLength = Math.max(maxLength, right - left + 1);
            }
            while (currentSum > maxCost) {
                currentSum -= differences[left];
                left++;
            }
        }
        return maxLength;
    }
}
```