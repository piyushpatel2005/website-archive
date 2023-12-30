---
title: "1295 Find Numbers With Even Number of Digits"
date: 2023-11-03T15:21:41-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Array"]
languages: ["Java"]
---

## Description

Given an array `nums` of integers, return how many of them contain an even number of digits.

### Example 1:

```
Input: nums = [12,345,2,6,7896]
Output: 2
Explanation: 
12 contains 2 digits (even number of digits). 
345 contains 3 digits (odd number of digits). 
2 contains 1 digit (odd number of digits). 
6 contains 1 digit (odd number of digits). 
7896 contains 4 digits (even number of digits). 
Therefore only 12 and 7896 contain an even number of digits.
```

### Example 2:

```
Input: nums = [555,901,482,1771]
Output: 1 
Explanation: 
Only 1771 contains an even number of digits.
```

### Constraints:

- `1 <= nums.length <= 500`
- `1 <= nums[i] <= 10^5`

## Solution

The simplest idea will be to convert each of the numbers into string and then for each string, check if their length is even or odd.

```java
class Solution {
    public int findNumbers(int[] nums) {
        int evenDigits = 0;
        for (int num: nums) {
            if (String.valueOf(num).length() % 2 == 0) {
                evenDigits++;
            }
        }
        return evenDigits;
    }
}
```

Time Complexity: `O(n log m)` where n = length of `nums` and `m` = maximum integer in `nums`.
Space Complexity: `O(log m)`

Another alternative to this approach is to extract the digits from each number in `nums` array and check if it contains even number of digits. In this case, we will not be creating any string, we are only creating fixed number of variables regardless of the size of `nums`. So, this gives us improvement in space complexity to `O(1)`.

To find if the number has even number of digits, we can create a helper method.

```java
class Solution {
    public int findNumbers(int[] nums) {
        int eventDigits = 0;
        for (int num : nums) {
            if (hasEvenDigits(num)) {
                eventDigits++;
            }
        }
        return eventDigits;
    }

    private boolean hasEvenDigits(int num) {
        int digits = 0;
        while (num > 0) {
            num = num / 10;
            digits++;
        }
        return digits % 2 == 0;
    }
}
```