---
title: "0203 Remove Linked List Elements"
date: 2024-03-21T19:01:46-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["LinkedList"]
languages: ["Java"]
---

## Description

Given the `head` of a linked list and an integer `val`, remove all the nodes of the linked list that has `Node.val == val`, and return the new `head`.

### Example 1:

```
Input: head = [1,2,6,3,4,5,6], val = 6
Output: [1,2,3,4,5]
```

### Example 2:

```
Input: head = [], val = 1
Output: []
```

### Example 3:

```
Input: head = [7,7,7,7], val = 7
Output: []
```

### Constraints:

- The number of nodes in the list is in the range `[0, 10^4]`.
- `1 <= Node.val <= 50`
- `0 <= val <= 50`

## Solution

This is a straight forward problem which requires iterating through the list and modifying pointers to next node if the node value is `val`. Here, because even the first element may have the value `val`, we need the `previous` node in order to remove this node. So, we will have to create a `dummy` node which will be previous to the `head` node.


```java
class Solution {
    public ListNode removeElements(ListNode head, int val) {
        if (head == null) {
            return null;
        }
        ListNode dummy = new ListNode(0, head);
        ListNode current = head, previous = dummy;
        while (current != null) {
            if (current.val == val) {
                previous.next = current.next;
            } else {
                previous = current;
            }
            current = current.next;
        }
        return dummy.next;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`