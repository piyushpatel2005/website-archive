---
title: "Two Pointers"
date: 2023-10-16T04:05:16-04:00
draft: true
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

Two pointers is one of the very common techniques used to solve array, string problems. This can be useful especially when the elements are sorted in some order. This article explains the approach of two pointers to solve some of the common problems.
<!--more-->

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

## Palindrome

Given a string `s`, determine whether the string `s` is palindrome or not.

### Example 1:

**Input:** `s = ababa`
**Output:**: `true`
**Explanation:** When we reverse the input string the output is still the same as input (`ababa`). So, this is palindrome string. If after reversing a string output is not the same as input, then it is not a palindrome string.

One approach to solving this is to use two pointers. One starting at the front and another at the end. As long as both match, we can move to next iteration. When they do not match, we return `false` at that specific iteration.