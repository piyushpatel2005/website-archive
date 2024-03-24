---
title: "2095 Delete the Middle Node of Linked List"
date: 2024-03-09T14:51:54-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["LinkedList", "Fast Slow Pointers"]
languages: ["Java"]
---

## Description

You are given the `head` of a linked list. Delete the middle node, and return the `head` of the modified linked list.

The middle node of a linked list of size `n` is the `⌊n / 2⌋`th node from the start using 0-based indexing, where `⌊x⌋` denotes the largest integer less than or equal to `x`.

For `n = 1`, `n = 2`, `n = 3`, `n = 4`, and `n = 5`, the middle nodes are `0`, `1`, `1`, `2`, and `2`, respectively.

### Example 1:

```
Input: head = [1,3,4,7,1,2,6]
Output: [1,3,4,1,2,6]
Explanation:
The above figure represents the given linked list. The indices of the nodes are written below.
Since n = 7, node 3 with value 7 is the middle node, which is marked in red.
We return the new list after removing this node.
```

### Example 2:

```
Input: head = [1,2,3,4]
Output: [1,2,4]
Explanation:
The above figure represents the given linked list.
For n = 4, node 2 with value 3 is the middle node, which is marked in red.
```

### Example 3:

```
Input: head = [2,1]
Output: [2]
Explanation:
The above figure represents the given linked list.
For n = 2, node 1 with value 1 is the middle node, which is marked in red.
Node 0 with value 2 is the only node remaining after removing node 1.
```

### Constraints:

- The number of nodes in the list is in the range `[1, 105]`.
- `1 <= Node.val <= 10^5`

## Solution

In this case, we want to find the node to the left of the middle node. We can [find the middle node using fast and slow pointers](../0876-middle-of-the-linked-list/). However, we want to find the previous node of the middle node so that we can delete the middle node. If we start with `fast = head.next.next`, the `fast` pointer will reach end of the list one iteration earlier. At this point, `slow` pointer will be pointing at previous of the middle node instead of the middle node itself. 

Once we have found the previous to the middle node, the deletion is simply moving the pointers to the next of middle node.

```java
class Solution {
    public ListNode deleteMiddle(ListNode head) {
        if (head == null || head.next == null) {
            return null;
        }
        ListNode slow = head;
        ListNode fast = head.next.next;
        // Find the previous of middle node
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        // Delete the middle node
        slow.next = slow.next.next;
        return head;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`