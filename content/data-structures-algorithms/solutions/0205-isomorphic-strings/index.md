---
title: "0205 Isomorphic Strings"
date: 2023-12-29T17:27:07-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing", "Array"]
languages: ["Java"]
---

## Description

Given two strings `s` and `t`, determine if they are *isomorphic*.

Two strings `s` and `t` are isomorphic if the characters in `s` can be replaced to get `t`.

All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character, but a character may map to itself.

### Example 1:

```
Input: s = "egg", t = "add"
Output: true
```

### Example 2:

```
Input: s = "foo", t = "bar"
Output: false
```

### Example 3:

```
Input: s = "paper", t = "title"
Output: true
```

### Constraints:

- `1 <= s.length <= 5 * 10^4`
- `t.length == s.length`
- `s` and `t` consist of any valid ascii character.

## Solution

### Using HashMap

One way to solve this could be using `HashMap`. If we keep first string `s` characters as key and second string `t` characters as values. We have to make sure that each time the same character maps to same value and we have to make sure the mapping from `s` to `t` and also the other way around from `t` to `s` characters.

```java
class Solution {
    public boolean isIsomorphic(String s, String t) {
        Map<Character, Character> mapSToT = new HashMap<>();
        Map<Character, Character> mapTToS = new HashMap<>();
        for (int i = 0; i < s.length(); i++ ) {
            char sChar = s.charAt(i);
            char tChar = t.charAt(i);
            if (!mapSToT.containsKey(sChar) && !mapTToS.containsKey(tChar)) {
                mapSToT.put(sChar, tChar);
                mapTToS.put(tChar, sChar);
            } else if (mapSToT.containsKey(sChar) && mapTToS.containsKey(tChar)) {
                if (mapSToT.get(sChar) != tChar || mapTToS.get(tChar) != sChar) {
                    return false;
                }
            } else { // one map contains key but other does not.
                return false;
            }
        }
        return true;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(i + j)` where `i` is number of unique characters in string `s` and `j` unique characters in `t`.

### Using Array

The problem states that the strings contain valid ascii characters. That means there can be one of 0-256 characters to represent these ascii characters. We could use array to store the mapping from `s` to `t` and vice a versa.
Now, arrays by default have value of 0 which is actually valid ascii character. So, we have to change the arrays to default value of -1.

```java
class Solution {
    private static final int ARRAY_SIZE = 256;

    public boolean isIsomorphic (String s, String t) {
        int[] mapSToT = new int[ARRAY_SIZE];
        int[] mapTToS = new int[ARRAY_SIZE];

        Arrays.fill(mapSToT, -1);
        Arrays.fill(mapTToS, -1);

        for (int i = 0; i < s.length(); i++) {
            char sChar = s.charAt(i);
            char tChar = t.charAt(i);
            if (mapSToT[sChar] == -1 && mapTToS[tChar] == -1) {
                mapSToT[sChar] = tChar;
                mapTToS[tChar] = sChar;
            } else if (mapSToT[sChar] != tChar || mapTToS[tChar] != sChar) {
                return false;
            }
        }
        return true;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)` as it is fixed as 256 characters each in both arrays.