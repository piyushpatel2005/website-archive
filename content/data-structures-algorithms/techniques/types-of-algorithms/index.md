---
title: "Types of Algorithms"
date: 2023-10-08T23:38:50-04:00
draft: true
---

There are various techniques to solve a given algorithmic problem. Some of these techniques we use everyday in our day to day lives without knowing them. In this tutorial, I will briefly explain some of those techniques.

<!--more-->

## Divide and Conquer Algorithms

One large problem can be divided into several smaller problems and can be solved easily. This is one of the widely used technique. One of the very common use of this technieque is in solving sorting algorithms. Merge Sort specifically uses this idea.

Here's how merge sort works:

1. **Divide:** 

- Recursively divide the array into two equal or nearly equal halves until there is only one element or no element left (base case). The following diagram illustrates the division process:
   

{{< mermaid >}}
graph LR
 A([9, 7, 5, 1, 3])
 A --> B([9, 7])
 A --> C([5, 1, 3])
 B --> D([9])
 B --> E([7])
 C --> F([5])
 C --> G([1, 3])
 G --> H([1])
 G--> I([3])
{{</ mermaid >}}
   
2. **Conquer:**

- Sort each half of the divided arrays separately by applying merge sort recursively.
   The following diagram illustrates sorting each half:
  
{{< mermaid >}}
graph LR
 B([9, 7])
 E((7))
 D --> J(*merge*)
 F((5))
 I((3))
 H((1))
{{</ mermaid >}}


{{< mermaid >}}
graph LR
 C((5))
 K(*merge*)
 G((1, 3))
{{</ mermaid >}}



   
3. **Combine:**
   
- Combine both sorted halves by merging them back together to obtain a fully sorted array.

The following diagram illustrates merging the sorted halves:
    

{{< mermaid >}}
graph LR
 B --> N(*merge*)
 C --> M(*merge*)
{{</ mermaid >}}


{{< mermaid >}}
graph LR
 K --> L((1, 3, 5))
 E --> O((7, 9))
{{</ mermaid >}}

{{< mermaid >}}
graph TD
 L --> P([1, 3, 5, 7, 9])
{{</ mermaid >}}


## Recursive Algorithms

Recursive algorithms are algorithms that solve a problem by dividing it into smaller subproblems of the same type, and repeatedly applying the same algorithm to each subproblem until a base case is reached. The solution to the base case is then combined to obtain the final solution.

Let's explain the concept with an example of calculating factorial recursively.

**Factorial:**

The factorial of a non-negative integer n, denoted by n!, is the product of all positive integers less than or equal to n.

For example, 5! = 5 x 4 x 3 x 2 x 1 = 120.

Here's how we can calculate factorial recursively:

1. **Base Case:**

- If n is equal to 0 or 1, return 1 (base case).

The following diagram illustrates the base case:
   
{{< mermaid >}}
graph TD
 A(0)
 B(1)
 C(1)
 A --> C
 B --> C
{{</ mermaid >}}
   
2. **Recursive Step:**

- Otherwise, recursively calculate (n-1)! and then multiply it by n.

The following diagram illustrates the recursive step:
  
{{< mermaid >}}
graph TD
 D((5))
 E[[factorial]]
 F((4))
 G((fact))
 C(1)
{{</ mermaid >}}

{{< mermaid >}}
graph TD
 L((4))
 M[[factorial]]
 N((3))
{{</ mermaid >}}

{{< mermaid >}}
graph TD
 O((3))
 P[[factorial]]
 Q{{result}}
{{</ mermaid >}}

   
3. **Combine:**
   
- Multiply n with (n-1)!, which gives us the final result.

The following diagram illustrates combining the results:
    
{{< mermaid >}}
graph TB
K[return 3 x 2]-->H{{result}}
{{</ mermaid >}}

## Dynamic Programming

Algorithms like recursion break the problem into smaller subproblems and then use the solution of the smaller subproblems to construct the solution of the larger one. The issue with this is that the sometimes the same subproblem is solved multiple times. Dynamic programming sets up computations to avoid recomputing values that are already known resulting in time savings.

## Brute Force

Brute force or exhaustive search algorithm tries every possible option to find the solution to the problem. For example, if we have to search for a object in 8 x 8 square board provided that the object is surrounded by four blocks, we would visit each block until we have found that object. Here, we are ignoring the information provided that the object is surrounded by four blocks around it. This could help eliminate all the rows of the external periphery. Brute force algorithms are usually very slow. In coding interviews, brute force algorithm is not the expected solution from the interviewer.

## Greedy Algorithms

Greedy algorithms are a type of algorithmic approach that follows the problem-solving heuristic of making locally optimal choices at each stage with the hope of finding a global optimum solution. This helps speed up going through possible options. Below problem explains this concept clearly.

Given a set of coins of different denominations and a target amount, we want to find the minimum number of coins needed to make up that amount.

For example, if we have coins with denominations [1, 5, 10] and we want to make change for an amount of 18, the minimum number of coins needed would be 4 (one coin of denomination 10 and two coins of denomination 4).

Here's how we can solve this problem using a greedy algorithm:

1. Sort the set of coins in descending order based on their denominations. This allows us to always choose the largest denomination possible at each step.
2. Initialize a variable `numCoins` to keep track of the total number of coins used so far.
3. Iterate through each coin denomination from largest to smallest:
    - Divide the target amount by the current coin denomination (`amount // coinValue`), giving us the maximum number `maxCoins` for that particular denomination.
    - Add `maxCoins` to `numCoins`.
    - Update the remaining amount by subtracting `(coin * maxCoins)` from it.
4. Finally, the value in `numCoins` represents the minimum number of coins needed to make up the target amount.