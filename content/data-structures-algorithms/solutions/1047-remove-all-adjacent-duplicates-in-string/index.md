---
title: "1047 Remove All Adjacent Duplicates in String"
date: 2024-05-10T18:13:48-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Stacks and Queues"]
languages: ["Java"]
---

## Description

You are given a string `s` consisting of lowercase English letters. A **duplicate removal** consists of choosing two **adjacent and equal** letters and removing them.

We repeatedly make duplicate removals on `s` until we no longer can.

Return the final string after all such duplicate removals have been made. It can be proven that the answer is unique.

### Example 1:

```
Input: s = "abbaca"
Output: "ca"
Explanation: 
For example, in "abbaca" we could remove "bb" since the letters are adjacent and equal, and this is the only possible move.  The result of this move is that the string is "aaca", of which only "aa" is possible, so the final string is "ca".
```

### Example 2:

```
Input: s = "azxxzy"
Output: "ay"
```

### Constraints:

- `1 <= s.length <= 10^5`
- `s` consists of lowercase English letters.

## Solution

### Naive Approach

If we think about it, we just need to iterate through input string `s` and whenever we find duplicates, we just have to move to next character, we basically need to skip two characters. We can use `substring()` method to delete few characters.

```java
class Solution {
    public String removeDuplicates(String s) {
        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) == s.charAt(i - 1)) {
                s = s.substring(0, i - 1) + s.substring(i + 1);
                i = 0;
            }
        }
        return s;
    }
}
```

There are few serious problems with this. First, it is using string modification. In Java, string is immutable and we are modifying string multiple times in each iteration when we use `substring()` methods. All these adds to time complexity. 

### Using `Stack` and `StringBuilder`

We can use `Stack` to insert all unique elements. When the last inserted element matches the next character, we know that we have duplicates. At this point, we `pop` the last element from stack and move on to next character in the string. At the end of the iteration of string, again iterate over stack elements and append to `StringBuilder` to create string.

```java
class Solution {
    public String removeDuplicates (String s) {
        Stack<Character> stack = new Stack<>();
        for (char c : s.toCharArray()) {
            if (!stack.isEmpty() && stack.peek() == c) {
                stack.pop();
            } else {
                stack.push(c);
            }
        }
        StringBuilder sb = new StringBuilder();
        for (char c : stack) {
            sb.append(c);
        }
        return sb.toString();
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`

Here, we had to iterate over string and then through stack. Instead of this, if we can manipulate `StringBuilder`, we can avoid one iteration of stack.

### Using `StringBuilder`

```java
class Solution {
    public String removeDuplicates (String s) {
        StringBuilder sb = new StringBuilder();
        int stringLength = 0;
        for (char c: s.toCharArray()) {
            if (stringLength > 0 && sb.charAt(stringLength - 1) == c) {
                sb.delete(stringLength - 1, stringLength);
                stringLength--;
            } else {
                sb.append(c);
                stringLength++;
            }
        }
        return sb.toString();
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`