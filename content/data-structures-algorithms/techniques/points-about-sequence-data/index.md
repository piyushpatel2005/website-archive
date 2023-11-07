---
title: "Important considerations for Array and String types"
date: 2023-11-03T15:52:03-04:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
ideas: ["Iteration"]
---

In programming, iterations are very common. Whenever we want to loop through a sequence type of data structure, we will use iterations. In this tutorial, we will look at iterating array elements and some minute details with String data type.
<!--more-->

## Basic Idea

When we want to check something for each value of the array or list, we will have to iterate through all elements unless it is sorted in which case, we may be able to use binary search kind of technique. In general, iteration would look like this.

```java
int[] nums = new int[] {1, 2, 3, 4, 5};
for (int i = 0; i < nums.length; i++) {
    System.out.println(nums[i]);
}
```

This is straight forward. In each iteration, we are keeping track of index position. When we want to get value at a index, we use indexing operation.
Now, iteration can be sped up a little bit if we use two, three digit jumps. Even though this does not improve the amortized time complexity, it does run slightly faster.

```java
int[] nums = new int[] {1, 2, 3, 4, 5};
for (int i = 0; i < nums.length; i += 2) {
    System.out.println(nums[i]);
}
```

Another option is to iterate using two pointers. For example, one pointer would start at the left side and another from the right until they cross each other. In this case, effectively we are processing two elements in single iteration. This technique can be useful if we want to reverse a string or want to find anagrams, etc.

### String Creation

Strings are so popular and so easy to use that we do not realize what happens under the hood.

### Strings are Interned

Something to keep in mind is that Strings are interned. That means new string creation is avoided until it's actually needed. For example, if we define two strings with the same value, it will actually create only single string and point both variables to the same location in memory where the value is stored.

```java
String s1 = "hello";
String s2 = "hello";
```

### Strings are Immutable
In most languages, Strings are immutable. That means concatenating single character to existing string will create a new string. This is similar to array copy operation. If we have very long text of millions of characters and you want to add just a single character at the end, all characters will have to copied to another location in memory with that additional character at the end.

If the problem is about returning a string which we build one by one, it's usually good idea to store those characters in a list or array and at the end only build the string using one of the available operations.

For example, in Java, we can build the string at the end using `StringBuilder` class. We can keep appending new element using `append(character)` method and at the end materialize it into string using `toString()`. In Python, we can do something similar using `join(list)` method.

```python
def create_string(s):
    lst = []
    for character in s:
        lst.append(character)
    return ", ".join(lst)
```

```java
public static String createString(String str) {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < str.length(); i++) {
        sb.append(str.charAt(i))
    }
    return sb.toString();
}
```