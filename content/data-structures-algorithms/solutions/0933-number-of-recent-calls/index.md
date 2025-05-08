---
title: "0933 Number of Recent Calls"
date: 2024-07-24T11:20:44-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Stacks and Queues"]
languages: ["Java"]
---

## Description

You have a `RecentCounter` class which counts the number of recent requests within a certain time frame.

Implement the `RecentCounter` class:

- `RecentCounter()` Initializes the counter with zero recent requests.
- `int ping(int t)` Adds a new request at time `t`, where `t` represents some time in milliseconds, and returns the number of requests that has happened in the past `3000` milliseconds (including the new request). Specifically, return the number of requests that have happened in the inclusive range `[t - 3000, t]`.

It is **guaranteed** that every call to ping uses a strictly larger value of `t` than the previous call.

### Example 1:

```
Input
["RecentCounter", "ping", "ping", "ping", "ping"]
[[], [1], [100], [3001], [3002]]
Output
[null, 1, 2, 3, 3]

Explanation
RecentCounter recentCounter = new RecentCounter();
recentCounter.ping(1);     // requests = [1], range is [-2999,1], return 1
recentCounter.ping(100);   // requests = [1, 100], range is [-2900,100], return 2
recentCounter.ping(3001);  // requests = [1, 100, 3001], range is [1,3001], return 3
recentCounter.ping(3002);  // requests = [1, 100, 3001, 3002], range is [2,3002], return 3
```

### Constraints:

- `1 <= t <= 10^9`
- Each test case will call `ping` with strictly increasing values of `t`.
- At most `10^4` calls will be made to `ping`.

## Solution

Based on problem, it seems like a sliding window problem where we need to keep pings between `[t - 3000, t]` in a container like array and every time we need to iterate through that array to find the count. However, if we keep appending new `ping` to the array, the space complexity will become large upto `O(n)` and for ever increasing input, this will be prohibitively large. We do not need older ping information as they will not contribute to results as we move further in time. So, it's probably best to use it with a queue like structure where we can remove elements based on FIFO pattern. If we use array, they will have fixed size allocated, so array may not be a great choice. How about Lists? In Lists, we can append new element at the `tail` and remove elements from the `head` which is precisely what we want. We have to use `LinkedList` and not generic `List` or `ArrayList` during declaration because `addLast()` method exists only in `LinkedList` class.


```java
class RecentCounter() {
    private LinkedList<Integer> slideWindow;

    public RecentCounter() {
        slideWindow = new LinkedList<>(); // important to use LinkedList
    }

    public int ping(int t) {
        // append element at the tail of the list
        this.slideWindow.addLast(t);

        // remove older elements from the head of the list if they are older than 3000
        while (this.slideWindow.getFirst() < t - 3000) {
            this.slideWindow.removeFirst();
        }

        return this.slideWindow.size();
    }
}
```

- Time Complexity: `O(1)` because insertion into `LinkedList` is constant operation and we may need at most 3000 iterations to remove elements in the iteration. That is `O(3000)` which is constant time in the worst case.
- Space Complexity: `O(1)`, we may have maximum `3000` elements in the list.