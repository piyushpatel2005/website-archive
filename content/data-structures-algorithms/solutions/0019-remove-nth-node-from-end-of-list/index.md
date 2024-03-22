---
title: "0019 Remove Nth Node From End of List"
date: 2024-03-15T09:41:37-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["LinkedList", "Two Pointers"]
languages: ["Java"]
---

## Description

Given the `head` of a linked list, remove the `n`th node from the end of the list and return its `head`.


### Example 1:

```
Input: head = [1,2,3,4,5], n = 2
Output: [1,2,3,5]
```

### Example 2:

```
Input: head = [1], n = 1
Output: []
```

### Example 3:

```
Input: head = [1,2], n = 1
Output: [1]
```

### Constraints:

- The number of nodes in the list is `sz`.
- `1 <= sz <= 30`
- `0 <= Node.val <= 100`
- `1 <= n <= sz`

**Follow up:** Could you do this in one pass?

## Solution

### Using ArrayList

One potential solution is to find the length of the list in the first pass. Now, to remove `n`th node from the end is equal to removing `size - n`th node from the start. For example, if list is `[1, 2, 3, 4, 5]` and `n=2` then `size=5` and we want to remove `5-2=3` node with start index as zero. In order to do this, we first find the `length` of the list by iterating over the list. Next time when we start iteration from the start of the list, we have to reach upto 3rd node which is previous to the node we want to delete. This is because we will need the previous node in singly linked list in order to delete the next node.


```java
class Solution {
    public ListNode removeNthFromEnd(ListNode head, int n) {
        if (head == null) {
            return null;
        }
        // Find length of the list
        ListNode current = head;
        int length = 0;
        while (current != null) {
            length++;
            current = current.next;
        }
        // Iterate upto n-1 from previous
        // handle edge cases like when previous is -1
        int i = 0;
        current = head;
        while ((length - n) > 0 && (i != length - n - 1)) {
            current = current.next;
            i++;
        }
        if (length - n == 0) {
            head = head.next;
        } else {
            current.next = current.next.next;
        }
        return head;
    }
}
```

### Using Two pointers

In this problem, basically we want to find the `previous` node of the `nth` node from the end. If we start the `fast` pointer at `n+1` node from head and `slow` pointer at `head` and in each iteration move both pointers forward by one position. When `fast` pointer reaches end of the list, the `slow` pointer will be at `n-1` from the end. Now, we simply need to remove the `slow.next` node from the list and return the `head`.

```java
class Solution {
    public ListNode removeNthFromEnd (ListNode head, int n) {
        if (head == null) {
            return null;
        }
        ListNode dummy = new ListNode(0, head);
        ListNode ahead = dummy;
        ListNode behind = dummy;
        for (int i = 0; i <= n; i++) {
            ahead = ahead.next;
        }
        while (ahead != null) {
            ahead = ahead.next;
            behind = behind.next;
        }
        behind.next = behind.next.next;
        return dummy.next;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`