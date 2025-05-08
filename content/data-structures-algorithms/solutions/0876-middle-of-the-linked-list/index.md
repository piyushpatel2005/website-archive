---
title: "0876 Middle of the Linked List"
date: 2024-03-05T09:56:44-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["LinkedList", "Fast Slow Pointers"]
languages: ["Java"]
---

## Description 

Given the head of a singly linked list, return the middle node of the linked list.

If there are two middle nodes, return the second middle node.

### Example 1:

```
Input: head = [1,2,3,4,5]
Output: [3,4,5]
Explanation: The middle node of the list is node 3.
```

### Example 2:

```
Input: head = [1,2,3,4,5,6]
Output: [4,5,6]
Explanation: Since the list has two middle nodes with values 3 and 4, we return the second one.
```

### Constraints:

- The number of nodes in the list is in the range `[1, 100]`.
- `1 <= Node.val <= 100`

## Solution

### Brute Force - Using Array

If we convert the list into array, then we can easily find the middle of the list using its middle index. However, to convert to the an array, we will require at least single iteration which will be time complexity `O(n)`. This also requires new array of size `n`. In the problem constraint, we know that the list can be upto size 100. We can also track the size of the list when we iterate through the list to create a new array.

```java
class Solution {
    public ListNode middleNode (ListNode head) {
        ListNode[] arr = new ListNode[100];
        int i = 0; // track size of the list
        while (head != null) {
            arr[i++] = head;
            head = head.next;
        }
        return arr[i / 2];
    }
}
```

- Time Complexity: `O(n)` as we have to iterate through list once to populate an array.
- Space Complexity: `O(n)` because we need to create an array of size `n`

### Better Approach - Fast and Slow Pointers

This problem can be slowed with fast and slow pointers. The idea is to move fast pointer two position when slow pointer moves just single position. This way when the fast pointer reaches end of the list, the slow pointer will make it to the middle of the list.

```java
class Solution {
    public ListNode middleNode (ListNode head) {
        ListNode slow = head;
        ListNode fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }
        return slow;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`