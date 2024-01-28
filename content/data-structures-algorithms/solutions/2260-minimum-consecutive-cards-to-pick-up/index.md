---
title: "2260 Minimum Consecutive Cards to Pick Up"
date: 2023-12-24T00:42:56-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

You are given an integer array `cards` where `cards[i]` represents the value of the `i`th card. A pair of cards are **matching** if the cards have the **same** value.

Return the **minimum number of consecutive cards** you have to pick up to have a pair of matching cards among the picked cards. If it is impossible to have matching cards, return `-1`.
 

### Example 1:

```
Input: cards = [3,4,2,3,4,7]
Output: 4
Explanation: We can pick up the cards [3,4,2,3] which contain a matching pair of cards with value 3. Note that picking up the cards [4,2,3,4] is also optimal.
```

### Example 2:

```
Input: cards = [1,0,5,3]
Output: -1
Explanation: There is no way to pick up a set of consecutive cards that contain a pair of matching cards.
```

### Constraints:

- `1 <= cards.length <= 10^5`
- `0 <= cards[i] <= 10^6`

## Solution

### Using Sliding Window and HashMap

This problem could be solved using combination of sliding window and hashmap. We could use sliding window and at the same time store the minimum card to pick up in a variable. If we find duplicate number, we calculate the current distance and if it's smaller than current `minimumCardPickup`, we update the `minimumCardPickup` with new minimum value. Now, in order to keep track of current distance, we have to store previous index position somewhere. We can use `HashMap` for this. Everytime new value is encountered, we enter it's position in the map. If the item was already in the map, we know that we have found duplicate and we calculate current distance using `currentIndex - map[currentValue]`. We also have to make sure that we insert the new position to replace previous position to cover situations like `[1, 2, 3, 2, 2, 3, 4]`. In this case, if we are iterating from left, we might have found `minimumCardPikcup=3` for value 2. However, if we update the map with new index position, we will encounter next consecutive duplicates for 2 using `minimumCardPickup=2`. We also have to iterate until the end of the array to cover cases where the two consecutive numbers might be same like `[1, 2, 3, 1, 6, 6]`. In this case, if we exit prematurely, we might get minimum cards to pickup as 4, because in subarray `[1, 2, 3, 1]`, we encounter 1 after 3 elements. However, there is `[6, 6]` which would give us minimum cards to pick up as 2.

```java
class Solution {
    public int minimumCardPickup (int[] cards) {
        if (cards == null || cards.length == 0) {
            return -1;
        }
        int minimumCardPickup = Integer.MAX_VALUE;
        Map<Integer, Integer> positionMap = new HashMap<>();
        for (int i = 0; i < cards.length; i++) {
            if (!positionMap.containsKey(cards[i])) {
                positionMap.put(cards[i], i);
            } else {
                minimumCardPickup = Math.min(minimumCardPickup, i - positionMap.get(cards[i]) + 1);
                positionMap.put(cards[i], i);
            }
        }
        return minimumCardPickup == Integer.MAX_VALUE ? -1 : minimumCardPickup;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`

### Using HashMap to track Indices in Array

In this case, we can keep track of the last two indices in the `HashMap`. Essentially it's very similar to above solution.

```java
class Solution {
    public int minimumCardPickup2 (int[] cards) {
        if (cards == null || cards.length == 0) {
            return -1;
        }
        Map<Integer, List<Integer>> indices = new HashMap<>();

        int minimumCardPickup = Integer.MAX_VALUE;
        for (int i = 0; i < cards.length; i++) {
            if (!indices.containsKey(cards[i])) {
                List<Integer> indexList = new ArrayList<>();
                indexList.add(i);
                indices.put(cards[i], indexList);
            } else {
                // Here we may have more than two indices for a given card.
                // To keep only minimum difference indices, we need to find the minimum difference between two indices and store only those indices in this case.
                List<Integer> indexList = indices.get(cards[i]);
                if (indexList.size() == 2) {
                    indexList.remove(0);
                    indexList.add(i);
                } else {
                    indexList.add(i);
                }
                minimumCardPickup = Math.min(minimumCardPickup, indexList.get(1) - indexList.get(0) + 1);
            }
        }
        return minimumCardPickup == Integer.MAX_VALUE ? -1 : minimumCardPickup;
    }
}
```

- Time Complexity: `O(n)`. This solution is doing lot more but amortized time complexity is same as previous one.
- Space Complexity: `O(n)`. Space Complexity is also worse because for each number, we are storing two indices in map, but amortized space complexity is again same.

