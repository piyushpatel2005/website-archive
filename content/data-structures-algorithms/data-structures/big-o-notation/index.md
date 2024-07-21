---
title: "Big O Notation"
date: 2023-11-25T19:04:10-05:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
---

When we talk about data structures and algorithms, it may be useful to know how efficient one data structure is compared to another, but how do we measure the efficiency? Does running fast measure the efficiency? Also what does fast mean because it may behave differently depending on CPU, memory as well as size of the problem.

There are two metrics to measure the performance of an algorithm. One is how long does an algorithm take to return the expected output and another one is how much memory does it need to return the output. The former is called Time Complexity of an algorithm and the later is called the Space Complexity. It's possible to reduce time complexity if we increase the space complexity. When I say increase in space complexity means providing more memory.

One way to analyze the problem is how does it behave for small input dataset. However, this may not be the best option because usually these minor problems work fast and we do not care so much about minor problems. Another extreme is how it behaves when the input size is big. These problems may be rare. However, one middle point is identifying how the algorithm or data structure behaves as the size of the problem grows. This is known as asymptotic analysis. It compares two solutions or functions for very large values of input. There are several ways to measure time complexity.

## What is Big-O Notation?

One of the asymptotic notation is the Big-O notation. There are time complexities like linear, quadratic, exponential or logarithmic. These are called Big-O, which specifies that algorithm is at least as fast as these. These are some of the most common time complexities you'll see in common. Let's understand these complexities in detail.

### Time Complexity:

This is what defines asymptotic runtime. If we think about normal mail delivery system then the time it takes for sender to send a post and receiver receiving a post is called the runtime of mail transfer service. This runtime can be affected by many measures like what route it takes, how efficient each of the individuals are in travelling from one place to another, how fast the sorting system is to sort the mails based on their location, etc.

For example, if we have to calculate sum of numbers from 1 to 100, we can simply iterate through each number and add them to `sum` variable. This will increase linearly as the size of the problem increases. If we take each sum operation as single unit of work, it would take around 100 units of work to sum 100 numbers. If we needed sum of first 1000 numbers, we will need 1000 units of work. This is called linear time complexity, that is the runtime will increase as the input dataset (numbers in this case) increase. However, to find the sum of these numbers we can also use sigma sum which calculates sum of all numbers in a sequence using single operation. In this case, it can be calculated using `sum = n * (n + 1)/2` where `n` can be 100 or 1000. This single equation will result in constant time regardless of the input size whether it's 100 numbers or 1000 numbers, it would take single operation only. This is called constant time complexity, denoted as `O(1)` in computer science.

### Space Complexity:

There is also space complexity which measures how much space or memory required when using a specific algorithm. Again, the space complexity can be measured in Big-O notation. It specifies for each input size of `n` how much memory does an algorithm need. In our analogy of mail transfer service, we can think of this as how many individuals were needed to sort 100 mails or 1000 mails. We could use 1000 staff members to sort 1000 mails and they would get work done in probably constant time. So, space is related to time it takes for an algorithm to run.

For example, while sorting an unsorted array, we could use another array to find the minimum number from the original array and put that number starting from lowest index position. This means we will require as much as space as the input array size. This means as the size of input grows, the space required to find the sorted array will increase linearly. That is it has linear space complexity.

While defining time complexity or space complexity, we always drop constants. For example, if an algorithm requires few additional steps to find sum of numbers, we ignore those from the time complexity. For example, below algorithm requires time to set up `sum = 0`. If you consider declaring a variable taking constant time `c` then in this case, our algorithm takes `c + n` time (i.e. time complexity of `O(c + n)`) where `n` is the size of the `input` array. However, we ignore the constant like `c` and the asymptotic time complexity will be `O(n)`.

```python
def findSum(input):
    sum = 0
    for num in input:
        sum += num
    return sum

input = [1, 2, 6, 3, 8]
sum = findSum(input)
print(sum)
```

### Linear Time Complexity (`O(n)`)

Linear time complexity is when you've single iteration through the input dataset. This means as the size of the problem increases, it increases the runtime by the size of the input dataset. Modern computers are so fast that it's difficult to see the difference between runtimes of two datasets if they are too small. So, in this case, I am iterating through numbers from ! million until 1 billion and in each iteration multiplying the input by 5. So, if it's linear time algorithm, the runtime should also increase by approximately 5 times. This algorithm uses `volatile` static variable so that two threads cannot modify its value. Java Runtime can perform some optimizations if this is not used and you may not see the runtime increase with larger input size.

```java
public class TimeComplexityExample {
    volatile static long dataValue;

    public static void main(String[] args) {
        for (long i = 1_000_000; i < 1_000_000_000; i *= 5) {
            linearAlgo(i);
        }
    }

    public static void linearAlgo(long n) {
        long startTime = System.currentTimeMillis();
        for (long i = 0; i < n; i++) {
            dataValue += i;
        }
        long endTime = System.currentTimeMillis();
        System.out.println("Input: " + n + ", Time taken: " + (endTime - startTime));
    }
}
```

### Quadratic Time Complexity (`O(n^2)`)

When the input size increase results in quadratic increase in the runtime, it's called quadratic time complexity. It's usually the case when we are iterating through the input dataset twice in the algorithm.

```java
public class TimeComplexityExample {
    volatile static long dataValue;

    public static void main(String[] args) {
        for (long i = 1000; i < 80000; i *= 5) {
            quadraticAlgo(i);
        }
    }

    public static void quadraticAlgo(long n) {
        long startTime = System.currentTimeMillis();
        for (long i = 0; i < n; i++) {
            for (long j = 0; j < n; j++) {
                dataValue += j;
            }
        }
        long endTime = System.currentTimeMillis();
        System.out.println("Input: " + n + ", Time taken: " + (endTime - startTime));
    }
}
```

### Logarithmic Time Complexity (`O(log n)`)

The solution to an algorithm is said to have logarithmic time complexity when the input size reduces by half in each iteration. The most common algorithm with logarithmic time complexity is binary search where we omit half of the input dataset each time we compare the middle value. This results in faster solution to a problem. It's better than linear time complexity.

Simple case for this kind of algorithm might be if we were iterating over values and every time problem was reducing by some multiplier `k`, then time complexity would be `O(log n)` with base `k`.

```java
        dataValue = 1;
        while (dataValue < n) {
            dataValue *= 2;
        }
```

In above problem, there is one `while` loop which reduces in size by `2` because we are multiplying `dataValue` by 2 in each iteration.


### Exponential Time Complexity (`O(a^n)`)

In this case, as the input size increases the runtime increases exponential and is one of the worst time complexities to have for any algorithm.

### Constant Time Complexity (`O(1)`)

Constant time complexity is when input size does not affect the runtime duration of the algorith. It's very hard to achieve such time complexity in practice. However, some problems which use Hashing may provide this kind of time complexity. Searching an item through a HashMap is considered a constant time operation because of the way the data is stored.

There are several other time complexities such as best sorting algorithm can have `O(n log n)` time complexity which is little worse than linear time complexity `O(n)`.