---
title: "Sliding Window"
date: 2023-10-18T19:16:33-04:00
draft: true
categories: ["Coding Interview"]
topics: ["Programming"]
ideas: ["Sliding Window"]
---

Sliding window is a common technique used to solve problems related to arrays. This is similar to two pointers and builds on top of two pointers approach.

Usually these problems involve finding subarray from the original array. The subarray of the array is part of the array which is defined by the start and end indices from the original array. 

## What is Sliding window

Sliding window is a problem solving technique for arrays, list, string etc. In this case, we move one or more index positions in every iteration. The important thing to note here is that we can move one or even more than one index position in every iteration. 

When we know that this is a problem of finding subarray, we need to know if we can utilize sliding window. In this case, we are looking for two consecutive numbers, hence this can be solved using sliding window. Other common problems which can be solved using sliding window are below.

- Find the longest subarray that has maximum number of consecutive `k`.
- Find the number of subarrays of 3 elements whose product is less than 10 in a given array `num`.

## Sliding Window idea

Sliding window can be used in two ways. 

### Fixed Window size

### Examples
One of the problem may be something like this. Given an array of numbers, find two consecutive elements from the array whose sum will be 10. In this case, we are asked to find the two consecutive elements, which will make up for the subarray from the original array. For example, if we have an array `[1,2,3,4]` and the problem asks us to find the two consecutive numbers whose sum would be 7, then we will get the output as `[3,4]` which is again part of the original array. This is an example of **fixed windows**. In this case, we first make a fixed window of given size `k`. In this example, the `k=2`. In each iteration, we move `left` and `right` pointers forward at the same time, thus keeping the window size the same.

### Variable Window size

In this case, the window size can vary. These are examples like find maximum subarray from an array. We start with two pointers `left = right = 0`. In each iteration, we increment `left` and `right` by 1. This way we will always point to two consecutive numbers until we reach the end of the array.

Another common pattern is to find longest subarray. In this case, again we start with `left = right = 0`. However, we want to see the largest subarray, so, we increment only `right` pointer. Now, when we find the subarray is invalid (Invalid subarray is something that doesn't satisfy our condition in the problem, i.e. for example, subarray has sub more than 10), then we increment the `left` pointer. This way we are moving forward in the array in each iteration until we reach the end of the array. In this case, it can be said that every time we increment `right` pointer, we are increasing the size of the window, that is we are adding more elements into the window. On the other hand, when we increment `left` pointer, we are decreasing the size of the window because in this case the number of elements in the array decreases.

## TODO:

- Add example and explain how to use sliding window

If the problem asks to the find the number of possible subarrays which are valid (satisfying some condition), then those can be found using a mathematical trick. At every valid subarray, the possible number of subarrays with index `left` and `right` are `(right - left) + 1`. So, whenever we find a valid subarray, we have to add this number of `count` variable that we can keep track in our iteration. At the end, when the loop ends, we will have the count of all possible valid subarrays.  