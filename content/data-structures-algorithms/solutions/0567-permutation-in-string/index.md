---
title: "0567 Permutation in String"
date: 2023-12-28T13:28:11-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing", "Sliding Window"]
languages: ["Java"]
---

## Description

Given two strings `s1` and s`2`, return `true` if `s2` contains a permutation of `s1`, or `false` otherwise.

In other words, return `true` if one of `s1`'s permutations is the substring of `s2`.

### Example 1:

```
Input: s1 = "ab", s2 = "eidbaooo"
Output: true
Explanation: s2 contains one permutation of s1 ("ba").
```

### Example 2:

```
Input: s1 = "ab", s2 = "eidboaoo"
Output: false
```

### Constraints:

- 1 <= s1.length, s2.length <= 10^4
- `s1` and `s2` consist of lowercase English letters.

## Solution

The problem requires us to check if permutations of `s1` occurs in `s2`, not the other way.

### Using Sorting

One way to solve this is to sort both the strings. Now, we know that we have to check sliding window of size `s1.length()` in the string `s2`. So, we create sliding window of size `s1.length()` from `s2`, sort elements of this substring and verify if those are exactly same as sorted `s1`.

```pseudocode
s1 = sorted s1
for i = 0, i < s2.length - s1.length; i++ 
    if s1 == sorted (s2[i, i + s1.length])
        return true
    return false
```

```java
class Solution {
    public boolean checkInclusion (String s1, String s2) {
        if (s1.length() > s2.length())
            return false;
        String sortedS1 = sort(s1);
        String substringS2 = "";
        for (int i = 0; i <= s2.length() - s1.length(); i++) {
            substringS2 = sort(s2.substring(i, i + s1.length())); // This doesn't sace space
            if (sortedS1.equals(substringS2)) {
                return true;
            }
        }
        return false;
    }

    private String sort(String input) {
        char[] chars = input.toCharArray();
        Arrays.sort(chars);
        return new String(chars);
    }
}
```

- Time Complexity: `O(n1 log n1) + (n2 - n1)(n1 log n1)` where `n1 = length of s1` and `n2 = length of s2`. This is because sorting of array `s1` takes `O(n1 log n1)`. Next we iterate for upto `n2 - n1` times and each iteration requires sorting of substring which is of length `n1`.
- Space Complexity: `O(n1)`

### Using HashMap

The array `s1` is permutation of substring of `s2`. If both of them have same characters for same frequency. So, we can use `HashMap` to track each character frequency. First we find out frequency of characters of `s1`. Next, we iterate through characters of `s2` with each iteration considering window of length `s1.length`.

```java
class Solution {
    public boolean checkInclusion (String s1, String s2) {
        if (s1.length() > s2.length())
            return false;
        Map<Character, Integer> s1Map = new HashMap<>();

        // create map of s1
        for (char c : s1.toCharArray()) {
            s1Map.put(c, s1Map.getOrDefault(c, 0) + 1);
        }
        for (int left = 0; left <= s2.length() - s1.length(); left++) {
            Map<Character, Integer> s2Map = new HashMap<>();

            // create map of substring of s2
            int right = left;
            while (right < left + s1.length()) {
                char c = s2.charAt(right);
                s2Map.put(c, s2Map.getOrDefault(c, 0) + 1);
                right++;
            }
            
            // check both maps are equal
            if (areMapEqual(s1Map, s2Map)) {
                return true;
            }
        }
        return false;
    }

    private boolean areMapEqual(Map<Character, Integer> map1, Map<Character, Integer> map2) {
        for (char c : map1.keySet()) {
            if (map1.get(c) != map2.getOrDefault(c, -1)) {
                return false;
            }
        }
        return true;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`

### Using Array to store frequency

Instead of using `HashMap`, we could also use array to store number of times each character occurs. Because the problem constraint states that each character is lowercase English alphabetic character, we have to allocate array of size 26.

```java
class Solution {
    public boolean checkInclusion (String s1, String s2) {
        if (s1.length() > s2.length())
            return false;
        int[] s1Array = new int[ARRAY_SIZE];

        // create map of s1
        for (char c : s1.toCharArray()) {
            s1Array[c - 'a']++;
        }
        for (int left = 0; left <= s2.length() - s1.length(); left++) {
            int[] s2Array = new int[ARRAY_SIZE];

            // create map of substring of s2
            int right = left;
            while (right < left + s1.length()) {
                char c = s2.charAt(right);
                s2Array[c - 'a'] = s2Array[c - 'a'] + 1;
                right++;
            }

            // check both maps are equal
            if (Arrays.equals(s1Array, s2Array)) {
                return true;
            }
        }
        return false;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)` because we allocate array of size 26.