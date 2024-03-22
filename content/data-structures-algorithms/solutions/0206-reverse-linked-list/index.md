---
title: "0206 Reverse Linked List"
date: 2024-03-07T04:06:11-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["LinkedList"]
languages: ["Java"]
---

## Description

Given the `head` of a singly linked list, reverse the list, and return the reversed list.

### Example 1:

```
Input: head = [1,2,3,4,5]
Output: [5,4,3,2,1]
```

### Example 2:

```
Input: head = [1,2]
Output: [2,1]
```

### Example 3:

```
Input: head = []
Output: []
```

### Constraints:

- The number of nodes in the list is the range `[0, 5000]`.
- `-5000 <= Node.val <= 5000`

## Solution

To reverse a list, we can simply iterate through the list and move the pointers backwards. We have to have the `prev` node created which will eventually become the `head` of the list.

```java
class Solution {
    public ListNode reverseList(ListNode head) {
        ListNode previous = null, current = head, next = null;
        while (current != null) {
            next = current.next;
            current.next = previous;
            previous = current;
            current = next;
        }
        return previous;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`

### Recursive Solution

```java
class Solution {
    public ListNode reverseList (ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }
        ListNode previous = reverseListRecursive(head.next);
        head.next.next = head;
        head.next = null;
        return previous;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`