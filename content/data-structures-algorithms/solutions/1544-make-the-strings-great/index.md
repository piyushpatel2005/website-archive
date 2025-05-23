---
title: "1544 Make the Strings Great"
date: 2024-07-05T23:03:31-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Stacks and Queues"]
languages: ["Java"]
---

## Description

Given a string `s` of lower and upper case English letters.

A good string is a string which doesn't have two adjacent characters `s[i]` and `s[i + 1]` where:

- `0 <= i <= s.length - 2`
- `s[i]` is a lower-case letter and `s[i + 1]` is the same letter but in upper-case or vice-versa.

To make the string good, you can choose **two adjacent** characters that make the string bad and remove them. You can keep doing this until the string becomes good.

Return the *string* after making it good. The answer is guaranteed to be unique under the given constraints.

Notice that an empty string is also good.

### Example 1:

```
Input: s = "leEeetcode"
Output: "leetcode"
Explanation: In the first step, either you choose i = 1 or i = 2, both will result "leEeetcode" to be reduced to "leetcode".
```

### Example 2:

```
Input: s = "abBAcC"
Output: ""
Explanation: We have many possible scenarios, and all lead to the same answer. For example:
"abBAcC" --> "aAcC" --> "cC" --> ""
"abBAcC" --> "abBA" --> "aA" --> ""
```

### Example 3:

```
Input: s = "s"
Output: "s"
``` 

### Constraints:

- `1 <= s.length <= 100`
- `s` contains only lower and upper case English letters.

## Solution

### Using Recursion

We can use recursion to solve this problem. We iterate from start to end and every time we find two consecutive characters being same, you use the recursive call to the same method but skipping these two same characters.

```java
class Solution {
    public String makeGood (String s) {
        for (int i = 0; i < s.length() - 1; i++) {
            if (Math.abs(s.charAt(i) - s.charAt(i + 1)) == 32) {
                return makeGood(s.substring(0, i) + s.substring(i + 2)); // skip these two characters
            }
        }
        return s;
    }
}
```

- Time Complexity: `O(n^2)`. It is recursively finding two same characters to remove which takes `O(n^2)` time complexity.
- Space Complexity: `O(n^2)` - In this case, you have two function calls in each iteration. Each function call requires `O(n)` space. Thus overall space complexity is `n^2`.

### Using Stack

You can also use stack to push each character. Every time, we check new character, we will peek at the stack for last inserted character. If they are same ignoring case, then we can pop the last inserted element.

```java
class Solution {
    public String makeGood(String s) {
        Stack<Character> stack = new Stack<>();
        for (char c : s.toCharArray()) {
            if (!stack.isEmpty() && Math.abs(stack.peek() - c) == 32) {
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

### Using Iteration or `StringBuilder`

With `StringBuilder` you don't need to create new String everytime. `StringBuilder` is mutable.

```java
class Solution {
    public String makeGood (String s) {
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (sb.length() > 0 && Math.abs(sb.charAt(sb.length() - 1) - c) == 32) {
                sb.deleteCharAt(sb.length() - 1);
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`