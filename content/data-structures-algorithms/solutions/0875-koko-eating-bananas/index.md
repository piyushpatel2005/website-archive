---
title: "0875 Koko Eating Bananas"
date: 2025-01-31T16:54:49-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["Java"]
---

## Description

Koko loves to eat bananas. There are `n` piles of bananas, the `ith` pile has `piles[i]` bananas. The guards have gone and will come back in `h` hours.

Koko can decide her bananas-per-hour eating speed of `k`. Each hour, she chooses some pile of bananas and eats `k` bananas from that pile. If the pile has less than `k` bananas, she eats all of them instead and will not eat any more bananas during this hour.

Koko likes to eat slowly but still wants to finish eating all the bananas before the guards return.

Return the minimum integer `k` such that she can eat all the bananas within `h` hours.

 
### Example 1:

```plaintext
Input: piles = [3,6,7,11], h = 8
Output: 4
```

In this case, Koko can eat at most 4 bananas per hour. This way in first hour, she will eat 3 bananas, in next two hours (4 and 2), in next hour 4 and 3 and in the last three hours she will eat 4, 4, 3 bananas from 11 bananas pile. If Koko eats at speed lower than 4, she will not finish all bananas in `h` hours. 

### Example 2:

```
Input: piles = [30,11,23,4,20], h = 5
Output: 30
```

### Example 3:

```
Input: piles = [30,11,23,4,20], h = 6
Output: 23
```

### Constraints:

- `1 <= piles.length <= 10^4`
- `piles.length <= h <= 10^9`
- `1 <= piles[i] <= 10^9`

## Solution

### Brute Force approach

The brute force approach would check all possible values of `k` and check if it is possible to finish eating all the bananas in `h` hours. This would take `O(n * h)` time, where `n` is the number of piles. This is very inefficient as the time complexity will be `O(n^2)`.

In brute force approach, we can start at a minimum speed of 1 and increase until we find the answer. We can continue increasing the speed until the time taken to finish eating all bananas becomes greater than `h`. At this point, we can break out of the loop and return the answer.

```java
class Solution {
    public int minEatingSpeed (int[] piles, int h) {
        int speed = 1;

        while (true) {
            int timeSpent = 0;
            for (int pile: piles) {
                timeSpent += Math.ceil(pile * 1.0 / speed);
                if (timeSpent > h) {
                    break;
                }
            }

            if (timeSpent <= h) {
                return speed;
            } else {
                speed += 1;
            }
        }
    }
}
```

- Time Complexity: `O(n * h)` where n length of piles and h is the minimum speed
- Space Complexity: `O(1)`

### Binary Search

The maximum possikble speed in this problem can be equal to the maximum element of the array `piles`. In that case, Koko eats full stack and then eats other piles in every hour. Now to find the optimal speed, we can use binary search. If Koko can finish eating bananas all piles of bananas with speed `n`, she can also finish eating all piles with speed `n + 1`. So, to find minimum speed is guaranteed to be less than or equal to `n`. We can use this concept to find the minimum speed using binary search.

If the time taken to finish eating all bananas is more than `h` that means the banana eating speed is slow and we need to look to the right side of the current speed.

```java
class Solution {
    public int minEatingSpeed(int[] piles, int h) {
        int left = 1, right = piles.length;
        for (int pile: piles) {
            right = Math.max(right, pile);
        }

        while (left < right) {
            int middle = (left + right) / 2;
            int timeSpent = 0;

            for (int pile: piles) {
                timeSpent += Math.ceil(pile * 1.0 / middle);
            }

            // If middle speed can finish eating bananas, then move right to middle to find even lower possible speed.
            if (timeSpent <= h) {
                right = middle;
            } else {
                left = middle + 1;
            }
        }

        return right;
    }
}
```

- Time Complexity: `O(n * log m)`
- Space Complexity: `O(1)`