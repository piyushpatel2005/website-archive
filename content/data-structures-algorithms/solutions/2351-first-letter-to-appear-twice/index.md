---
title: "2351 First Letter to Appear Twice"
date: 2023-12-02T17:51:34-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given a string `s` consisting of lowercase English letters, return the first letter to appear twice.

**Note:**

A letter `a` appears twice before another letter `b` if the second occurrence of `a` is before the second occurrence of `b`.
`s` will contain at least one letter that appears twice.
 

### Example 1:

```
Input: s = "abccbaacz"
Output: "c"
Explanation:
The letter 'a' appears on the indexes 0, 5 and 6.
The letter 'b' appears on the indexes 1 and 4.
The letter 'c' appears on the indexes 2, 3 and 7.
The letter 'z' appears on the index 8.
The letter 'c' is the first letter to appear twice, because out of all the letters the index of its second occurrence is the smallest.
```

### Example 2:

```
Input: s = "abcdd"
Output: "d"
Explanation:
The only letter that appears twice is 'd' so we return 'd'.
```

### Constraints:

- `2 <= s.length <= 100`
- `s` consists of lowercase English letters.
- `s` has at least one repeated letter.

## Solution

The problem clearly states that there will always be at least one character which is repeated twice. However, to avoid compilation error, we have to specify the default value. In below examples, I have specified default value of empty character if no character found which is repeated in the input string `s`.

### 1. Brute Force Approach

The brute force approach for this problem will iterate through each element of the string and it will iterate through all characters on the right once more to check if the current character occurs second time.

```java
class Solution {
    public char repeatedCharacter(String s) {
        char c;
        for (int i = 0; i < s.length(); i++) {
            c = s.charAt(i);
            for (int j = i + 1; j < s.length(); j++) {
                if (c == s.charAt(j)) {
                    return c;
                }
            }
        }
        return ' ';
    }
}
```

In this case, we iterate through string `s` twice. so, the time complexity is `O(n ^ 2)` and we are not using any additional space, so space complexity is `O(1)`.

### 2. Better Solution - using Hashing

Based on the description, it clearly look like a use of Hashing to minimize time complexity. If we could store already seen characters in a data structure which we can search in constant time, then our time complexity will reduce to `O(n)`. That is only for inserting the character for the first time.

```java
class Solution {
    public char repeatedCharacter(String s) {
        Set<Character> set = new HashSet<>();
        for (char c: s.toCharArray()) {
            if (set.contains(c)) {
                return c;
            }
            set.add(c);
        }
        return ' ';
    }
}
```


In this solution, we are using single iteration, so the time complexity reduces to `O(n)`. However, we are using space and this space will be equal to number of characters the string `s` is allowed to have. In this problem, the character set is limited to lowercase English letters, so the space complexity at most can be `O(26)`, that is number of lowercase English characters.