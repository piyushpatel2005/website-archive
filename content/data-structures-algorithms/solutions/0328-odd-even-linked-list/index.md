---
title: "0328 Odd Even Linked List"
date: 2024-03-21T19:49:01-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["LinkedList"]
languages: ["Java"]
---

## Description

Given the `head` of a singly linked list, group all the nodes with odd indices together followed by the nodes with even indices, and return the reordered list.

The first node is considered odd, and the second node is even, and so on.

Note that the relative order inside both the even and odd groups should remain as it was in the input.

You must solve the problem in `O(1)` extra space complexity and `O(n)` time complexity.

### Example 1:

```
Input: head = [1,2,3,4,5]
Output: [1,3,5,2,4]
Explanation:
1 --> 2 --> 3 --> 4 --> 5
odd indices: 1 --> 3 --> 5
even indices: 2 --> 4
Output should be odd then even that is: 1 --> 3 --> 4 --> 2 --> 4
```

### Example 2:

```
Input: head = [2,1,3,5,6,4,7]
Output: [2,3,6,7,1,5,4]
``` 

### Constraints:

- The number of nodes in the linked list is in the range `[0, 10^4]`.
- `-10^6 <= Node.val <= 10^6`

## Solution

In this problem we have to iterate through the list and in each iteration we skip one node for one head and for another (`evenHead`), we add that node. Finally we add `evenHead` to the end of the `odd`.


```java
class Solution {
    public ListNode oddEvenList(ListNode head) {
        if (head == null) {
            return null;
        }
        ListNode odd = head, even = head.next;
        ListNode evenHead = even; // keep evenHead to track all even indices
        while (even != null && even.next != null) {
            odd.next = even.next; // move odd to next odd
            odd = odd.next;
            even.next = odd.next; // move even to next even
            even = even.next;
        }
        odd.next = evenHead; // connect odd list to even list
        return head;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`