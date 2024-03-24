---
title: "0707 Design Linked List"
date: 2024-03-21T20:02:39-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["LinkedList"]
languages: ["Java"]
---

## Description

Design your implementation of the linked list. You can choose to use a singly or doubly linked list.
A node in a singly linked list should have two attributes: `val` and `next`. `val` is the value of the current node, and `next` is a pointer/reference to the next node.
If you want to use the doubly linked list, you will need one more attribute `prev` to indicate the previous node in the linked list. Assume all nodes in the linked list are *0-indexed*.

Implement the `MyLinkedList` class:

- `MyLinkedList()`: Initializes the `MyLinkedList` object.
- `int get(int index)`: Get the value of the `index`th node in the linked list. If the `index` is invalid, return `-1`.
- `void addAtHead(int val)`: Add a node of value `val` before the first element of the linked list. After the insertion, the new node will be the first node of the linked list.
- `void addAtTail(int val)`: Append a node of value `val` as the last element of the linked list.
- `void addAtIndex(int index, int val)` Add a node of value `val` before the `index`th node in the linked list. If `index` equals the length of the linked list, the node will be appended to the end of the linked list. If `index` is greater than the length, the node will not be inserted.
- `void deleteAtIndex(int index)`: Delete the `index`th node in the linked list, if the `index` is valid.
 

### Example 1:

```
Input
["MyLinkedList", "addAtHead", "addAtTail", "addAtIndex", "get", "deleteAtIndex", "get"]
[[], [1], [3], [1, 2], [1], [1], [1]]
Output
[null, null, null, null, 2, null, 3]

Explanation
MyLinkedList myLinkedList = new MyLinkedList();
myLinkedList.addAtHead(1);
myLinkedList.addAtTail(3);
myLinkedList.addAtIndex(1, 2);    // linked list becomes 1->2->3
myLinkedList.get(1);              // return 2
myLinkedList.deleteAtIndex(1);    // now the linked list is 1->3
myLinkedList.get(1);              // return 3
```

### Constraints:

- `0 <= index, val <= 1000`
- Please do not use the built-in `LinkedList` library.
- At most `2000` calls will be made to `get`, `addAtHead`, `addAtTail`, `addAtIndex` and `deleteAtIndex`.

## Solution

```java
class ListNode {
    int val;
    ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}


class MyLinkedList {

    public ListNode head;
    public int val;

    public MyLinkedList() {
        this.head = null;
        this.val = 0;
    }

    public int get(int index) {
        ListNode current = head;
        while (current != null && index > 0) {
            current = current.next;
            index--;
        }
        return current == null ? -1 : current.val;
    }

    public void addAtHead(int val) {
        ListNode newNode = new ListNode(val);
        newNode.next = head;
        head = newNode;
    }

    public void addAtTail(int val) {
        ListNode newNode = new ListNode(val);
        if (head == null) {
            head = newNode;
            return;
        }
        ListNode current = head;
        while (current.next != null) {
            current = current.next;
        }
        current.next = newNode;
    }

    public void addAtIndex(int index, int val) {
        if (index == 0) {
            addAtHead(val);
            return;
        }
        ListNode newNode = new ListNode(val);
        ListNode current = head;
        while (current != null && index > 1) {
            current = current.next;
            index--;
        }
        if (current == null) {
            return;
        }
        newNode.next = current.next;
        current.next = newNode;
    }

    public void deleteAtIndex(int index) {
        if (index == 0) {
            head = head.next;
            return;
        }
        ListNode current = head;
        while (current != null && index > 1) {
            current = current.next;
            index--;
        }
        if (current == null || current.next == null) {
            return;
        }
        current.next = current.next.next;
    }
}
```