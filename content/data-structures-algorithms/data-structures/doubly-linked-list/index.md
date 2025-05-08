---
title: "Doubly Linked List"
date: 2023-12-29T15:41:09-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["SQL", "Java"]
---

A doubly-linked list is a more sophisticated form of linked list which includes a pointer to the next as well as the previous node in the sequence. This allows for a greater variety of O(n) operations, such as quick insertion/deletions from both ends amongst others.

First off, let's familiarize ourselves with what nodes look like in this data structure. Each node contains three fields: two link fields that point to the next and previous node in sequence and one data field for storing arbitrary data.

```java
public class Node {
    int data;
    Node prev;
    Node next;
}
```

The `prev` field points to the previous node in the list and `next` field refers to subsequent node. The `data` field can store or represent anything - an integer, a string or even an object of a class.

Unlike singly linked lists where navigation is forward-only, doubly-linked lists allow traversing backwards as well.


Now, let's move onto understanding time complexity involved in various operations of doubly linked lists:

Insertion Operation:
--------------------

Consider a scenario whereby we are required to insert elements at different positions.
* Adding an element at the beginning or end (head/tail), it takes constant O(1) time. We only need to adjust some pointers without needing traversal.
* Inserting at any given point however will require traversal thus leading to linear O(N) time where N represents location index.

Deletion Operation:
--------------------------

The same concepts also applies here.
* Deleting from beginning or end should happen in constant O(1) time.
* Deletion from specific position will take worst-case linear O(N) time as we may have traverse up till last element.

Search Operation:
----------------

Searching does not benefit from bidirectional nature of doubly linked lists. Just like most other linear data structures, the time complexity remains O(N) for worst-case scenario.

All in all, while doubly linked list offer certain enhancements over its single-linked counterpart, these come with their own costs as well. It storage overheads are more as it keeps an extra pointer to previous node. The need for such trade-off will greatly be reliant on type of application being developed.
