---
title: "Hashing"
date: 2023-12-02T00:51:12-05:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
ideas: ["Hashing"]
---

Hashing is one of the popular techniques to store large amount of data. The benefit of hashing is that it is very cheap to retrieve data based on its key. The time complexity for retrieving these elements can be considered as constant.

<!--more-->

## Overview

A hash function basically converts a given input value into a number. This number is of fixed size set by the developer. Another important property is that they are deterministic. So, the same input will always result in the same number regardless of how many times we try to convert them. We don't need to know exactly how the hash function is created. It's implementation is of less relevance for interviews.

We previously saw that arrays were very efficient in retrieving data based on index position. If we wanted to store integers, we could store them in such a way that we can use index position to easily retrieve them in constant time. They can also be modified in constant time which is quite important property. The same way if we had a data structure which could store indices of any type, it would be great. Like if we wanted to store text, we could use string as indices to retrieve string in constant time. This is what Hashing makes possible. Some of the terminologies change when we compare arrays and hashmap. Another important benefit of Hashmap is that we do not need to know the length of the Hashmap in advance. For example, if we wanted to be able to access integers in constant time, we would need to know the largest number or size of the array and accordingly, we can position numbers in the array indices. However, with HashMap, we do not need to know such size. We can add as many key-value pairs as we want but still retrieving elements will be constant time operation.

Similar to arrays, we have new data structure called Hash Map or HashTable or Dictionary or Associative arrays. These are key-value associations. Each key maps to a certain value. They are named differently in different programming languages but the underlying concept is same. The keys can be of any type. Here key is analogous to indices in arrays. The only requirement is that these keys have to be immutable. In this tutorial, I will refer them as HashMap but other languages use different name. It is same as Dictionary in Python or Associative array in PHP or HashTable in C++ or Java.

Hashmap is very important data structure because using this, the algorithm complexity can reduce drastically. There is another variation of this called HashSet which stores only unique keys, however, the underlying idea is still the same. To be honest, HashSet uses HashMap under the hood. Another important property of HashMap is that they are unordered. So, if we retrieve its keys several times, the order is not guaranteed.

## Key Collision

When the hashing function is less efficient, it may end up creating same hash value for two different keys. In that case, we may end up having a collission. If we don't handle this situation, the older value stored at a key will get overwritten with the new value. There are several ways to resolve this collision situation. The easiest one is to use linked list to store values.

Let's see a hypothetical scenario. Let's assume that our hashing function just uses modulo method and has total of 100 buckets to store different values for the keys. Again, Hashmap uses array internally, so we will have an array of 100 slots to store different values. First, let's try inserting value 1 which `1 % 100 = 1` gets the bucket number 1. Next, we install 105, so we get `105 % 100 = 5` bucket number 5. Now, let's say third number is 201, then we get bucket position as 1 (`201 % 100 = 1`). This bucket already had stored the value for 1 during first operation, so if we simply overwrite this value, we will lose previously stored value.

In such situation, if we were using a different collection data structure for each key, we could store both the values. Let's say we use LinkedList for each bucket. Then at the end of third operation, our linked list at bucket position will have two values `[1, 201]` which means we are not losing value by mistake. When we have to search for values stored at a key, we have to traverse through this LinkedList at a give bucket position which is still efficient because remember we have already divided the problem by 1/100th. 

Now, this seems reasonable solution for the problem of collission, but what happens if our hash function is very poor and always generates the same hash value for each of the keys. In such situation, every value will be stored at let's say bucket 1 and in this case, bucket 1 LinkedList will end up having all the values. When we have to search for a value, we will have to traverse through this large linked list and in this case, the time complexity will be `O(n)`.  To avoid this kind of situations, many mathematicians have worked on several hashing algorithms to produce as unique value as possible so that collissions are minimal in the first place.