---
title: "0346 Moving Average From Data Stream"
date: 2024-07-25T10:11:37-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Stacks and Queues"]
languages: ["Java"]
---

## Description

Given a stream of integers and a window size, calculate the moving average of all integers in the sliding window.

Implement the `MovingAverage` class:

- `MovingAverage(int size)` Initializes the object with the size of the window `size`.
- `double next(int val)` Returns the moving average of the last `size` values of the stream.
 

### Example 1:

```
Input
["MovingAverage", "next", "next", "next", "next"]
[[3], [1], [10], [3], [5]]
Output
[null, 1.0, 5.5, 4.66667, 6.0]

Explanation
MovingAverage movingAverage = new MovingAverage(3);
movingAverage.next(1); // return 1.0 = 1 / 1
movingAverage.next(10); // return 5.5 = (1 + 10) / 2
movingAverage.next(3); // return 4.66667 = (1 + 10 + 3) / 3
movingAverage.next(5); // return 6.0 = (10 + 3 + 5) / 3
``` 

### Constraints:

- `1 <= size <= 1000`
- `-10^5 <= val <= 10^5`
- At most `10^4` calls will be made to `next`.

## Solution

This is yet another Queue problem where we need FIFO structure. We want to add new elements at one end but those are also the ones which will be removed once the size is `size`. 

### Using Array or LinkedList

In order to implement this, we could use array or linkedlist.

```java
class MovingAverage {
    private int size;
    List<Integer> queue;

    public MovingAverage(int size) {
        this.size = size;
        queue = new ArrayList<>();
    }

    public double next(int val) {
        queue.add(val);
        int windowSum = 0;
        int windowSize = Math.min(size, queue.size());
        for (int i = queue.size() - windowSize; i < queue.size(); i++) {
            windowSum += queue.get(i);
        }
        return windowSum / (double) windowSize;
    }
}
```

- Time Complexity: `O(n * k)`: where `n` = size of the moving window and `k` = number of elements elements added to queue.
- Space Complexity: `O(k)` where `k`= number of elements added to the queue.

### Using `ArrayDeque`

We could use one of the built-in classes in Java `ArrayDeque` to behave like a queue. In this case, every time we add new element, we also have to remove an element from the beginning of the queue when our queue is bigger than the window size. If this is not the case, we can simply return `0`.

```java
class MovingAverage {
    int size;
    int windowSum = 0;
    int count = 0;
    Deque<Integer> queue = new ArrayDeque<>();

    public MovingAverage (int size) {
        this.size = size;
    }

    public double next(int val) {
        count++;
        queue.add(val);
        int tail = count > size ? (int) queue.poll() : 0;
        windowSum = windowSum - tail + val;
        return (double) windowSum / Math.min(size, count);
    }
}
```

- Time Complexity: `O(1)` since adding an element to `ArrayDeque` is constant time operation.
- Space Complexity: `O(n)` where `n` = size of the moving window