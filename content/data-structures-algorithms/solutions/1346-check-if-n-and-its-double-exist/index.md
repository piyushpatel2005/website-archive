---
title: "1346 Check if N and Its Double Exist"
date: 2023-11-05T03:01:06-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Binary Search", "Hashing"]
languages: ["Java"]
---

## Description

Given an array `arr` of integers, check if there exist two indices `i` and `j` such that :

- `i != j`
- `0 <= i, j < arr.length`
- `arr[i] == 2 * arr[j]`

### Example 1:

```
Input: arr = [10,2,5,3]
Output: true
Explanation: For i = 0 and j = 2, arr[i] == 10 == 2 * 5 == 2 * arr[j]
```

### Example 2:

```
Input: arr = [3,1,7,11]
Output: false
Explanation: There is no i and j that satisfy the conditions.
```
 
### Constraints:

- `2 <= arr.length <= 500`
- `-10^3 <= arr[i] <= 10^3`

## Solution

### Using Brute Force Approach
The simplest brute force approach would involve iterating `arr` two times while checking each number, check for its double exists in the nested iteration while making sure that index is not the same one. This approach would give us time complexity of `O(n^2)`. 

```java
class Solution {
    public boolean checkIfExists (int[] arr) {
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr.length; j++) {
                if (arr[i] == 2 * arr[j] && i != j) {
                    return true;
                }
            }
        }
        return false;
    }
}
```

### Using Sorting and Binary Search

Another alternative is to use sorting and searching. If we sort the array into ascending order, for each number in `arr`, we will have to search for a number which is double of current number. We could use binary search once the array is sorted. This binary search will be slightly different than normal binary search because in this one, we will have to make sure that we are not returning `true` when the same index position is found.

```java
class Solution {
    private int binarySearch(int[] arr, int target) {
        int left = 0, right = arr.length - 1;
        int middle;
        while (left <= right) {
            middle = (right + left) / 2;
            if (arr[middle] > target)
                right = middle - 1;
            else if (arr[middle] < target)
                left = middle + 1;
            else
                return middle;
        }
        return -1;
    }

    public boolean checkIfExists (int[] arr) {
        Arrays.sort(arr);
        for (int i = 0; i < arr.length; i++) {
            if (binarySearch(arr, arr[i] * 2) != -1) {
                return true;
            }
        }
        return false;
    }
}
```

Although this solution works in most scenarios because we are checking for a different number (i.e. number `n` and `2 * n` will be different), there is scenario where both are equal. If `n = 0`, then its double is also same, so in this case, this simple binary search will find the same index and return `true` which is incorrect solution.

We can improvise this binary search to always neglect the current index or when checking the results of this binary search, we have to make sure it's not the same index. The `checkIfExists` method gets modified like below.

```java
    public boolean checkIfExist (int[] arr) {
        Arrays.sort(arr);
        for (int i = 0; i < arr.length; i++) {
            int index = binarySearch(arr, arr[i] * 2);
            if (index != -1 && index != i) {
                return true;
            }
        }
        return false;
    }
```

Another alternative is to omit the current index always and in fact, omit all the indices before current index as well because we have already iterated through those indices.

```java
class Solution {
    private int binarySearch(int[] arr, int target, int i) {
        int left = i + 1, right = arr.length - 1;
        while (left <= right) {
            int middle = (right - left) / 2 + left;
            if (arr[middle] > target) {
                right = middle - 1;
            } else if (arr[middle] < target) {
                left = middle + 1;
            } else {
                return middle;
            }
        }
        return -1;
    }

    public boolean checkIfExists(int[] arr) {

        Arrays.sort(arr);
        for (int i = 0; i < arr.length; i++) {
            if (binarySearch(arr, arr[i] * 2, i) != -1) {
                return true;
            }
        }
        return false;
    }
}
```

- Time Complexity: `O(n log n)`
- Space Complexity: `O(1)`

### Using Hashing

Third option is to use hashing approach. In this case we are always looking for a number in relation to existing number, so we can store currently seen numbers into `HashSet` or `HashMap` and while passing through each element of the array, we check if it's half or double exists in the `HashSet`. To find the half, we have to make sure current number is even before finding its half.

```java
class Solution {
    public boolean checkIfExist(int[] arr) {
        Set<Integer> set = new java.util.HashSet<>();
        for (int i = 0; i < arr.length; i++) {
            if (set.contains(arr[i] * 2) || (arr[i] % 2 == 0 && set.contains(arr[i] / 2))) {
                return true;
            }
            set.add(arr[i]);
        }
        return false;
    }
}
```