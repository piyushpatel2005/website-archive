---
title: "2000 Reverse Prefix of Word"
date: 2023-10-19T17:05:11-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

Given a `0-indexed` string `word` and a character `ch`, reverse the segment of `word` that starts at index `0` and ends at the index of the first occurrence of `ch` (inclusive). If the character c`h` does not exist in `word`, do nothing.

For example, if `word = "abcdefd"` and `ch = "d"`, then you should reverse the segment that starts at `0` and ends at `3` (inclusive). The resulting string will be `"dcbaefd"`.
Return the resulting string.

### Example 1:

**Input:** `word = "abcdefd"`, `ch = "d"`

**Output:** `"dcbaefd"`

**Explanation:** The first occurrence of `"d"` is at index `3`. 
Reverse the part of word from `0` to `3` (inclusive), the resulting string is `"dcbaefd"`.

### Example 2:

**Input:** `word = "xyxzxe"`, `ch = "z"`

**Output:** `"zxyxxe"`

**Explanation:** The first and only occurrence of `"z"` is at index `3`.
Reverse the part of word from `0` to `3` (inclusive), the resulting string is `"zxyxxe"`.

### Example 3:

**Input:** `word = "abcd"`, `ch = "z"`

**Output:** `"abcd"`

**Explanation:** `"z"` does not exist in word.
You should not do any reverse operation, the resulting string is `"abcd"`.
 
### Constraints:

- `1 <= word.length <= 250`
- `word` consists of lowercase English letters.
- `ch` is a lowercase English letter.

## Solution

In this case, we first need to find index position of character `ch` and then we can reverse the initial part of the string from index `0` to `index` position of character and append the remaining part as it is. We can use array to accomplish this easily.

```java
class Solution {
    public String reversePrefix(String word, char ch) {
        int index = -1;
        for (int i = 0; i < word.length(); i++) {
            if (word.charAt(i) == ch) {
                return reverseSubstring(word, 0, i);
            }
        }
        return word;
    }

    private String reverseSubstring(String word, int start, int end) {
        char[] chars = word.toCharArray();
        while (start < end) {
            char temp = chars[start];
            chars[start++] = chars[end];
            chars[end--] = temp;
        }
        return new String(chars);
    }
}
```

