---
title: "1089 Duplicate Zeros"
date: 2023-11-03T16:28:52-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Array"]
languages: ["Java"]
---

## Description

Given a fixed-length integer array `arr`, duplicate each occurrence of zero, shifting the remaining elements to the right.

Note that elements beyond the length of the original array are not written. Do the above modifications to the input array in place and do not return anything.

### Example 1:

```
Input: arr = [1,0,2,3,0,4,5,0]
Output: [1,0,0,2,3,0,0,4]
Explanation: After calling your function, the input array is modified to: [1,0,0,2,3,0,0,4]
```

### Example 2:

```
Input: arr = [1,2,3]
Output: [1,2,3]
Explanation: After calling your function, the input array is modified to: [1,2,3]
```

### Constraints:

- `1 <= arr.length <= 10^4`
- `0 <= arr[i] <= 9`

## Solution

This problem has important constraint that we need to modify the original array without returning new array.

### Without In-Place modifications

If the problem was not asking us to modify the array in place, then we could create a new array and then use that array to populate existing array or even return that array. The solution for this approach would look like this.

```pseudocode
create new array result = new int[nums.length]
int j = 0;
for i = 0; j < nums.length; i++ // j is likely to reach before or at the same time as i, so check condition on j
    result[j++] = nums[i]
    if nums[i] == 0
        result[j++] = 0;
return result
```

```java
class Solution {
    public int[] duplicateZerosExtraArray(int[] arr) {
        int[] result = new int[arr.length];
        int j = 0;
        for (int i = 0; j < arr.length; i++) {
            result[j++] = arr[i];
            if (arr[i] == 0) {
                result[j++] = 0;
            }
        }
        return result;
    }
}
```

### With In-Place modifications

In this case, we will have to know upfront how many elements will be duplicated such that we can start by ignoring those elements when we start modifying array from the end. To find the number of elements that will be duplicated, we have to iterate through all elements and if we find `0`, that means that element will be duplicated. We keep track of these elements in `duplicateCounts`. If the last element is `0`, it will not be duplicated. Also, we don't touch this element at all, so we reduce `length`. Also, to ensure this we have to loop until `i <= length - duplicateCounts`

```java
        int duplicateCounts = 0;
        int length = arr.length - 1;
        for (int i = 0; i <= length - duplicateCounts; i++) {
            if (arr[i] == 0) {
                if (i == length - duplicateCounts) {
                    arr[length] = 0;
                    length--;
                    break;
                }
                duplicateCounts++;
            }
        }
```

Next, we have to make second pass through elements from the end. This time, we start directly from the last element because we know how many elements will be pushed out based on `duplicateCounts`. If the element at a given index is `0`, we insert two `0`s instead of one otherwise insert the element which is present.

```java
        for (int i = length - duplicateCounts; i >= 0; i--) {
            if (arr[i] == 0) {
                arr[i + duplicateCounts] = 0;
                duplicateCounts--;
                arr[i + duplicateCounts] = 0;
            } else {
                arr[i + duplicateCounts] = arr[i];
            }
        }
```

The full code looks like this.


```java
class Solution {
    public void duplicateZeros(int[] arr) {
        int duplicateCounts = 0;
        int length = arr.length - 1;
        for (int i = 0; i <= length - duplicateCounts; i++) {
            if (arr[i] == 0) {
                if (i == length - duplicateCounts) {
                    arr[length] = 0;
                    length--;
                    break;
                }
                duplicateCounts++;
            }
        }
        for (int i = length - duplicateCounts; i >= 0; i--) {
            if (arr[i] == 0) {
                arr[i + duplicateCounts] = 0;
                duplicateCounts--;
                arr[i + duplicateCounts] = 0;
            } else {
                arr[i + duplicateCounts] = arr[i];
            }
        }
    }
}
```