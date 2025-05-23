---
title: "0024 Swap Nodes in Pairs"
date: 2024-03-07T02:10:38-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["LinkedList"]
languages: ["Java"]
---

## Description

Given a linked list, swap every two adjacent nodes and return its head. You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)

### Example 1:

```
Input: head = [1,2,3,4]
Output: [2,1,4,3]
```

### Example 2:

```
Input: head = []
Output: []
```

### Example 3:

```
Input: head = [1]
Output: [1]
```

### Constraints:

- The number of nodes in the list is in the range `[0, 100]`.
- `0 <= Node.val <= 100`

## Solution

This problem requires node manipulations in linked list. We have to be careful with the sequence of operations because it can result in very different result.

```java
class Solution {
    public ListNode swapPairs(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }
        ListNode current = head;
        ListNode newHead = head.next;
        ListNode prev = null;
        ListNode next;
        while (current != null && current.next != null) {
            next = current.next;
            current.next = next.next;
            next.next = current;
            if (prev != null) {
                prev.next = next;
            }
            prev = current;
            current = current.next;
        }
        return newHead;
    }
}
```