---
title: "0092 Reverse Linked List Ii"
date: 2024-03-07T04:29:14-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["LinkedList"]
languages: ["Java"]
---

## Description

Given the `head` of a singly linked list and two integers `left` and `right` where `left <= right`, reverse the nodes of the list from position `left` to position `right`, and return the reversed list.

### Example 1:

```
Input: head = [1,2,3,4,5], left = 2, right = 4
Output: [1,4,3,2,5]
```

### Example 2:

```
Input: head = [5], left = 1, right = 1
Output: [5]
```

### Constraints:

- The number of nodes in the list is `n`.
- `1 <= n <= 500`
- `-500 <= Node.val <= 500`
- `1 <= left <= right <= n`


## Solution

This again list manipulations problem. In this case, we are not required to reverse the full list but only a part of the list. So, we have to first find out the `left` position where we want to start reversal. Once we have found this node, we can start moving the pointer for next nodes in the reverse direction until we have reached the right node where we want to stop. For this, we can use the `right` as a counter.

After we have reversed the sublist, we have to connect the previous to original left with the right node and similarly, the left node needs to be connected to the next of right node. This requires us storing the `prevToLeft` and `leftNode` for later use. 

```java
class Solution {
    public ListNode reverseBetween(ListNode head, int left, int right) {
        if (head == null || head.next == null) {
            return head;
        }
        // Find previous node to left because this allows us to connect the reversed list to the rest of the list
        // Also find the leftNode using current
        ListNode current = head, prevToLeft = null;
        while (left > 1) {
                prevToLeft = current;
                current = current.next;
                left--;
                right--;
        }
        // Store previous node to left in prevToLeft as we will need it at the end to connect the reversed list to the rest of the list
        // Also save leftNode as we will need it to connect to next element at the end.
        ListNode prev = prevToLeft, leftNode = current, next = null;

        // Reverse the list from left to right
        while (right > 0) {
            next = current.next;
            current.next = prev;
            prev = current;
            current = next;
            right--;
        }
        // At this point, prev points to the head of the reversed list
        // current points to the next element after the reversed list

        if (prevToLeft != null) // if left is not the first element
            prevToLeft.next = prev;
        else // if left is the first element
            head = prev;

        leftNode.next = current;

        return head;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`