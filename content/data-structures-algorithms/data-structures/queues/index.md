---
title: "Queues"
date: 2023-12-29T15:42:21-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["SQL", "Java"]
---

A queue in Java (and in many other programming languages) is a collection or list that organizes elements in a sequence. The elements are distinct by their characteristics of FIFO, which stands for First-In-First-Out: the element that gets added first also gets removed first.

In simpler terms, think of a real-life queue like people standing in line for buying tickets - the person who comes first, gets served first.

Java provides a Queue interface which is part of Java’s collections framework. It supports different types of methods including insertion, removal and inspection methods:

1. **Insertion Methods**: These methods add an element to the end of the queue.
   - add(e): This method throws an exception if it fails to insert the element.
   - offer(e): This method returns false if it fails to insert the element.

2. **Removal Methods**: These remove an element from the front/head of the queue.
   - remove(): When the queue is empty, this method throws an exception.
   - poll(): If there's no element when trying to poll(), it will not throw any exception but return

## Time Complexities

The time complexity for different operations on a queue data structure are as follows:

1. **Insertion (enqueue)**: This operation puts an element at the end of the queue. The time complexity is O(1), because this operation always takes the same amount of time, regardless of the size of the queue.

2. **Removal (dequeue)**: This removes an element from the front/head of the queue. The time complexity is also O(1), since this operation too does not depend on the size of the queue.

3. **Peek/Front**: This returns the element at the front/head of the queue without removing it. The time complexity for this operation is again O(1) because you are only accessing and returning a single element.

4. **IsEmpty/IsFull**: Checking if a queue is empty or full has a constant time complexity, O(1).

In short, all primary operations on a Queue data structure – insertion, removal, and peeking – occur in constant time i.e., their performance is quick and independent from size of the Queue.

### Examples

**Java:**

```java
import java.util.LinkedList;
import java.util.Queue;

public class Main {
  public static void main(String[] args) {

    Queue<Integer> queue = new LinkedList<>();

    // Adds elements {0, 1, 2, 3, 4} to the queue
    for (int i=0; i<5; i++) 
      queue.add(i);

    // Display contents of the queue.
    System.out.println("Elements of queue: "+queue);

    // To remove the head of the queue.
    int removedElement = queue.remove();
    System.out.println("Removed element: " + removedElement);

    // To view the head of queue
    int head = queue.peek();
    System.out.println("head of queue: " + head);

   // Rest all methods of collection interface like size and contains can be used with this implementation.
   int size = queue.size();
   System.out.println("Size of queue: " + size);
  }
}
```
  

**Python:**

```python
from collections import deque

#initialize a queue by creating instance from deque class from collections module.
queue = deque()

#enqueue elements at end of queue
for i in range(5):
  queue.append(i)

#prints “deque([0, 1, 2, 3, 4])”
print('Initial deque:',queue)

#dequeue elements from front of dequeue
removed_element = queue.popleft()
print('Dequeued element:', removed_element)

#accessing first element (this does not dequeue)
first_elem = queue[0] 
print('First element:', first_elem)

#getting length
size_of_queue=len(queue)
print('Size of dequeue:',size_of_queue)
```

## Practical Use Cases

1. **Telecommunications:** In telecommunication networks, queues are used to control packets of information and manage bandwidth. This helps prioritize data transfer requests and organize them efficiently.

2. **Computer Systems:** Most computer systems use queues as part of their job scheduling function, ensuring tasks are carried out in the correct order.

3. **Customer Service:** Queues can simulate real-world waiting lines as seen in customer service scenarios such as ticket booking systems or call handling.

4. **Print Jobs:** Print jobs typically use queue data structures where the first request is the first one to be executed (First-In-First-Out mechanism).

5. **E-commerce Websites:** High-demand services like ticketing websites use queues to handle user requests during peak times, ensuring fairness access and system stability.

6. **Data Streaming Services**: Data streaming architectures use queues for managing real-time data processing - these streams might involve continuous aggregations, filtering, and categorizing of incoming live data which is then queued up accordingly for onward consumption by event-processing applications.
  
7. **Operating Systems:** In multi-tasking environments, various processes have to wait for CPU time slice or I/O operations – such process control management uses Queue like structure called “Process Control Blocks” for task scheduling.

## Priority Queue

A priority queue is a special type of queue in which elements are queued based on their priority. Unlike the common queue data structure where an element is dequeued in FIFO order, the one with highest priority will be dequeued from a priority queue before the one with lower priority. If two elements have the same priority, they are served according to their ordering in the queue.

In some applications, certain tasks need to be prioritized over others, hence they need to be performed first - this is where a Priority Queue comes into play. 

Here's how you can use it:

**In Java:**
```
import java.util.*;

class Example {
    public static void main(String args[]) {
        PriorityQueue<Integer> pQueue = new PriorityQueue<Integer>();
        
        // Adding items to the pQueue using add() 
        pQueue.add(10);
        pQueue.add(20);
        pQueue.add(15);
        
        // Printing the top element of PriorityQueue 
        System.out.println(pQueue.peek());
        
        // Removing the top priority element (or head) and printing 
        System.out.println(pQueue.poll());
        
        // Printing all elements 
        Iterator itr = pQueue.iterator();
      while(itr.hasNext())
            System.out.println(itr.next());
     }
}
```

**In Python:**
```
import heapq

# Creating empty priority queue
priority_queue = []

# Adding elements to the queue
heapq.heappush(priority_queue, 10)
heapq.heappush(priority_queue, 30)
heapq.heappush(priority_queue, 20)

# Removing element from the queue
print(heapq.heappop(priority_queue)) # prints 10

# printing remaining elements
for i in range(len(priority_queue)):
    print(heapq.heappop(priority_queue), end=", ") # prints 20, 30,
```

Again, do keep in mind that high and low priorities can be subjective to implementation. In above examples lowest value had the highest priority.

### Advantages

Priority queues have several advantages:

1. **Versatility:** Priority queues are versatile and can be used to model a wide variety of scenarios.
2. **Efficiency:** They are efficient for high priority items since these items take precedence over lower priority items.
3. **Responsiveness:** By prioritizing tasks, a system can better manage its resources, resulting in more responsive performance.

## Use cases for Priority Queues

1. **Job scheduling on computers:** One of the most common uses of Priority Queue is in the operating system where it is used to schedule jobs based on their priority.
2. **Traffic shaping/ Packet routing in Networks:** In networking, packets are assigned a priority and then they are transmitted based on the priority using the priority queues concept.
3. **Medical Systems** - Especially in emergency healthcare situations, patients must be treated based on the severity of their condition rather than the order they arrive in. Thus, doctors use a form of a priority queue when triaging patients for treatment.
4. **Event-driven simulations**: Sometimes events must be processed based on their time of occurrence which means a high-priority task usually means one that should be done soonest (like queuing up animations or AI scripts).
5. **Huffman coding**, used for lossless data compression is implemented using priority queue data structure.