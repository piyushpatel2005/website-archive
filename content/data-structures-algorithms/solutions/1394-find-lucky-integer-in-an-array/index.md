---
title: "1394 Find Lucky Integer in an Array"
date: 2023-12-27T01:50:09-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing", "Sorting", "Array"]
languages: ["Java"]
---

## Description

Given an array of integers `arr`, a lucky integer is an integer that has a frequency in the array equal to its value.

Return the largest lucky integer in the array. If there is no lucky integer return `-1`.


### Example 1:

```
Input: arr = [2,2,3,4]
Output: 2
Explanation: The only lucky number in the array is 2 because frequency[2] == 2.
```

### Example 2:

```
Input: arr = [1,2,2,3,3,3]
Output: 3
Explanation: 1, 2 and 3 are all lucky numbers, return the largest of them.
```

### Example 3:

```
Input: arr = [2,2,2,3,3]
Output: -1
Explanation: There are no lucky numbers in the array.
```

### Constraints:

- `1 <= arr.length <= 500`
- `1 <= arr[i] <= 500`

## Solution

### Brute Force

In brute force approach, you would iterate through each element of the array `arr` and verify the frequency of this number in the `arr`. If it's same, modify the `largestLuckyNumber` variable with the biggest value seen so far.

```java
class Solution {
    public int findLucky (int[] arr) {
        int largestLuckyNumber = -1;
        for (int i = 0; i < arr.length; i++) {
            int count = 0;
            for (int j = 0; j < arr.length; j++) {
                if (arr[i] == arr[j])
                    count++;
            }
            if (count == arr[i]){
                largestLuckyNumber = Math.max(largestLuckyNumber, arr[i]);
            }
        }
        return largestLuckyNumber;
    }
}
```

- Time Complexity: `O(n^2)`
- Space Complexity: `O(1)`

### Using Sorting

Another approach to solve this problem would to to sort the array in ascending order. This way we will have the largest number towards the right end of the `arr`. So, we can start iterating from the right and at each iteration, we make sure if it's same value as the next value and increment the `currentCount` to keep track of how many times current value is occurring. When the values don't match, that means we have found the occurrences of this value. At this point, we check if the `currentCount` is same as the value we were tracking. If yes, simply return because this will be the largest value in the `arr` else continue with the next value on the left.

```java
class Solution {
    public int findLucky (int[] arr) {
        Arrays.sort(arr);
        int currentCount = 0;
        for (int i = arr.length - 1; i >= 0; i--) {
            currentCount++;
            if (i == 0 || arr[i] != arr[i - 1]) {
                if (currentCount == arr[i])
                    return currentCount;
                currentCount = 0;
            }
        }
        return -1;
    }
}
```

- Time Complexity: `O(n log n)` because of sorting operation
- Space Complexity: `O(1)` to `O(n)` depending on the sorting algorithm used which may require additional space to sort elements.

### Using Array

We could also use array to track the frequency of each element. This way we have to make first pass to insert the frequency into new array `counts`. Again we have to create array of size upto maximum possible value in `arr` input array which is 500 and we need one additional element. Now, the problem has a constraint that the number will be greater than or equal to 1. This means we have to ignore index position 0 otherwise, we may always end up returning `0` as the result if no lucky number found. Because `0` can never occur, it will always have frequency of `0` which is same as definition of lucky number in our problem. This solution requires space for storing frequency of each of 500 elements which may be a waste if we have only few elements in `arr` because we might end up having most of the values of `counts` array as zero.

```java
class Solution {
    public int findLucky (int[] arr) {
        int[] counts = new int[501];

        for (int i = 0; i < arr.length; i++) {
            counts[arr[i]]++;
        }

        for (int i = counts.length - 1; i >= 1; i--) { // count[0] is always 0, so ignore that
            if (counts[i] == i)
                return i;
        }
        return -1;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)` because we will have to store `n + 1` values in `counts` array.

### Using HashMap

We could also use `HashMap` to track frequency of each number in input array `arr`. Again, we have to make two pass. First to insert the frequency into `frequencyMap` and next iteration to find the largest lucky number from the `frequencyMap`.

```java
class Solution {
    public int findLucky (int[] arr) {
        Map<Integer, Integer> frequency = new HashMap<>();
        int largestLuckyNumber = -1;
        for (int num : arr) {
            frequency.put(num, frequency.getOrDefault(num, 0) + 1);
        }
        for (Map.Entry<Integer, Integer> entry: frequency.entrySet()) {
            if (entry.getKey() == entry.getValue()) {
                largestLuckyNumber = Math.max(largestLuckyNumber, entry.getKey());
            }
        }
        return largestLuckyNumber;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)` in worst case we may have up to `n` unique numbers.