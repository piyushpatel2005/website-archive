---
title: "0082 Remove Duplicates From Sorted List Ii"
date: 2024-03-15T14:53:40-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["LinkedList"]
languages: ["Java"]
---

## Description

Given the `head` of a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list. Return the linked list sorted as well.


### Example 1:

```
Input: head = [1,2,3,3,4,4,5]
Output: [1,2,5]
```

### Example 2:

```
Input: head = [1,1,1,2,3]
Output: [2,3]
```

### Constraints:

- The number of nodes in the list is in the range `[0, 300]`.
- `-100 <= Node.val <= 100`
- The list is guaranteed to be sorted in ascending order.

## Solution

This problem is similar to problem [0083 Remove Duplicates from Sorted List](../0083-remove-duplicates-from-sorted-list/) except that this one requires us to remove all duplicates. In order to remove duplicates from first node, we need the previous node. If first element is duplicate, how do we get the node before that? The idea is to create a dummy first node which points to `head` and then using that check for all nodes that are duplicates and remove them if needed. In this case, we can easily clean up the duplicates by checking with the next node and moving pointer forward each time there are duplicates. However, once we have removed duplicates, there will still be single instance of this number which is left to clear. Due to this, we have to use inner `while` loop and outside of that we move the `previous` pointer to next of the leftover duplicate.

```java
class Solution {
    public ListNode deleteDuplicates(ListNode head) {
        if (head == null) {
            return null;
        }
        ListNode dummy = new ListNode(0, head);
        ListNode previous = dummy, current = head;
        while (current != null) {
            // If current is duplicate
            if (current.next != null && current.val == current.next.val) {
                // Make list unique
                while (current.next != null && current.val == current.next.val) {
                    current = current.next;
                }
                // Remove that single instance which is duplicate from the list
                previous.next = current.next;
            } else {
                // If current is not duplicate
                previous = previous.next;
            }
            current = current.next;
        }
        return dummy.next;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`