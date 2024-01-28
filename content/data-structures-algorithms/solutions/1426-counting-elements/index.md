---
title: "1426 Counting Elements"
date: 2023-12-03T16:38:19-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given an integer array `arr`, count how many elements `x` there are, such that `x + 1` is also in `arr`. If there are duplicates in `arr`, count them separately.

 
### Example 1:

```
Input: arr = [1,2,3]
Output: 2
Explanation: 1 and 2 are counted cause 2 and 3 are in arr.
```

### Example 2:

```
Input: arr = [1,1,3,3,5,5,7,7]
Output: 0
Explanation: No numbers are counted, cause there is no 2, 4, 6, or 8 in arr.
```

### Constraints:

- `1 <= arr.length <= 1000`
- `0 <= arr[i] <= 1000`

## Solution

This problem can be solved in multiple ways. The easiest intuition is to use sorting followed by checking each elements one after another.

### 1. Using Sorting

In this approach, we first sort the array in ascending order. Next, we iterate through all elements one by one with two pointers, checking if the next number is just one greater than previous number. If not, increase index position one step. In this case, we use `count += right - left`. This is because if we have numbers such as `[1, 1, 2]`, then we have to count `count = 2` for each `1`. If we were not given condition to count them separately, we could simply use `count += 1`.

```java
class Solution {
    public int countElements(int[] arr) {
        Arrays.sort(arr);
        int count = 0;
        int left = 0;
        int right = 1;
        while (right < arr.length) {
            // If both equal then increase right
            if (arr[left] == arr[right]) {
                right++;
            } else if (arr[left] + 1 == arr[right]) {
                count += right - left; // This is to cover cases like [1 1 2] where we need to count 1 twice
                left = right;
                right++;
            } else {
                left = right;
                right++;
            }
        }
        return count;
    }
}
```

- Time Complexity: `O(n log n)`
- Space Complexity: This depends on the sorting algorithm used, it can be `O(1)` to `O(n)`.

### 2. Using Array

In this problem, we know that each of the number is between `0` and `1000`. So, we can create an array of size `1001` to accommodate all elements of the array based on their index position. This will require creating new array of fixed size. Next, we iterate through each element of the original array `arr` and check if there is an element at position `num + 1` in the newly created array. If it has a value other than default value, that means `x + 1` is available for current number `x` and we increment the `count`. At the end, we return this count.

```java
class Solution {
    public int countElements (int[] arr) {
        int count = 0;
        int[] result = new int[1001];
        for (int i = 0; i < arr.length; i++) {
            result[arr[i]] = 1;
        }

        for (int i = 0; i < arr.length; i++) {
            if (result[arr[i] + 1] == 1)
                count++;
        }
        return count;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: Realistically looking, we creating array of size `1001` which is fixed. so, it has space complexity of `O(1)`.

### 3. Using Hashing

Third approach is to store all elements in a `HashSet` or `HashMap`. Next, iterate through each element `x` of the input array `arr` and check if the `x + 1` exists in `HashMap` or `HashSet`. If it exists, increment the count else move to next element in the array.

```java
class Solution {
    public int countElements(int[] arr) {
        int count = 0;
        Set<Integer> set = new HashSet<>();
        for (int num: arr) {
            set.add(num);
        }

        for (int num: arr) {
            if (set.contains(num + 1))
                count++;
        }
        return count;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`