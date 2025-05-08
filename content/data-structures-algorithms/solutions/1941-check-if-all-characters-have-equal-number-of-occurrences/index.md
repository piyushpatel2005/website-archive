---
title: "1941 Check if All Characters Have Equal Number of Occurrences"
date: 2023-12-09T15:38:42-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given a string `s`, return `true` if s is a good string, or `false` otherwise.

A string `s` is good if all the characters that appear in `s` have the same number of occurrences (i.e., the same frequency).

### Example 1:

```
Input: s = "abacbc"
Output: true
Explanation: The characters that appear in s are 'a', 'b', and 'c'. All characters occur 2 times in s.
```

### Example 2:

```
Input: s = "aaabb"
Output: false
Explanation: The characters that appear in s are 'a' and 'b'.
'a' occurs 3 times while 'b' occurs 2 times, which is not the same number of times.
```

### Constraints:

- `1 <= s.length <= 1000`
- `s` consists of lowercase English letters.

## Solution

This problem clearly asks us to find the frequency of each character. If the frequency of each character is same, then we return true. This means this problem definitely needs `HashMap` to store the frequencies. This is straight forward solution.

```java
class Solution {
    public boolean areOccurrencesEqual2(String s) {
        if (s == null || s.length() == 0) {
            return true;
        }
        Map<Character, Integer> frequency = new HashMap<>();
        for (char c: s.toCharArray()) {
            frequency.put(c, frequency.getOrDefault(c, 0) + 1);
        }
        int occurrences = frequency.get(s.charAt(0));
        for (Map.Entry<Character, Integer> entry: frequency.entrySet()) {
            if (entry.getValue() != occurrences) {
                return false;
            }
        }
        return true;
    }
}
```

- Time Complexity: `O(n)` because we need to iterate through at most `n` characters of the string `s`.
- Space Complexity: `O(1)` because at most we can have 26 keys in the `frequency` map.

Now, if we think about it, it can also be solved using arrays because all characters are lowercase English characters, that means we need to store up to 26 characters which is fair for storing them in an array of fixed size. The first iteration would allow us to store the frequency of each character in their respective index position in the array. In next small iteration, we are looking for first character frequency, so as soon as we find a frequency count which is non-zero (the default for integer array), that will be the frequecy of the first chracter. Next, we need to iterate through this `count` array to make sure all non-zero entries match this frequency we found for the first character. If not, we found at least one entry that did not match the frequency and hence we return `false`. At the end of the loop, if no such entries found, that means all entries have same frequency and we return `true`.


```java
class Solution {
    public boolean areOccurrencesEqual(String s) {
        if (s == null || s.length() == 0) {
            return true;
        }
        int[] count = new int[MAX_SIZE];
        // create array with default values as 0
        for (char c: s.toCharArray()) {
            count[c - 'a']++;
        }
        int occurrences = 0;
        for (int i = 0; i < MAX_SIZE; i++) {
            // get first occurrences number
            if (count[i] != 0) {
                occurrences = count[i];
                break;
            }
        }
        for (int i = 0; i < MAX_SIZE; i++) {
            if (count[i] != 0 && count[i] != occurrences) {
                return false;
            }
        }
        return true;
    }
}
```

- Time Complexity: `O(n)` because we have to iterate through `n` characters of string `s`
- Space Complexity: `O(1)` because we have finite number of English lowercase characters (26) in input and hence max array size for `count` is finite.