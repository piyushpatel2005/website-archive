---
title: "0392 Is Subsequence"
date: 2023-10-17T11:23:47-04:00
draft: true
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

## Description 
Given two strings `s` and `t`, return `true` if `s` is a subsequence of `t`, or `false` otherwise.

A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).

### Example 1:

**Input:** `s = "abc"`, `t = "ahbgdc"`

**Output:** `true`

### Example 2:

**Input:** `s = "axc"`, `t = "ahbgdc"`

**Output:** `false`
 

### Constraints:

`0 <= s.length <= 100`

`0 <= t.length <= 10^4`

`s` and `t` consist only of lowercase English letters.

## Solution

For the solution of this problem. We know that we have to find all characters of the substring `s` in the string `t`. So, we can start iterating characters of both strings. If we find the match of characters, we know that we found one of the characters from string `s`, so we increment its index position and start looking for next character. When we find next character, we will increment this counter again and so on until we run out of all characters from either of the strings. In this case, either we have found all characters or not. To decide whether, we have found all characters, we can check if the index position of `i` is same as length of substring `s` using `i == sChars.length`.


```java
class Solution {
    public boolean isSubsequence(String s, String t) {
        if (s == null || t == null)
            return false;
        if ((s.length() == 0) || (t.length() == 0))
            return true;
        int i = 0, j = 0;
        char[] sChars = s.toCharArray();
        char[] tChars = t.toCharArray();
        while (i < sChars.length && j < tChars.length) {
            if (sChars[i] == tChars[j]) {
                i++; // check for next character in s
            }
            j++; // we have to increment j, no matter it maches or not.
        }
        return i == sChars.length; // if we have exhausted all character of s, then it is subsequence of t.
    }
}
```

Another similar problem to this might be to find exact subsequence. In this case, we cannot have any other characters in between. This problem might be easier once we have seen above problem.

```java
class Solution {
    public boolean isExactSubsequence(String s, String t) {
        if (s == null || t == null)
            return false;
        if ((s.length() == 0) || (t.length() == 0))
            return true;
        int i = 0, j = 0;
        char[] sChars = s.toCharArray();
        char[] tChars = t.toCharArray();
        while (i < sChars.length && j < tChars.length) {
            if (sChars[i++] != tChars[j++]) {
                return false;
            }
        }
        return true;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`
 
**Follow up:** Suppose there are lots of incoming `s`, say `s1, s2, ..., sk` where `k >= 10^9`, and you want to check one by one to see if `t` has its subsequence. In this scenario, how would you change your code?