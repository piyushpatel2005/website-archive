---
title: "1189 Maximum Number of Balloons"
date: 2023-12-22T15:36:54-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing", "Array"]
languages: ["Java"]
---

## Description

Given a string `text`, you want to use the characters of `text` to form as many instances of the word `"balloon"` as possible.

You can use each character in `text` **at most once**. Return the maximum number of instances that can be formed.


### Example 1:

```
Input: text = "nlaebolko"
Output: 1
```

### Example 2:

```
Input: text = "loonbalxballpoon"
Output: 2
```

### Example 3:

```
Input: text = "leetcode"
Output: 0
```

### Constraints:

- `1 <= text.length <= 10^4`
- `text` consists of lower case English letters only.

## Solution

Based on the problem, it seems like we need to find out occurrences of each character of word `balloon` and check in the incoming `text`, how many times each of those occur. That will be the number of times we can form the word `"balloon"` using the given `text`. Here, we can use each character only once, so this will straight away give us the answer.

This problem can be generalised for any `text` as input and we want to verify how many times we can form a given string `pattern`.

### Using HashMap

Again, it's actually counting occurrences of each character of the word `balloon`. So, we can use HashMap here. If a particular character is needed more than one times in the `pattern`, we have to make sure that we have that many copies of this character in the input `text`.

```java
class Solution {
    public int maxNumberOfBalloons(String text) {
        return maxNumberOfBalloons(text, "balloon");
    }

    private int maxNumberOfBalloons(String text, String wordPattern) {
        Map<Character, Integer> counts = new HashMap<>();
        for (char c: text.toCharArray()) {
            counts.put(c, counts.getOrDefault(c, 0) + 1);
        }
        int min = Integer.MAX_VALUE;
        // Check maximum how many times each character in wordPattern can be found in text
        for (char c: wordPattern.toCharArray()) {
            if (!counts.containsKey(c)) {
                return 0;
            }
            int count = counts.get(c);
            if (c == 'l' || c == 'o') {
                count /= 2;
            }
            min = Math.min(min, count);
        }
        return min;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)` because we can have at most 26 unique keys as lowercase English characters.

### Using Arrays

In this case, the constraint mentions that all characters are lowercase English characters. That means we can have at most 26 unique characters. So, we can store count of each character occurrences in the array of size 26. Once we have stored occurrences of characters of the `text`, we have to verify how many times we can create word `pattern` using these characters.

```java
class Solution {
    public int maxNumberOfBalloons (String text) {
        int[] counts = new int[26];
        for (char c: text.toCharArray()) {
            counts[c - 'a']++;
        }
        int min = Integer.MAX_VALUE;
        // Check maximum how many times each character in wordPattern can be found in text
        for (char c: "balloon".toCharArray()) {
            int count = counts[c - 'a'];
            if (c == 'l' || c == 'o') {
                count /= 2;
            }
            min = Math.min(min, count);
        }
        return min;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)` as maximum 26 is the size of the array we need.