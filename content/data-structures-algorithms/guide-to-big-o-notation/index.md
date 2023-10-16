---
title: "Guide to Big O Notation"
date: 2023-10-07T18:59:05-04:00
draft: true
---

An algorithm is a sequence of instructions that one should be performed in order to solve a well-defined problem. Once the algorithm is defined, we need to talk about accuracy and efficiency. This tutorial explains how to measure efficiency using different measures.

<!--more-->

## What is Pseudocode?

During this tutorial, we will sometimes use pseudocode. Pseudocode is a simple, informal way of describing how an algorithm works using a combination of natural language and simplified programming constructs. It helps programmers plan and communicate ideas about the logic of their code before actually writing it in a specific programming language. Pseudocode is not meant to be executed by a computer but serves as a blueprint for implementing algorithms.

## What is Big-O Notation?

Big-O notation is a way of expressing the upper bound or worst-case time complexity of an algorithm. It allows programmers to analyze and compare the efficiency of algorithms based on how their running time grows relative to the size of the input.

Big O is used to describe the computational complexity of an algorithm. The computational complexity of an algorithm can be categorized into two main parts. In interviews, usually you may be asked to analyze the algorithm in terms of these two.

1. Time complexity: The amount of time an algorithm takes to run relative to the input size.
2. Space complexity: The amount of memory allocated by the algorithm when run relative to the input size.

## How to define complexities?

The idea for defining complexities is how the algorithm scales when the input size increases. So, the complexities are defined in terms of input element size. That is the function has a parameter of input size. 

\\[f(n)\\quad, where \\; n = size \\:of \\:input \\:data \\:structure\\]

It is possible that the algorithm may perform faster for a input array of 100000 elements when compared to 100 elements.

## TODO:
- [ ] Add idea on how different time complexities
- [ ] how to calculate time complexity, ignore constants and multipliers, etc.
- [ ] show few examples with below time complexity graphs

In Big-O notation, algorithms are classified into different categories depending on how their running time scales with the input size. For example, an algorithm with O(1) complexity means it has constant time, meaning its running time does not depend on the input size. An algorithm with O(n) complexity means its running time is directly proportional to the input size.

Here are some common Big-O notations:

- `O(1)`: Constant time
- `O(log n)`: Logarithmic time
- `O(n)`: Linear time
- `O(n log n)`: Linearithmic time
- `O(n^2)`: Quadratic time
- `O(2^n)`: Exponential time

By using Big-O notation, programmers can assess the efficiency of various algorithms and make informed decisions about which one to use for a particular problem. Algorithms with lower Big-O values generally offer better performance for larger inputs.