---
title: "0771 Jewels and Stones"
date: 2023-12-25T01:46:05-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

You're given strings `jewels `representing the types of stones that are jewels, and `stones` representing the stones you have. Each character in `stones` is a type of stone you have. You want to know how many of the stones you have are also jewels.

Letters are case sensitive, so `"a"` is considered a different type of stone from `"A"`.

### Example 1:

```
Input: jewels = "aA", stones = "aAAbbbb"
Output: 3
```

### Example 2:

```
Input: jewels = "z", stones = "ZZ"
Output: 0
```

### Constraints:

- `1 <= jewels.length, stones.length <= 50`
- `jewels` and `stones` consist of only English letters.
- All the characters of jewels are **unique**.

## Solution

### Brute Force

The brute force approach for this will be to iterate through each character of `stones` and verify if there exists matching character in `jewels`. If yes, then we simply increment the `count`.

```java
class Solution {
    public int numJewelsInStonesBrute(String jewels, String stones) {
        int count = 0;
        for (char c: stones.toCharArray()) {
            if (jewels.indexOf(c) != -1) {
                count++;
            }
        }
        return count;
    }
}
```

This solution even though works is suboptimal. 

- Time Complexity: `O(m * n)` where `m = length of stones` and `n = length of jewels`. `indexOf()` function also takes linear time.
- Space Complexity: `O(1)`

### Using Array

We can use array to keep track of which characters occur in `jewels`. Next time, when iterating over `stones`, we just have to check in this array to make sure that character was present in the `jewels`. If it was present, we increment the `count` by 1. In order to save space, we can store 52 English characters in their respective position. So, the operation becomes little more complicated than usual. Alternatively, we could create an array of size 123 to cover both uppercase English characters (index position 65 to 90) and lowercase English character (index position 97 to 122).

```java
class Solution {
    public int numJewelsInStones(String jewels, String stones) {
        int count = 0;
        int[] map = new int[52];
        for (char c: jewels.toCharArray()) {
            if (Character.isUpperCase(c)) {
                map[c - 'A'] = 1;
            } else {
                map[c - 'a' + 26] = 1;
            }
        }
        for (char c: stones.toCharArray()) {
            if (Character.isUpperCase(c) && map[c - 'A'] == 1) {
                count++;
            } else if (Character.isLowerCase(c) && map[c - 'a' + 26] == 1) {
                count++;
            }
        }
        return count;
    }
}
```

- Time Complexity: `O(m + n)`, where `m = length of stones` and `n = length of jewels`
- Space Complexity: `O(1)` - constant space because the size of the `map` is fixed

### Using Hashing

In this approach, we can store the `jewels` characters in HashSet or HashMap and when iterating through `stones`, we check if we have seen this character in `jewels` string. If yes, increment the `count`.

```java
class Solution {
    public int numJewelsInStones (String jewels, String stones) {
        int count = 0;
        Set<Character> set = new HashSet<>();
        for (char c: jewels.toCharArray()) {
            set.add(c);
        }
        for (char c: stones.toCharArray()) {
            if (set.contains(c)) {
                count++;
            }
        }
        return count;
    }
}
```

- Time Complexity: `O(m + n)`, where `m = length of stones` and `n = length of jewels`
- Space Complexity: `O(n)` - linear space because the size of the set is proportional to the number of `jewels`