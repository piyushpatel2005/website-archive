---
title: "0557 Reverse Words in String III"
date: 2023-10-19T04:32:53-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

## Description

Given a string `s`, reverse the order of characters in each word within a sentence while still preserving whitespace and initial word order.

### Example 1:

**Input:** `s = "Let's take LeetCode contest"`

**Output:** `"s'teL ekat edoCteeL tsetnoc"`
Example 2:

**Input:** s = `"God Ding"`

**Output:** `"doG gniD"`
 
### Constraints:

- `1 <= s.length <= 5 * 10^4`
- `s` contains printable ASCII characters.
- `s` does not contain any leading or trailing spaces.
- There is at least one word in `s`.
- All the words in `s` are separated by a single space.

## Solution

The solution for this problem might be to split the word by space and then use two pointers approach to reverse each of those strings. This would also work in `O(n)` time complexity. Again, we could use `reverse` method to reverse a string, but we will iterate through elements twice in this case.

```java
class Solution {
    public String reverseWords(String s) {
        StringBuilder builder = new StringBuilder();
        for (String word: s.split(" ")) {
            builder.append(new StringBuffer(word).reverse().toString());
            builder.append(" ");
        }
        return builder.substring(0, builder.length() - 1);
    }
}
```

```java
class Solution {
    public String reverseWords(String s) {
        StringBuilder builder = new StringBuilder();
        for (String word: s.split(" ")) {
            for (int i = word.length() - 1; i >= 0; i--) {
                builder.append(word.charAt(i));
            }
            builder.append(" ");
        }
        return builder.substring(0, builder.length() - 1);
    }
}
```