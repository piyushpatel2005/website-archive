---
title: "1657 Determine if Two Strings Are Close"
date: 2023-12-30T12:02:22-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing", "Array"]
languages: ["Java"]
---

## Description

Two strings are considered close if you can attain one from the other using the following operations:

- Operation 1: Swap any two existing characters.
    - For example, `abcde -> aecdb`
- Operation 2: Transform every occurrence of one existing character into another existing character, and do the same with the other character.
    - For example, `aacabb -> bbcbaa` (all `a`'s turn into `b`'s, and all `b`'s turn into `a`'s)

You can use the operations on either string as many times as necessary.

Given two strings, `word1` and `word2`, return `true` if `word1` and `word2` are close, and `false` otherwise.

### Example 1:

```
Input: word1 = "abc", word2 = "bca"
Output: true
Explanation: You can attain word2 from word1 in 2 operations.
Apply Operation 1: "abc" -> "acb"
Apply Operation 1: "acb" -> "bca"
```

### Example 2:

```
Input: word1 = "a", word2 = "aa"
Output: false
Explanation: It is impossible to attain word2 from word1, or vice versa, in any number of operations.
```

### Example 3:

```
Input: word1 = "cabbba", word2 = "abbccc"
Output: true
Explanation: You can attain word2 from word1 in 3 operations.
Apply Operation 1: "cabbba" -> "caabbb"
Apply Operation 2: "caabbb" -> "baaccc"
Apply Operation 2: "baaccc" -> "abbccc"
```

### Constraints:

- `1 <= word1.length, word2.length <= 10^5`
- `word1` and `word2` contain only lowercase English letters.

## Solution 

To solve this, we cannot perform operation 1 and 2 on each character because that would be very time consuming. This problem allows us to swap two existing characters with each other and we can also transform one character occurrence with one of the existing ones to form the same string. This means 

1. If we ignore character frequency, both words `word1` and `word2` must have same characters.
2. The frequency of all characters will be same. That is in first example, `word1 = 'abc'` and `word2 = 'bca'`, the frequency of each of the three characters is 1. In example 3 above, `word1 = "cabbba"` and `word2 = "abbccc"`. In thi case, there is one character with frequency 1, one with frequency of 2 and one with frequency of 3 in both words.

### Using HashMap

To check the frequency of each of the characters, we have to store them somewhere. We could use `HashMap` to store those.

```java
class Solution {
    public boolean closeStrings (String word1, String word2) {
        if (word1.length() != word2.length())
            return false;
        Map<Character, Integer> map1 = new java.util.HashMap<>();
        Map<Character, Integer> map2 = new java.util.HashMap<>();
        for (int i = 0; i < word1.length(); i++) {
            map1.put(word1.charAt(i), map1.getOrDefault(word1.charAt(i), 0) + 1);
            map2.put(word2.charAt(i), map2.getOrDefault(word2.charAt(i), 0) + 1);
        }
        // all characters should be same, keySet should be same
        if (!map1.keySet().equals(map2.keySet()))
            return false;
        // all frequencies should match regardless of the key
        List<Integer> list1 = new ArrayList<>(map1.values());
        List<Integer> list2 = new ArrayList<>(map2.values());
        list1.sort((a, b) -> a - b);
        list2.sort((a, b) -> a - b);
        return list1.equals(list2);
    }
}
```

- Time Complexity: `O(n)` where `n` is length of `word1`
- Space Complexity: In worst case, we might need to store 26 keys. So, space complexity is `O(1)`.

### Using Array

The problem states that each of the character is lowercase English alphabetic character. So, we can store the frequencies in an array of 26 size.

```java
class Solution {
    private static final int ARRAY_SIZE = 26;

    public boolean closeStrings (String word1, String word2) {
        if (word1.length() != word2.length())
            return false;
        int[] arr1 = new int[ARRAY_SIZE];
        int[] arr2 = new int[ARRAY_SIZE];
        for (int i = 0; i < word1.length(); i++) {
            arr1[word1.charAt(i) - 'a']++;
            arr2[word2.charAt(i) - 'a']++;
        }
        // all characters should be same, keySet should be same
        for (int i = 0; i < ARRAY_SIZE; i++) {
            if ((arr1[i] == 0 && arr2[i] != 0) || (arr1[i] != 0 && arr2[i] == 0))
                return false;
        }
        // all frequencies should match regardless of the key
        Arrays.sort(arr1);
        Arrays.sort(arr2);
        return Arrays.equals(arr1, arr2);
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)` due to array size being fixed regardless of input.