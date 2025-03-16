---
title: "Binary Search"
date: 2024-10-01T01:16:44-04:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
ideas: ["Binary Search"]
---

Binary Search uses natural search ideas into problems where we can divide the search space into two parts and then decide which part to search further. This is a very powerful technique which can be used in many problems.

<!--more-->

Binary search at worse can have time complexity of O(log n) which is very efficient. It is used in many problems where we have to search for a value in a sorted array. It is also used in many problems where we have to find a value which satisfies some condition. For example, finding the smallest value which satisfies some condition.

Let's first understand how Binary search works.

## How Binary Search Works

Binary search is normally used in sorted arrays. It is a divide and conquer algorithm. It works by dividing the search space into two parts and then deciding which part to search further. For example, if you have ever worked with traditional dictionary or traditional phonebook, you might have seen that you open the book from the middle and then see which names or word come up there and based on those you decide whether to search to the left or right and get closer to the word you're searching for. This is exactly how binary search works.

Here is the pseudo code for finding the index of `target` value in the sorted array `array`.

```pseudocode
left = 0
right = array.length - 1
while left <= right
    mid = left + (right - left) / 2
    if array[mid] == target
        return mid
    else if array[mid] < target
        left = mid + 1
    else
        right = mid - 1
return -1
```

First we start with `left` and `right` pointers which start off at `0` and last index of the array. Next, you iterate through array as long as the iteration doesn't cross over, that is `left <= right`. In each iteration, you calculate the middle index `mid` of the array. If the value at `mid` is equal to `target`, we return `mid` as the index position. If the value at `mid` is less than `target`, we know that the `target` cannot be in the `left` half of the `array` because `array` is sorted. Due to this, we move the `left` pointer to `mid + 1`. If the value at `mid` is greater than `target`, we move the `right` pointer to `mid - 1`. We repeat this operation until we have found the `target` or we have exhausted the search space.

### Time Complexity

Binary search is diving the search space into half in each iteration. This means that the time complexity of binary search is `O(log n)`. This is very fast compared to even linear search which has time complexity of `O(n)`.

## Problems

- [Binary Search](../../solutions/0704-binary-search/)

If the array is sorted row-wise and column-wise, then you can use binary search to search for a value in the array. Here is an example problem which uses binary search to search for a value in a 2D matrix.

- [Search a 2D Matrix](../../solutions/0074-search-a-2d-matrix/)
