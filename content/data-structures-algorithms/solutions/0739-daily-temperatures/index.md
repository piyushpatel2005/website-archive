---
title: "0739 Daily Temperatures"
date: 2024-07-25T13:59:36-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Stacks and Queues"]
languages: ["Java"]
---

## Description

Given an array of integers `temperatures` represents the daily temperatures, return an array `answer` such that `answer[i]` is the number of days you have to wait after the `ith` day to get a warmer temperature. If there is no future day for which this is possible, keep `answer[i] == 0` instead.

### Example 1:

```
Input: temperatures = [73,74,75,71,69,72,76,73]
Output: [1,1,4,2,1,1,0,0]
```

### Example 2:

```
Input: temperatures = [30,40,50,60]
Output: [1,1,1,0]
```

### Example 3:

```
Input: temperatures = [30,60,90]
Output: [1,1,0]
```

### Constraints:

- `1 <= temperatures.length <= 10^5`
- `30 <= temperatures[i] <= 100`

## Solution:

The problem has given list of daily temperatures. The goal is to find the number of days after which you will get temperature greater than current day. Notice that on the last day, because there is no next temperature for `i+1`th day, you will always get number of days `0` for the last day.

### Brute Force

In brute force approach, you can iterate through the array for each element and check the next available temperature which is higher than current one. While traversing, also keep track of number of days you had to traverse in order to find the number of days for `i`th day. You repeat this operation for all elements of the array.

```java
class Solution {
    public int[] dailyTemperaturesBrute(int[] temperatures) {
        int[] result = new int[temperatures.length];

        for (int i = 0; i < temperatures.length; i++) {
            int numDays = 0;
            for (int j = i + 1; j < temperatures.length; j++) {
                if (temperatures[j] > temperatures[i]) {
                    numDays = j - i;
                    break;
                }
            }
            result[i] = numDays;
        }
        return result;
    }
}
```

### Using Monotonic Stack

Monotonic stacks can be a great option if we have a problem where ordering is important.

When iterating over input array of `temperatures`, we can `push` each temperature into a stack. When we move to the next element, at that point we will be calculating number of days for the previous day. In order to do that, we can insert index position of each day into the stack rather than temperatures. This way to find the number of days, we will have to `pop` each tempeture until we find a temperature that is smaller than current one. This way we will have to find the difference between those two indices to find the number of days.

```java

class Solution {
    public int[] dailyTemperatures(int[] temperatures) {
        int[] result = new int[temperatures.length];
        Stack<Integer> stack = new Stack<>();

        for (int current = 0; current < temperatures.length; current++) {
            while (!stack.isEmpty() && temperatures[current] > temperatures[stack.peek()]) {
                int previous = stack.pop();
                result[previous] = current - previous;
            }
            stack.push(current);
        }
        return result;
    }
}
```

- Time Complexity: Each element can be added to the stack only once. So, this algorithm gives time complexity of `O(n)` even though there is inner `while` loop.
- Space Complexity: At most, we may need to store all elements of the input array into stack which might give worst case time complexity of `O(n)`
