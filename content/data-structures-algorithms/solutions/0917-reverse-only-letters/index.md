---
title: "0917 Reverse Only Letters"
date: 2023-10-19T12:49:34-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

## Description

Given a string `s`, reverse the string according to the following rules:

- All the characters that are not English letters remain in the same position.
- All the English letters (lowercase or uppercase) should be reversed.

Return `s` after reversing it.

### Example 1:

**Input:** `s = "ab-cd"`

**Output:** `"dc-ba"`

### Example 2:

**Input:** `s = "a-bC-dEf-ghIj"`

**Output:** `"j-Ih-gfE-dCba"`

### Example 3:

**Input:** `s = "Test1ng-Leet=code-Q!"`

**Output:** `"Qedo1ct-eeLg=ntse-T!"`
 
### Constraints:

- `1 <= s.length <= 100`
- `s` consists of characters with ASCII values in the range `[33, 122]`.
- `s` does not contain `'\"'` or `'\\'`.

## Solution

In this case, we need two pointers, just like reversing a string. However, in this case, we want to know when `left` index has non-alphabetic characters, at that point, we want to insert that character and increase only `left` pointer and if `right` index has non-alphabetic character, then we simply decrement the `right` pointer. In this case, we have to loop until we reach end of the string with `left` pointer.

```java
class Solution {
    public String reverseOnlyLetters(String s) {
        StringBuilder result = new StringBuilder();
        if (s == null || s.length() == 0)
            return s;
        int left = 0, right = s.length() - 1;
        while (left < s.length()) {
            if (Character.isAlphabetic(s.charAt(left)) && Character.isAlphabetic(s.charAt(right))) {
                result.append(s.charAt(right--));
                left++;
            } else if (!Character.isAlphabetic(s.charAt(left))) {
                result.append(s.charAt(left++));
            } else if (!Character.isAlphabetic(s.charAt(right))) {
                right--;
            }
        }
        return result.toString();
    }
}
```
