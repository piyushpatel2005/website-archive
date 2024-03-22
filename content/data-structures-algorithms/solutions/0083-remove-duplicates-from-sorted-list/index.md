---
title: "0083 Remove Duplicates From Sorted List"
date: 2024-03-07T00:49:34-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Fast Slow Pointer", "LinkedList"]
languages: ["Java"]
---

## Description

Given the head of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.

### Example 1:

```
Input: head = [1,1,2]
Output: [1,2]
```

### Example 2:

```
Input: head = [1,1,2,3,3]
Output: [1,2,3]
```

### Constraints:

- The number of nodes in the list is in the range `[0, 300]`.
- `-100 <= Node.val <= 100`
- The list is guaranteed to be sorted in ascending order.

## Solution

The problem mentions as a constraint that the list is ascending order. So, we can simply iterate through the list and check for next element value. If the next has the same value as current node, we simply move the next of current to `current.next.next`.

```java
class Solution {
    public ListNode deleteDuplicates(ListNode head) {
        ListNode current = head;
        while (current != null && current.next != null) {
            if (current.val == current.next.val) {
                current.next = current.next.next;
            } else {
                current = current.next;
            }
        }
        return head;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`