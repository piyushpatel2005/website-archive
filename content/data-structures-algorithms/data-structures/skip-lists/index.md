---
title: "Skip Lists"
date: 2023-12-29T15:41:34-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["SQL", "Java"]
---

## What is Skip list?

A skip list is a type of data structure that allows fast search within an ordered sequence of elements. It works by maintaining multiple lists, each subsequentially skipping a few items. It's analogous to express lanes on a highway which let you skip past many items normally encountered at the local lane level. 

This structure allows quick access to elements while still maintaining a relatively simple implementation, making it a useful tool in certain programming and computing scenarios. In Java, the SkipListMap and the SkipListSet from the java.util.concurrent package implement the functionalities of skip lists.

1. **Search Operation**: The search operation in a skip list begins from the top leftmost corner node and slides down to the required node. If the target value is smaller than the current node, it simply moves down, else it moves to the next reference. The time complexity of this operation is O(log n).

2. **Insertion Operation**: Similar to searching, insertion also begins from the top leftmost corner and finds its suitable place. Once found, it starts inserting nodes in each level with a probabilistic approach using coin-flipping until it reaches level 1. Here also we have O(log n) time complexity because generally half of the elements will be on Level 2, one-fourth on Level 3…and so on.

3. **Deletion Operation**: Deletion again starts from leftmost top corner and start removing all references associated with the target value till we reach level 1 where the actual node exists and deletes that node as well too. This operation follows O(log n) time complexity.

4. **Update Operation**: If an element needs to be updated or modified in a skip list, it simply performs deletion followed by an insert operation. Hence update also has O(log n) time complexity.

Please note: All these operations assume that our skip list is perfectly balanced i.e., every step we discard half of remaining elements which leads us to log n steps and thus makes operations execute in logarithmic order.

## Practical Use cases for Skip lists

Skip Lists have various real-world applications due to their efficiency and simplicity. Here are a few examples:

1. **Database Indexing**: They are widely used in databases for indexing purposes mainly because of their fast search capabilities compared to other data structures like B-trees or Red Black trees.

2. **Memory Efficient**: As Skip Lists don't require the balancing operations that some other self-balancing search algorithms need, they can be quite space-efficient. This makes them suitable for use in memory-tight situations.

3. **Network Systems**: Skip lists come into play as routers in network systems to store IP-address tables, where each IP address is mapped to an outgoing network link.

4. **Operating Systems**: Used in Operating systems for maintaining timer events and processes scheduling.

5. **Real-Time Applications**: They're great for applications that need real-time access due to their high efficiency when it comes to searching, inserting, deleting operations.

6. **Redis**: Redis, an in-memory database/data structure store uses sorted sets amongst its data types which is implemented via a type of Skip List (along with a HashTable).