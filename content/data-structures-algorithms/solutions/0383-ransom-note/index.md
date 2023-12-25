---
title: "0383 Ransom Note"
date: 2023-12-24T03:49:31-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing", "Array"]
languages: ["Java"]
---

## Description

Given two strings `ransomNote` and `magazine`, return `true` if `ransomNote` can be constructed by using the letters from `magazine` and `false` otherwise.

Each letter in `magazine` can only be used once in `ransomNote`.


### Example 1:

```
Input: ransomNote = "a", magazine = "b"
Output: false
```

### Example 2:

```
Input: ransomNote = "aa", magazine = "ab"
Output: false
```

### Example 3:

```
Input: ransomNote = "aa", magazine = "aab"
Output: true
``` 

### Constraints:

- `1 <= ransomNote.length, magazine.length <= 10^5`
- `ransomNote` and `magazine` consist of lowercase English letters.

## Solution

This problem is again similar to calculating the number of times a given character in `ransomNote` occurs and check if we have all charactesr in `magazine` or if those are more than once, then check how many times they are in `magazine`.

### Using Array

This can be solved using arrays. The problem states that all chracters are lowercase English characters. Therefore, we can store the occurrences for those characters in an array of size 26, where index 0 stores frequency of 'a' and so on. When we have a character appearing more than once, we have to validate that we have enough frequency for that character.

```java
class Solution {
    public boolean canConstruct(String ransomNote, String magazine) {
        int[] charCounts = new int[26];
        for (char c: magazine.toCharArray()) {
            charCounts[c - 'a']++;
        }
        for (char c: ransomNote.toCharArray()) {
            charCounts[c - 'a']--;
            if (charCounts[c - 'a'] < 0) {
                return false;
            }
        }
        return true;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)` because, it can have upto 26 cells in an array.

### Using HashMap

In this case, we store the frequency of characters in a Hash map.

```java
class Solution {
    public boolean canConstruct (String ransomNote, String magazine) {
        Map<Character, Integer> charCounts = new HashMap<>();
        for (char c: magazine.toCharArray()) {
            charCounts.put(c, charCounts.getOrDefault(c, 0) + 1);
        }
        for (char c: ransomNote.toCharArray()) {
            charCounts.put(c, charCounts.getOrDefault(c, 0) - 1);
            if (charCounts.get(c) < 0) {
                return false;
            }
        }
        return true;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)` because at worst case, it can have at most 26 unique keys for each of the lowercase English characters.