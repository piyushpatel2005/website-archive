---
title: "0340 Longest Substring With at Most K Distinct Characters"
date: 2023-12-04T23:24:37-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing", "Sliding Window"]
languages: ["Java"]
---

## Description

Given a string `s` and an integer `k`, return the length of the longest 
substring of `s` that contains at most `k` distinct characters.

### Example 1:

```
Input: s = "eceba", k = 2
Output: 3
Explanation: The substring is "ece" with length 3.
```

### Example 2:

```
Input: s = "aa", k = 1
Output: 2
Explanation: The substring is "aa" with length 2.
```

### Constraints:

- `1 <= s.length <= 5 * 10^4`
- `0 <= k <= 50`

## Solution

This solution uses sliding window technique with hashing data structure. The idea is that we need to find distinct string count. For this we use HashMap to store the unique keys. When the key count increases above `k`, we know our window is invalid. At this point, we have to make the window valid again, so we remove keys one by one. Every time, we check if the current window is larger than previously seen window. If it is, then that will be the longest substring.

```java
class Solution {
    public int lengthOfLongestSubstringKDistinct(String s, int k) {
        int left = 0, right = 0, max = 0;
        Map<Character, Integer> map = new HashMap<>();
        while (right < s.length()) {
            char c = s.charAt(right);
            map.put(c, map.getOrDefault(c, 0) + 1);
            // When window becomes invalid, start contracting
            while (map.size() > k) {
                char leftChar = s.charAt(left);
                map.put(leftChar, map.get(leftChar) - 1);
                if (map.get(leftChar) == 0) {
                    map.remove(leftChar);
                }
                left++;
            }
            max = Math.max(max, right - left + 1);
            right++;
        }
        return max;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(k)`