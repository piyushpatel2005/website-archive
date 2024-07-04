---
title: "0141 Linked List Cycle"
date: 2024-03-05T10:34:33-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["LinkedList", "Fast Slow Pointers"]
languages: ["Java"]
---

## Description

Given `head`, the head of a linked list, determine if the linked list has a cycle in it.

There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the `next` pointer. Internally, `pos` is used to denote the index of the node that tail's `next` pointer is connected to. Note that `pos` is not passed as a parameter.

Return `true` if there is a cycle in the linked list. Otherwise, return `false`.


### Example 1:

```
Input: head = [3,2,0,-4], pos = 1
Output: true
Explanation: There is a cycle in the linked list, where the tail connects to the 1st node (0-indexed).
```

### Example 2:

```
Input: head = [1,2], pos = 0
Output: true
Explanation: There is a cycle in the linked list, where the tail connects to the 0th node.
```

### Example 3:

```
Input: head = [1], pos = -1
Output: false
Explanation: There is no cycle in the linked list.
``` 

### Constraints:

- The number of the nodes in the list is in the range `[0, 10^4]`.
- `-10^5 <= Node.val <= 10^5`
- `pos` is `-1` or a valid index in the linked-list.
 

**Follow up:** Can you solve it using `O(1)` (i.e. constant) memory?

## Solution

### Using Hashing

One way to solve this problem is to use `HashSet` or `HashMap` to track which elements have already been visited. If we visit the same node twice, we can verify that from `HashSet` or `HashMap` api. This approach requires additional space in the form of `HashMap` or `HashSet`.

```java
class Solution {
    public boolean hasCycle (ListNode head) {
        Set<ListNode> set = new HashSet<>();
        while (head != null) {
            if (set.contains(head)) {
                return true;
            } else {
                set.add(head);
            }
            head = head.next;
        }
        return false;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`

### Using Fast and Slow Pointers

This problem can be solved using slow and fast pointers. If there is cycle in the linked list, the traversal should never end. It should traverse in the loop indefinitely. Thus if we use the slow pointer and fast pointers moving at two different speeds, the fast pointer will never reach the end of the list. Also, there will be at least one node in the list where slow pointer and fast pointers will meet during their traversal due to cycle. This means we can check if `fast == slow` and if that's the case, we know that the list has a cycle else eventually the fast pointer will reach `null` (i.e. end of the list) and at that point, we can return `false`.

```java
class Solution {
    public boolean hasCycle (ListNode head) {
        ListNode slow = head;
        ListNode fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
            if (slow == fast)
                return true;
        }
        return false;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`