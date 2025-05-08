---
title: "1721 Swapping Nodes in a Linked List"
date: 2024-03-15T15:35:48-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["LinkedList"]
languages: ["Java"]
---

## Description

You are given the `head` of a linked list, and an integer `k`.

Return the `head` of the linked list after swapping the values of the `k`th node from the beginning and the `k`th node from the end (the list is **1-indexed**).

### Example 1:

```
Input: head = [1,2,3,4,5], k = 2
Output: [1,4,3,2,5]
```

### Example 2:

```
Input: head = [7,9,6,6,7,8,3,0,9,5], k = 5
Output: [7,9,6,6,8,7,3,0,9,5]
```

### Constraints:

- The number of nodes in the list is `n`.
- `1 <= k <= n <= 10^5`
- `0 <= Node.val <= 100`

## Solution

### Two Pass

One possible option is to iterate through the list and find the `length` of the list. Now, move the `first` node to `k` positions from the `head`. For second node, we have to find it from the end, which is equivalent to `length - k + 1` node from the beginning. Once both nodes are found, simply swap those two using additional temporary `ListNode`. This solution although has time complexity `O(n)`, it requires two pass through the list.

```java
class Solution {
    public ListNode swapNodes(ListNode head, int k) {
        if (head == null) {
            return null;
        }
        ListNode current = head;
        int length = 0;
        while (current != null) {
            length++;
            current = current.next;
        }
        ListNode first = head;
        ListNode second = head;
        for (int i = 1; i < k; i++) {
            first = first.next;
        }
//        System.out.println("first: " + first.val);
        for (int i = 1; i < length - k + 1; i++) {
            second = second.next;
        }
//        System.out.println("second: " + second.val);
        int temp = first.val;
        first.val = second.val;
        second.val = temp;
        return head;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`

### Better Approach - Single Pass

In this case we can use the same technique to find the `k`th node from the end using two pointers offset by `k` positions. In the code below, we iterate through the list using `current` pointer and also track `size` variable. When the `size = k` then we have found our `firstNode`. At this point, we can initialize our `secondNode` to `head` so that it's offset by `k`. Now, when `current` eventually reaches end of the list, the `secondNode` will be at `size - k` position, that is `k`th from the end. Now that we have found the two nodes to swap, we simply swap them using a `temp` node.

```java
class Solution {
    public ListNode swapNodes2 (ListNode head, int k) {
        if (head == null) {
            return null;
        }
        ListNode current = head, firstNode = null, secondNode = null;
        int length = 0;
        while (current != null) {
            length++;
            if (secondNode != null) {
                secondNode = secondNode.next;
            }
            if (length == k) {
                firstNode = current;
                secondNode = head;
            }
            current = current.next;
        }
        int temp = firstNode.val;
        firstNode.val = secondNode.val;
        secondNode.val = temp;
        return head;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`