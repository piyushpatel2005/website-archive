---
title: "2300 Successful Pairs of Spells and Potions"
date: 2024-10-02T08:58:37-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["Java"]
---

## Description

You are given two positive integer arrays `spells` and `potions`, of length `n` and `m` respectively, where `spells[i]` represents the strength of the `ith` spell and `potions[j]` represents the strength of the `jth` potion.

You are also given an integer `success`. A spell and potion pair is considered successful if the **product** of their strengths is **at least** `success`.

Return an integer array `pairs` of length `n` where `pairs[i]` is the number of potions that will form a successful pair with the `ith` spell.

 

### Example 1:

```plaintext
Input: spells = [5,1,3], potions = [1,2,3,4,5], success = 7
Output: [4,0,3]
Explanation:
- 0th spell: 5 * [1,2,3,4,5] = [5,10,15,20,25]. 4 pairs are successful.
- 1st spell: 1 * [1,2,3,4,5] = [1,2,3,4,5]. 0 pairs are successful.
- 2nd spell: 3 * [1,2,3,4,5] = [3,6,9,12,15]. 3 pairs are successful.
Thus, [4,0,3] is returned.
```

### Example 2:

```plaintext
Input: spells = [3,1,2], potions = [8,5,8], success = 16
Output: [2,0,2]
Explanation:
- 0th spell: 3 * [8,5,8] = [24,15,24]. 2 pairs are successful.
- 1st spell: 1 * [8,5,8] = [8,5,8]. 0 pairs are successful. 
- 2nd spell: 2 * [8,5,8] = [16,10,16]. 2 pairs are successful. 
Thus, [2,0,2] is returned.
```

### Constraints:

- `n == spells.length`
- `m == potions.length`
- `1 <= n, m <= 10^5`
- `1 <= spells[i], potions[i] <= 10^5`
- `1 <= success <= 10^10`


## Solution

There are couple of approaches to solve this problem. 

### 1: Brute Force

The brute force approach is to iterate over all the spells and potions and check if the product of their strengths is at least `success`. If it is, then increment the count of successful pairs for that spell.

```java
public int[] successfulPairs(int[] spells, int[] potions, int success) {
    int n = spells.length;
    int m = potions.length;
    int[] pairs = new int[n];
    
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if ((long)spells[i] * potions[j] >= success) {
                pairs[i]++;
            }
        }
    }
    
    return pairs;
}
```

### 2. Binary Search

In this case, we can sort the `potions` array and for each spell, we can find the number of potions that will form a successful pair using binary search. 

```java
class Solution {
    public int[] successfulPairs (int[] spells, int[] potions, long success) {
        int n = spells.length;
        int m = potions.length;
        int[] pairs = new int[n];
        Arrays.sort(potions);
        int maxPotion = potions[m - 1];

        for (int i = 0; i < n; i++) {
            long target = (long) Math.ceil(1.0 * success / spells[i]);
            if (target > maxPotion) {
                pairs[i] = 0;
                continue;
            }

            int firstIndex = indexForNumberLowerThanTarget(potions, (int) target);
            pairs[i] = m - firstIndex;
        }
        return pairs;
    }

    private int indexForNumberLowerThanTarget(int[] arr, int target) {
        int left = 0;
        int right = arr.length;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left < arr.length ? left : -1;
    }
}