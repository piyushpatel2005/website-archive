---
title: "0071 Simplify Path"
date: 2024-05-11T21:55:15-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Stacks and Queues"]
languages: ["Java"]
---

## Description

Given an absolute path for a Unix-style file system, which begins with a slash `'/'`, transform this path into its simplified canonical path.

In Unix-style file system context, a single period `'.'` signifies the current directory, a double period `".."` denotes moving up one directory level, and multiple slashes such as `"//"` are interpreted as a single slash. In this problem, treat sequences of periods not covered by the previous rules (like `"..."`) as valid names for files or directories.

The simplified canonical path should adhere to the following rules:

- It must start with a single slash     .
- Directories within the path should be separated by only one slash `'/'`.
- It should not end with a slash `'/'`, unless it's the root directory.
- It should exclude any single or double periods used to denote current or parent directories.

Return the new path.

### Example 1:

```
Input: path = "/home/"
Output: "/home"
Explanation: The trailing slash should be removed.
```
 
### Example 2:

```
Input: path = "/home//foo/"
Output: "/home/foo"
Explanation: Multiple consecutive slashes are replaced by a single one.
```

### Example 3:

```
Input: path = "/home/user/Documents/../Pictures"
Output: "/home/user/Pictures"
Explanation: A double period ".." refers to the directory up a level.
```

### Example 4:

```
Input: path = "/../"
Output: "/"
Explanation: Going one level up from the root directory is not possible.
```

### Example 5:

```
Input: path = "/.../a/../b/c/../d/./"
Output: "/.../b/d"
Explanation: "..." is a valid name for a directory in this problem.
```

### Constraints:

- `1 <= path.length <= 3000`
- `path` consists of English letters, digits, period `'.'`, slash `'/'` or `'_'`.
- `path` is a valid absolute Unix path.

## Solution

This problem can be solved using Stacks. First, we have to split the path by `/`. This will give us all directory names. Next, we iterate through these directory names and if we come across any valid names (that is path is not `.` or it's not empty like in `///` case), then we push that directory name into stack. 

If we come across directory like `..` and if the stack is non-empty, then we pop out of the stack. Eventually, when we have walked through all parts of the path, we will have simplified path. The next part is to join directory names available in the stack with `/` and return that as the result.


```java
class Solution {
     public String simplifyPath(String path) {
        String[] parts = path.split("/");
        Stack<String> stack = new Stack<>();

        for(String part : parts) {
            if (part.equals("..")) {
                if (!stack.isEmpty()) {
                    stack.pop();
                }
            } else if (!part.equals(".") && !part.isEmpty()) {
                stack.push(part);
            }
        }

        StringBuilder sb = new StringBuilder();
        for(String part : stack) {
            sb.append("/");
            sb.append(part);
        }

        return sb.length() > 0 ? sb.toString() : "/";
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)` as it is `O(2n)` because of array and stack, but simplified to `O(n)`