---
title: "0020 Valid Parentheses"
date: 2024-05-09T09:48:00-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given a string `s` containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid.

An input string is valid if:

1. Open brackets must be closed by the same type of brackets.
2. Open brackets must be closed in the correct order.
3. Every close bracket has a corresponding open bracket of the same type.
 
### Example 1:
```
Input: s = "()"
Output: true
```

### Example 2:

```
Input: s = "()[]{}"
Output: true
```

### Example 3:

```
Input: s = "(]"
Output: false
```

### Constraints:

- `1 <= s.length <= 10^4`
- `s` consists of parentheses only `'()[]{}'`.

## Solution

This problem could be solved using `Stack`. In this case, whenever we find opening brackets, we insert them into the stack. Next, when we find the closing bracket, we `pop` from the stack verifying that last inserted opening bracket was matching with this closing bracket. 

How do we match opening bracket with closing brackets? It needs a mapping of which closing bracket corresponds to the opening bracket. For this, we will have only three entries because the problem states that the string consists of only 6 total unique characters. We can use `HashMap` where key will be the opening bracket and the values will be corresponding closing bracket.

By using this logic our pseudo code would looks something like this.

```pseudocode{lineNos=false}
create hash map of opening bracket and closing brackets
initialize stack of characters
for character in string:
    if (map contains character):
        if stack is empty OR stack.pop != map.get(character):
            return false
        else
            stack.push(character)
    // at the end stack should be empty
    return stack.isEmpty()
```

The solution for this problem in Java would look like this.


```java
class Solution {
    private static final Map<Character, Character> closingToOpeningBracket =
            Map.of(')', '(', '}', '{', ']', '[');

    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();
        for (char c : s.toCharArray()) {
            if (closingToOpeningBracket.containsKey(c)) {
                if (stack.isEmpty() || stack.pop() != closingToOpeningBracket.get(c)) {
                    return false;
                }
            } else {
                stack.push(c);
            }
        }
        return stack.isEmpty();
    }
}
```

- Time Complexity: `O(n)` because we iterate through the input string `s`
- Space Complexity: `O(n)` because we need to store those characters from string `s` into `HashMap` and/ord `Stack`