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

Big-O notation is a way of expressing the upper bound or worst-case time complexity of an algorithm. It allows programmers and researchers to analyze and compare the efficiency of algorithms based on how their running time grows relative to the size of the input.

In Big-O notation, algorithms are classified into different categories depending on how their running time scales with the input size. For example, an algorithm with O(1) complexity means it has constant time, meaning its running time does not depend on the input size. An algorithm with O(n) complexity means its running time is directly proportional to the input size.

Here are some common Big-O notations:

- `O(1)`: Constant time
- `O(log n)`: Logarithmic time
- `O(n)`: Linear time
- `O(n log n)`: Linearithmic time
- `O(n^2)`: Quadratic time
- `O(2^n)`: Exponential time

By using Big-O notation, programmers can assess the efficiency of various algorithms and make informed decisions about which one to use for a particular problem. Algorithms with lower Big-O values generally offer better performance for larger inputs.