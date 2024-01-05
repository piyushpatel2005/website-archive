---
title: "Arrays"
date: 2023-11-25T19:04:30-05:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
---

This tutorial explains about one of the most commonly used data structures for storing collection of items, arrays. Arrays are continuous blocks of memory where we can store item of same types.

<!--more-->

Previously we saw how memory can be visualized as empty boxes where we can put new values. The special thing about arrays is that it can store multiple items. Of course, the more items we store, more memory we need but these memory addresses are continuous. That is they are one after another. There are certain advantages and disadvantages with this kind of layout which we will talk about in this tutorial.

An array is a data structure that allows you to store multiple elements of the same type under a single variable name. Arrays can be of two types: static array and dynamic array.

## Static Arrays

In Java, A static array has a fixed size determined at compile time. This means that once the size of a static array is defined, it cannot be changed during runtime.

Declaration and Initialization of Static Arrays in Java



Accessing Elements in a Static Array

Elements within a static array are accessed using their index. Indexing in arrays starts from 0. For example, to access the first element in our 'numbers' array:

```java
int firstElement = numbers[0];
```

Static arrays are fixed in size. Once we define them, they have fixed size and they cannot grow or sink at runtime. Some programming languages like Javascript, Python does not have static arrays because they by default offer dynamic arrays. When we define an array, it allocates memory according to the size of the array we define. These memory locations are contiguous in RAM. By default, these memory locations will be filled with junk values in some programming languages like C. Other programming languages like Java, Python, etc initialize these values with default value of the data type. That is zero for integer, `null` for reference type arrays. Each of these elements have indices associated with them. Those are just convenient way to access each element of the array easily. Computer doesn't need to store those indices when we create an array. They just need to know the size and the data type.

To declare and initialize a static array in Java, you can use the following syntax:

```java
dataType[] arrayName = new dataType[size];
```

In below example, I have initialized an array of `int` type with size 5.

```java
int[] numbers = new int[5];
```

We can retrieve the elements of the array using their index position. These elements are zero-indexed. That is the first element is stored at index position 0 and not 1. For example, to retrieve first element, I can use index position 0

```java
int firstElement = numbers[0];
```

Now, because these elements are stored contiguous and we have fixed size, we can easily find element at a given index. For example, if we declare `int` array of size 4, we have four continuous blocks of memory allocated in RAM. In below diagram, I have represented memory addresses as decimal numbers for illustration. If we know that `int` takes up 4 bytes, we have allocated total of `4 x 4 = 16 bytes`. If the first element address is 1000, the next element will be at `1000 + 4 = 1004` memory address. This is because the memory is allocated in contiguous blocks. Similarly, the element at index position 3 will be at `1000 + (3 x 4 bytes) = 1012`. Let's run through another example, Let's suppose we created an array of size 10 for data type `double`. Each `double` element would require a memory of 4 bytes. So, here we have allocated total of `10 * 8 = 80 bytes`. Let's suppose first element is stored at address 2000. If we want to find the element at index position 5, that would be at address `2000 + 5 * 8 = 2040`. In general, this calculations can be simplified to `firstElementAddress + (indexPosition * DATATYPE_BYTES)`.

One more thing to keep in mind, when we allocate an array, depending on the data type of the array, they might be stored in stack or heap memory. If the data type is primitive in Java, the array will be stored in stack memory but if the array type is of some reference data type, it will be stored in Heap memory space.

## TODO: Diagram for memory representation for int array and memory address calculations for each indices.

So, in order to access an element from a static array, all we need is address of first element. This is usually store in array reference when we declare the array and the size of the array. With these two information, accessing any element from the array will take constant time because accessing RAM memory is constant time operation. If we try to access an element which is at index other than `0` to `size - 1`, we will get an `IndexOutOfBoundsException`. So, we always have to be careful of which index we are trying to retrieve. Similarly, when we want to modify a value at a given index, we can perform that also in constant time. We just have to swap the value stored at a specific memory address with a new value.We cannot delete an element entirely if we want to. We can only replace its values.

Let's see what happens if we want to add a new value at the end of the array. If we have space available, we can easily insert a new value. However, if we don't have a space, we will need to add a new space and attach it to this array. Now, because these memory are allocated in continuous manner in RAM, we may not have next available memory spot. It is possible that next available memory is allocated to some other variable in our program. Again, we do need continuous memory allocation in order to easily access each index position values in constant time, but now we have hit the limits that we cannot expand this array further. This is where dynamic arrays come in.

## Dynamic Arrays

Dynamic arrays are dynamic in size. 

Dynamic arrays are resizable arrays that allow for the insertion, deletion, and modification of elements. Unlike static arrays, dynamic arrays can change in size at runtime to accommodate the required number of elements. This makes them a valuable tool for handling collections of data in programs.

In this article, we'll explore how dynamic arrays are used in Java, Python, and JavaScript to provide a comprehensive understanding across multiple programming languages.

## Java

In Java, the `ArrayList` class provides a dynamic array implementation. Here's an example of how to use `ArrayList`:

```java
import java.util.ArrayList;

public class DynamicArrayExample {
    public static void main(String[] args) {
        // Creating an ArrayList
        ArrayList<String> dynamicArray = new ArrayList<>();

        // Adding elements to the ArrayList
        dynamicArray.add("Java");
        dynamicArray.add("Python");
        dynamicArray.add("JavaScript");

        // Accessing elements from the ArrayList
        System.out.println(dynamicArray.get(1));  // Output: Python
    }
}
```

The `ArrayList` class simplifies array manipulation by providing methods for adding, removing, and accessing elements dynamically.

## Python

In Python, lists serve as dynamic arrays by allowing flexible operations on collections of data. Here's an example of a dynamic array in Python:

```python
# Creating a list (dynamic array)
dynamic_array = []

# Adding elements to the list
dynamic_array.append("Java")
dynamic_array.append("Python")
dynamic_array.append("JavaScript")

# Accessing elements from the list
print(dynamic_array[1])  # Output: Python
```

Python lists automatically resize as needed to accommodate new elements efficiently.

## JavaScript

JavaScript provides flexibility with arrays that can dynamically grow or shrink as elements are added or removed. Here's how it works:

```javascript
// Creating an array (dynamic array)
let dynamicArray = [];

// Adding elements to the array
dynamicArray.push("Java");
dynamicArray.push("Python");
dynamicArray.push("JavaScript");

// Accessing elements from the array
console.log(dynamicArray[1]);  // Output: Python
```

JavaScript arrays offer seamless manipulations for building and modifying collections of data dynamically.

In a dynamic array, resizing occurs when the current capacity is reached and there is a need to accommodate more elements. When the array reaches its capacity, it dynamically increases its size to make room for additional elements. This process involves allocating a new array with a larger size, copying the existing elements to the new array, and then changing the reference to point to the new array.

In Java, the `ArrayList` class handles resizing internally by increasing its capacity as needed. When elements are added beyond the current capacity, the `ArrayList` automatically reallocates and copies the existing elements into a larger array.

In Python, lists also dynamically resize as necessary. When the number of elements exceeds the current capacity of the list, Python automatically allocates a larger contiguous block of memory for storing elements and copies over the existing elements.

JavaScript's arrays also have dynamic resizing behavior built in. As more elements are added to an array in JavaScript, it automatically grows in size to accommodate new additions.

This automatic resizing feature of dynamic arrays enables them to be efficient for managing collections of data without needing manual intervention to manage memory allocation.