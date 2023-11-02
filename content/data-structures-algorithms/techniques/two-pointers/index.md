---
title: "Two Pointers"
date: 2023-10-16T04:05:16-04:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
ideas: ["Two Pointers"]
---

Two pointers is one of the very common techniques used to solve array, string problems. This technique is used when we have an element in array or list which we may want to compare with another element of the array. This article explains the approach of two pointers to solve some of the common problems.
<!--more-->

## What is Pointer?

In computer science, pointer is a reference to a memory address. In the system, we have a stack or heap of memory. The memory we can think of like a laid out blocks which can store specific amount of information. Each block as an associated address which is used to find the values stored in that memory address space. Pointers are used by many data structures. The most common one is arrays which is how we get faster scan time for array data structures.

## Basic Idea

Two pointers can be used in multiple ways. The common syntax is like start the iteration at the beginning and end of the array and navigate towards each other.

1. Start one pointer at the beginning and another one at the end of the array.
2. Use a loop until the pointers are equal to each other or cross each other. This usually happens in the middle.
3. At each iteration, increase the position of the left pointer and decrease the position of the right pointer. This way they are bound to cross each other at some point. This way both pointers move towards each other.

The pseudocode for this looks like below.

```markdown
Initialize left=0
Initialize right = array.length - 1

while left less than right
    perform some actions
    and/or return the result
    left = left + 1
    right = right - 1
```

This idea can be used in many algorithms. With this technique, we never have to run through an element twice. This can help eliminate additional iteration in nested loops and can give time complexity of `O(n)` which may be the best possible complexity for the problem at hand.

This very same idea can be used to solve at least below problems.

## Reverse a string or array

Given an array of characters `s`, reverse the array.

```markdown
Initialize one pointer left = 0
initialize another pointer right = s.length - 1
while left less than right
    swap character at s[left] and s[right]
    increment left
    decrement right
```

## Palindrome

Given a string `s`, determine whether the string `s` is palindrome or not.

### Example 1:

**Input:** `s = ababa`

**Output:**: `true`

**Explanation:** When we reverse the input string the output is still the same as input (`ababa`). So, this is palindrome string. If after reversing a string output is not the same as input, then it is not a palindrome string.

One approach to solving this is to use two pointers. One starting at the front and another at the end. As long as both match, we can move to next iteration. When they do not match, we return `false` at that specific iteration.

## Two Sum Problem

Given a sorted array of unique integers and a target integer, return true if there exists a pair of numbers that sum to target, false otherwise.

### Example:

**Input:** `nums = [1, 2, 4, 6, 8, 9, 14, 15]` and `target = 13`

**Output:**: `true`

**Explanation:** In this case, the sum of any two elements of `nums` array, integers 4 and 9, results in the target value 13. So, we return `true`. If there is any pair of two numbers which can result in `target` value, we return `true` else `false`.

The important point with this problem is that the input array is sorted. So, we can basically manipulate the index variable to move towards the `target` sum.

```markdown
Initialize one pointer left = 0
Initialize another pointer right = nums.length - 1
while left less than right
    Check if nums[left] + nums[right] greater than target
        right = right + 1
    Else if nums[left] + nums[right] less than target
        left = left + 1
    Else 
        return true
If we didn't find a pair, return false
```

## Merge two Arrays and create new sorted array

This approach of two pointers is not limited to single array. It can be applied to multiple arrays.

Given two sorted arrays `arr1` and `arr2`, create a new sorted array which contains elements from both arrays.

In this problem, we can have two pointers, one pointing to the beginning of `arr1` and another pointing to `arr2`. We can check which one of those is smaller and add that element into our new resulting array `result` and increment the pointer by 1.

```markdown
Create new result array with size = size of array1 + size of array2
Initialize three index variables for array1, array2 and result array, i, j, k
while i less than array1.length and j less than array2.length
    if array1[i] less than array2[j]
        result[k] = array1[i]
        i++
        k++
    else
        result[k] = array2[j]
        j++
        k++
We may finish one array before another so add the remaining elements as it is
while i less than array1.length
    result[k] = array1[i]
    i++
    k++
while j less than array2.length
    result[k] = array2[j]
    k++
    j++
return result
```