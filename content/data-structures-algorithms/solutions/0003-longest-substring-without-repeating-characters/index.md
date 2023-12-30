---
title: "0003 Longest Substring Without Repeating Characters"
date: 2023-12-25T02:19:03-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing", "Sliding Window"]
languages: ["Java"]
---

## Description

Given a string `s`, find the length of the longest substring without repeating characters.

### Example 1:

```
Input: s = "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.
```

### Example 2:

```
Input: s = "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.
```

### Example 3:

```
Input: s = "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3.
Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
```

### Constraints:

- 0 <= s.length <= 5 * 10^4
- `s` consists of English letters, digits, symbols and spaces.

## Solution

In this case, we can create a sliding window until we have found repeating character. The problem asks to make sure that we do not repeat the same character. To make sure we don't do that, we have to save those somewhere like HashMap or HashSet so that lookup is quick. When we come across a character which is repeating, our window becomes invalid.

```java
class Solution {
    public int lengthOfLongestSubstring(String s) {
        if (s == null || s.length() == 0) return 0;
        int maxLength = 0;
        int start = 0, end = 0;
        Set<Character> set = new HashSet<>();
        while (end < s.length()) {
            if (!set.contains(s.charAt(end))) {
                set.add(s.charAt(end));
                end++;
                maxLength = Math.max(maxLength, set.size());
            } else {
                set.remove(s.charAt(start));
                start++;
            }
        }
        return maxLength;
    }
}
```