---
title: "1290 Convert Binary Number in a Linked List to Integer"
date: 2024-03-21T19:20:35-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["LinkedList"]
languages: ["Java"]
---

## Description

Given `head` which is a reference node to a singly-linked list. The value of each node in the linked list is either `0` or `1`. The linked list holds the binary representation of a number.

Return the decimal value of the number in the linked list.

The **most significant bit** is at the `head` of the linked list.

### Example 1:

```
Input: head = [1,0,1]
Output: 5
Explanation: (101) in base 2 = (5) in base 10
```

### Example 2:

```
Input: head = [0]
Output: 0
```

### Example 3:

```
Input: head = [1,1,0,1]
Output: 13
```

### Constraints:

- The Linked List is not empty.
- Number of nodes will not exceed `30`.
- Each node's value is either `0` or `1`.

## Solution

### Simple Approach 
The problem is about iterating through the list and using the binary numbers to multiply by `2`.

```java
class Solution {
    public int getDecimalValue(ListNode head) {
        int result = 0;
        while (head != null) {
            result = result * 2 + head.val;
            head = head.next;
        }
        return result;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`

### Using Bit Manipulations

```java
class Solution {
    public int getDecimalValue (ListNode head) {
        int result = 0;
        while (head != null) {
            result = (result << 1) | head.val;
            head = head.next;
        }
        return result;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`