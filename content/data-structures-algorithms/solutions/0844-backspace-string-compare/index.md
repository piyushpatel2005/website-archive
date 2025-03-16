---
title: "0844 Backspace String Compare"
date: 2024-05-10T23:48:12-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Stacks and Queues"]
languages: ["Java"]
---

## Description

Given two strings `s` and `t`, return `true` if they are equal when both are typed into empty text editors. `'#'` means a backspace character.

Note that after backspacing an empty text, the text will continue empty.

### Example 1:

```
Input: s = "ab#c", t = "ad#c"
Output: true
Explanation: Both s and t become "ac".
```

### Example 2:

```
Input: s = "ab##", t = "c#d#"
Output: true
Explanation: Both s and t become "".
```

### Example 3:

```
Input: s = "a#c", t = "b"
Output: false
Explanation: s becomes "c" while t becomes "b".
```

### Constraints:

- `1 <= s.length, t.length <= 200`
- `s` and `t` only contain lowercase letters and `'#'` characters.

## Solution

### Using `Stack`

This problem can be solved using `Stack` data structure. You can iterate over each character of a string. At the same time, append each character into `Stack`. If current character is `#`, you `pop` the previous character from stack. At the end of the iteration, the stack would contain only characters which are clean after backspace operations.

```java
class Solution {
    public boolean backspaceCompare(String s, String t) {
        return cleanString(s).equals(cleanString(t));
    }

    private String cleanString(String s) {
        Stack<Character> stack = new Stack<>();
        for (char c : s.toCharArray()) {
            if (c != '#') {
                stack.push(c);
            } else if (!stack.isEmpty()) {
                stack.pop();
            }
        }
        StringBuilder sb = new StringBuilder();
        return String.valueOf(stack);
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`

### Using `StringBuilder`

In above solution, we build stack of characters but then we again have to iterate over the stack when using `String.valueOf(stack)` at the end to build the string. Instead of this, we can use `StringBuilder` with a variable to keep track of length of the string.  `StringBuilder` acts more like an array of `char`.

```java
class Solution {
    public boolean backspaceCompare2(String s, String t) {
        return cleanString(s).equals(cleanString(t));
    }

    private String cleanString (String s) {
        StringBuilder sb = new StringBuilder();
        int stringLength = 0;
        for (char c : s.toCharArray()) {
            if (c != '#') {
                sb.append(c);
                stringLength++;
            } else if (stringLength > 0) {
                sb.deleteCharAt(stringLength - 1);
                stringLength--;
            }
        }
        return sb.toString();
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`