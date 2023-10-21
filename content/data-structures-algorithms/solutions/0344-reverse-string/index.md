---
title: "0344 Reverse String"
date: 2023-10-18T16:26:30-04:00
draft: true
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

## Description

Write a function that reverses a string. The input string is given as an array of characters `s`.

You must do this by modifying the input array [in-place](https://en.wikipedia.org/wiki/In-place_algorithm) with `O(1)` extra memory.

### Example 1:

**Input:** s = ["h","e","l","l","o"]

**Output:** ["o","l","l","e","h"]

### Example 2:

**Input:** s = ["H","a","n","n","a","h"]
**Output:** ["h","a","n","n","a","H"]
 
### Constraints:

`1 <= s.length <= 10^5`

`s[i]` is a [printable ascii character](https://en.wikipedia.org/wiki/ASCII#Printable_characters).

## Solution

This is yet another two pointer problem. In this case, we can use constant space. In order to exchange two values, we just need one additional variable to store value temporarily. The same concept can be applied. We can use two pointers, one from the `left` and another from `right`. The algorithm will look like this.

```markdown
initialize left = 0, right = array.length - 1
while left is less than right
    exchange array[left] with array[right]
    increment left
    decrement right
```

The java code for above algorithm would look like this.

```java
class Solution {
    public void reverseString(char[] s) {
        if (s == null || s.length == 0)
            return;
        int left = 0, right = s.length - 1;
        while (left < right) {
            char temp = s[right];
            s[right] = s[left];
            s[left] = temp;
            left++;
            right--;
        }
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`