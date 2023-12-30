---
title: "0791 Custom Sort String"
date: 2023-12-29T18:31:19-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing", "Array"]
languages: ["Java"]
---

## Description

You are given two strings `order` and `s`. All the characters of `order` are unique and were sorted in some custom order previously.

Permute the characters of `s` so that they match the order that `order` was sorted. More specifically, if a character `x` occurs before a character `y` in order, then `x` should occur before `y` in the permuted string.

Return any permutation of `s` that satisfies this property.


### Example 1:

```
Input: order = "cba", s = "abcd"
Output: "cbad"
Explanation: 
"a", "b", "c" appear in order, so the order of "a", "b", "c" should be "c", "b", and "a". 
Since "d" does not appear in order, it can be at any position in the returned string. "dcba", "cdba", "cbda" are also valid outputs.
```

### Example 2:

```
Input: order = "cbafg", s = "abcd"
Output: "cbad"
```

### Constraints:

- `1 <= order.length <= 26`
- `1 <= s.length <= 200`
- `order` and `s` consist of lowercase English letters.
- All the characters of `order` are unique.

## Solution

In this problem essentially, we want to track number of occurrences of characters in `order` string and verify if `s` string contains which of the characters. If those are available, add them to string builder as long as `count > 0`. Once we have run out of characters from `order` string, insert the remaining characters from `s` string.

To track `count` of each character, we can either store them in `Map<Character, Integer>` or an array of size 26 because all characters are lowercase English characters.

### Using HashMap

```java
class Solution {
    public String customSortString (String order, String s) {
        Map<Character, Integer> map = new HashMap<>();
        for (char c : s.toCharArray()) {
            map.put(c, map.getOrDefault(c, 0) + 1);
        }
        StringBuilder sb = new StringBuilder();
        for (char c : order.toCharArray()) {
            while (map.getOrDefault(c, -1) > 0) {
                sb.append(c);
                map.put(c, map.getOrDefault(c, 0) - 1);
            }
        }
        for (char c : map.keySet()) {
            while (map.getOrDefault(c, -1) > 0) {
                sb.append(c);
                map.put(c, map.getOrDefault(c, 0) - 1);
            }
        }
        return sb.toString();
    }
}
```

- Time Complexity: `O(m * n)` where `m = size of order` and `n = length of s`
- Space Complexity: `O(k)` where `k` is the number of unique characters in string `s`.

### Using Array

```java
class Solution {
    public String customSortString(String order, String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        StringBuilder sb = new StringBuilder();
        for (char c : order.toCharArray()) {
            while (count[c - 'a']-- > 0) {
                sb.append(c);
            }
        }

        for (char c = 'a'; c <= 'z'; c++) {
            while (count[c - 'a']-- > 0) {
                sb.append(c);
            }
        }

        return sb.toString();
    }
}
```

- Time Complexity: `O(m * n)` where `m = size of order` and `n = length of s`
- Space Complexity: `O(1)` because we are creating an array of size 26 all the time regardless of size of input.