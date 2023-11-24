---
title: "0014 Longest Common Prefix"
date: 2023-11-11T18:20:48-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["SQL", "Java"]
---

## Description

Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string `""`.

### Example 1:

```
Input: strs = ["flower","flow","flight"]
Output: "fl"
```

### Example 2:

```
Input: strs = ["dog","racecar","car"]
Output: ""
Explanation: There is no common prefix among the input strings.
``` 

### Constraints:

- `1 <= strs.length <= 200`
- `0 <= strs[i].length <= 200`
- `strs[i]` consists of only lowercase English letters.

## Solution

It looks like this requires traversal over all elements of `strs` array and for each string of this array, we need to check each character at a time. If we start traversal from top to bottom, we can check at which stage the character is not present in one of the strings and we can exit at that point. We start by iterating through all characters of first string. Inside, this iteration, we check each of the strings other than first string. If at any point, we have reached end of string or characters for first does not match any of the string's corresponding character, that means we have found the maximum substring and we return that initial matching substring section.
If we finish the iteration and this condition didn't succeed, that means first string itself is the longest common prefix.

```pseudocode
if strs is null OR strs.length == 0
    return ""
first = strs[0]
for (int i = 0; i < first.length(); i++)
    for (int j = 1; j < strs.length; j++)
        if (i == strs[j].length || strs[j].charAt(i) != first.charAt(i))
            return first.substring(0, i)
    return first
```

```java
class Solution {
    public String longestCommonPrefix(String[] strs) {
        if (strs == null || strs.length == 0)
            return "";
        String first = strs[0];
        for (int i = 0; i < first.length(); i++) {
            char c = first.charAt(i);
            for (int j = 1; j < strs.length; j++) {
                if (i == strs[j].length() || strs[j].charAt(i) != c) {
                    return first.substring(0, i);
                }
            }
        }
        return first;
    }
}
```