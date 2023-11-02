---
title: "1732 Find the Highest Altitude"
date: 2023-11-02T15:21:13-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Preprocessing", "Prefix Sum"]
languages: ["Java"]
---

## Description
There is a biker going on a road trip. The road trip consists of `n + 1` points at different altitudes. The biker starts his trip on point `0` with altitude equal `0`.

You are given an integer array `gain` of length `n` where `gain[i]` is the net gain in altitude between points `i`​​​​​​ and `i + 1` for all (`0 <= i < n`). Return the highest altitude of a point.

### Example 1:

```example
Input: gain = [-5,1,5,0,-7]
Output: 1
Explanation: The altitudes are [0,-5,-4,1,1,-6]. The highest is 1.
```

### Example 2:

```example
Input: gain = [-4,-3,-2,-1,4,3,2]
Output: 0
Explanation: The altitudes are [0,-4,-7,-9,-10,-6,-3,-1]. The highest is 0.
```

### Constraints:

- `n == gain.length`
- `1 <= n <= 100`
- `-100 <= gain[i] <= 100`

## Solution

This is direct prefixSum with highest value in the prefix sum array being the output. In this case, we can save some space by actually not calculating prefixSum, but keeping track of the highest value we get for that array.

```java
class Solution {
    public int largestAltitude(int[] gain) {
        int max = 0; // we start at 0
        int current = 0;
        for (int i = 0; i < gain.length; i++) {
            current += gain[i];
            if (current > max) {
                max = current;
            }
        }
        return max;
    }
}
```

