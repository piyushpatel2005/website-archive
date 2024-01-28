---
title: "0290 Word Pattern"
date: 2023-12-29T18:05:06-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given a `pattern` and a string `s`, find if `s` follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in `pattern` and a non-empty word in `s`.

### Example 1:

```
Input: pattern = "abba", s = "dog cat cat dog"
Output: true
```

### Example 2:

```
Input: pattern = "abba", s = "dog cat cat fish"
Output: false
```

### Example 3:

```
Input: pattern = "aaaa", s = "dog cat cat dog"
Output: false
```

### Constraints:

- `1 <= pattern.length <= 300`
- `pattern` contains only lower-case English letters.
- `1 <= s.length <= 3000`
- `s` contains only lowercase English letters and spaces `' '`.
- `s` does not contain any leading or trailing spaces.
- All the words in `s` are separated by a single space.

## Solution

This problem requires us to map characters of `pattern` string to words of string `s`. As long as both have exact same pattern, they are said to be following same pattern.

First thing, if the `pattern` length is not equal to `s.split(' ')` length then both strings are not following same pattern.
If both are same length then we need to check each character maps to specific word all the time. In order to do that, we have to create a map from `Character` to `String`. This could be done even using an array.

We also have to check from String `s` to `pattern` mapping because otherwise inputs like `s=abba` and `pattern='dog dog dog dog'` will wrongly return `true`.

```java
class Solution {
    private static final int MAX_SIZE = 26;
    public boolean wordPattern (String pattern, String s) {
        String[] words = s.split(" ");
        if (words.length != pattern.length()) {
            return false;
        }

        String[] patternToWord = new String[MAX_SIZE];
        Map<String, Character> wordToPattern = new HashMap<>();
        for (int i = 0; i < pattern.length(); i++) {
            char patternChar = pattern.charAt(i);
            String word = words[i];
            if (patternToWord[patternChar - 'a'] == null && !wordToPattern.containsKey(word)) {
                patternToWord[patternChar - 'a'] = word;
                wordToPattern.put(word, patternChar);
            } else if (patternToWord[patternChar - 'a'] == null && wordToPattern.containsKey(word)) {
                return false;
            } else if (!patternToWord[patternChar - 'a'].equals(word) || wordToPattern.get(word) != patternChar) {
                return false;
            }
        }
        return true;
    }
}
```

- Time Complexity : `O(n)`
- Space Complexity: `O(n)`