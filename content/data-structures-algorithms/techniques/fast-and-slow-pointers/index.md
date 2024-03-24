---
title: "Fast and Slow Pointers"
date: 2024-02-26T01:46:56-05:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
ideas: ["Fast Slow Pointer"]
---

Fast and slow pointers is one of the algorithmic problem solving technique which uses two pointers. These two pointers move at different speed to come to a solution.

<!--more-->

With fast and slow pointers in list, we can come to different points in the list. The code for moving pointers would look something like this.

```pseudocode
slow_pointer = head
fast_pointer = head
while fast_pointer is not null and fast_pointer.next is not null:
    // perform actions
    slow_pointer = slow_pointer.next
    fast_pointer = fast_pointer.next.next
```

The `fast_pointer` moves two times the speed because in each iteration while we move the `slow_pointer` by one position, we are moving `fast_pointer` by two positions. This gives interesting approach to solve several problems.

One example is if we have a list with odd number of elements. We can use the fast and slow pointers to reach to the middle of the list. In a list with odd number of elements, it will always have only single middle element. For this, we simply have to make `fast_pointer` move forward two steps when `slow_pointer` moves just single element. This way when the `fast_pointer` reaches end of the list (i.e. has `null` as next element), the `slow_pointer` will be at the middle of the list.

[876 Find Middle of the Linked list](../../solutions/0876-middle-of-the-linked-list/)

Similar to this problem, if we have to find the `n`th node from the end, we can use slow and fast pointers. We have to separate the two pointers `n` nodes apart and traverse one element at a time. When the fast pointer reaches the end of the list, the slow pointer would have reached `n`th node from the end.

```java
class NthNode {
    public ListNode getNthNodeFromEnd(ListNode head, int n) {
        ListNode slow = head;
        ListNode fast = head;
        for (int i = 0; i < n; i++) {
            fast = fast.next;
        }
        while (fast != null) {
            slow = slow.next;
            fast = fast.next;
        }
        return slow;
    }
}
```

Another common problem with linked list which can be solved using slow and fast pointers is when we have to find if the linked list has cycles. Linked list is said to have cycle if we can navigate the linked list using `.next` operation and eventually there is at least one element which can be reached again while traversing the list. If we move two pointers at different speeds, let's say twice the speed for fast pointer, those two pointers will eventually meet at some point in their traversal before the fast pointer reaches end of the list. Even though the fast pointer might skip over the slow pointer in first iteration, it will eventually meet the slow pointer during next traversal. The point is that because the list has a cycle the traversal never ends until there is common node where both slow and fast pointer reach.

[141 Linked List Cycle](../../solutions/0141-linked-list-cycle/)

One more problem which can be solved using fast and slow pointers is if we have to find two nodes before the middle node. Let's say we are given a list of `[1,2,3,4,5,6,7]` and we are asked to find the node before two nodes of the middle. In this case,  the middle node is at value `4`, two nodes before this node has the value `2`. How can we get this value? It looks difficult but it is relatively simple. We know that when we use `slow` and `fast` pointers with `fast` pointer moving twice the speed, if we start both at `head`, when `fast` pointer reaches end of the list, `slow` pointer points to the middle. We simply have to offset this iteration two steps for the `slow` pointer. This means we have to start the `fast` pointer 4 steps forward. That is initialize `fast = head.next.next.next.next` instead of `fast = head`. The same approach can be used to find the previous node of the middle node.

[2095 - Delete the middle node of the Linked List](../../solutions/2095-delete-the-middle-node-of-linked-list/)