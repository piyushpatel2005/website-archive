---
title: "1870 Minimum Speed to Arrive on Time"
date: 2023-10-13T20:02:59-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["Java"]
---

## Description

You are given a floating-point number `hour`, representing the amount of time you have to reach the office. To commute to the office, you must take `n` trains in sequential order. You are also given an integer array `dist` of length `n`, where `dist[i]` describes the distance (in kilometers) of the `i`th train ride.

Each train can only depart at an integer hour, so you may need to wait in between each train ride.

For example, if the 1st train ride takes 1.5 hours, you must wait for an additional 0.5 hours before you can depart on the 2nd train ride at the 2 hour mark.
Return the minimum positive integer speed (in kilometers per hour) that all the trains must travel at for you to reach the office on time, or -1 if it is impossible to be on time.

Tests are generated such that the answer will not exceed \\(10^7\\) and hour will have at most two digits after the decimal point.

## Examples

### Example 1:

**Input:** `dist = [1,3,2]`  and `hour = 6`

**Output:** `1`

**Explanation:** At speed `1`

- The first train ride takes 1/1 = 1 hour.
- Since we are already at an integer hour, we depart immediately at the 1 hour mark. The second train takes 3/1 = 3 hours.
- Since we are already at an integer hour, we depart immediately at the 4 hour mark. The third train takes 2/1 = 2 hours.
- You will arrive at exactly the 6 hour mark

### Example 2:

**Input:** `dist = [1,3,2]`, `hour = 2.7`

**Output:** `3`

**Explanation:** At speed `3`

- The first train ride takes 1/3 = 0.33333 hours.
- Since we are not at an integer hour, we wait until the 1 hour mark to depart. The second train ride takes 3/3 = 1 hour.
- Since we are already at an integer hour, we depart immediately at the 2 hour mark. The third train takes 2/3 = 0.66667 hours.
- You will arrive at the 2.66667 hour mark.

### Example 3:

**Input:** `dist = [1,3,2]`, `hour = 1.9`

**Output:** `-1`

**Explanation:** It is impossible because the earliest the third train can depart is at the 2 hour mark.

### Constraints:

- n == dist.length
- 1 <= n <= \\(10^5\\)
- 1 <= dist[i] <= \\(10^5\\)
- 1 <= hour <= \\(10^9\\)

There will be at most two digits after the decimal point in hour.

## Brute Force

In Brute force approach, as the problem states that the speed can be at max \\(10^7\\), so we can start from `speed=1` and iterate up to `speed=10e7` and for each iteration, we can check if the current speed will take us to the location at exact `hour` time. If not, move on to the next speed. If we have exhausted all iterations and we have not reached the location, at this point, we can return -1.

This solution looks trivial but is very time consuming.

- Time Complexity: `O(n) * O(m)`. Here `m` is the max speed we can have.
- Space Complexity: `O(1)`

## Better Solution

In this problem, the description clearly mentions that the tests will check for answers upto \\(10^7\\). So, we can assume that the speed will be 1 to \\(10^7\\) range. Now, to find the speed which satisfies this condition, we have a function `verify`. The purpose of this function is to verify if the given `speed` can solve the equation to reach on time. This basically loops through all elements of `dist` array and adds the time one by one. Finally returns boolean result whether this `speed` is the answer we are looking for.

Something that we can do in this case, is to arrive at the speed, we can use binary search. The `verify` function returns true if we can arrive on or before time `totalTime <= hour`. If this is the case, then we have to reduce our speed to arrive at exact time. For this we can quickly arrive to the right point using binary search. Everytime, we notice that we can arrive at the location before time, we reduce our speed by half. If we notice that we take more than the given `hour` duration, we increase our speed. 

```java
class Solution {
    public int minSpeedOnTime(int[] dist, double hour) {
        int left = 1, right = (int) 1e7;
        while (left < right) {
            int mid = (left + right) / 2;
            if (verify(dist, mid, hour)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return verify(dist, left, hour) ? left : -1;
    }

    /**
     * Check if we can arrive on or before given time with given speed
     * @param dist array of distances between cities
     * @param speed speed
     * @param hour time to arrive
     * @return true if we can arrive on time with given speed, false otherwise
     */
    private boolean verify(int[] dist, int speed, double hour) {
        double totalTime = 0;
        for (int i = 0; i < dist.length; ++i) {
            double timeSpent = dist[i] * 1.0 / speed;
            totalTime += (i == dist.length - 1 ? timeSpent : Math.ceil(timeSpent));
        }
        return totalTime <= hour;
    }
}
```

In this case, we are able to solve the problem with time complexity of `O(n log (right - left))`. `n` because we are iterating through each element of the `dist` array and `log (right - left)` as we are using binary search to reach optimal speed. Also in this case, we are not using any other variable for storing values, so the space complexity is constant.

- Time Complexity: `O(n log (right - left))`
- Space Complexity: `O(1)`