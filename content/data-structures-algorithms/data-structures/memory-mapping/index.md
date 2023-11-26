---
title: "Memory Mapping"
date: 2023-11-25T19:04:09-05:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
---

This tutorial is providing brief overview of how variables are created in computer memory and how those values are stored in the memory space.

<!--more-->

The computers these days are extremely fast and even though efficient and non-efficient algorithm might produce output in almost similar amount of time to bare eyes. They do differ in their speed. This may not be noticeable for small dataset, but if the input size increases by thousands, it will clearly be visible which algorithm is performing faster.

RAM in computer memory is limited in size, usual size being 8GB, 16GB. Accessing memory from any location is fast and is considered as a constant time operation and is to considered in the calculations of time analysis. Let's see what happens when we initialize a variable.

We can visualize memory as a 2D array of boxes. These boxes are empty at the beginning. In reality, they will contain some garbage value which is of no use.