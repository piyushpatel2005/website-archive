---
title: "Prototype Pattern"
date: 2024-02-23T22:47:21-05:00
draft: false
---

Prototype design pattern lets you to create new objects by copying an existing object. This tutorial explains what prototype pattern is, how to implement it with practical example. 

<!--more-->

## What is Prototype Pattern?

If you want to create a copy of the object. You have to go through all parameters of the original object and copy them one after another. This might be easier to visualize but in reality it can be very difficult. If we have an existing object, it may some properties defined as `private`. Those properties cannot be easily accessed. Also, copying reference type attributes might be difficult and prone to errors. This pattern is used to get a new unique instance of the same object.

The prototype pattern delegates the object creation to the object which is being cloned. This pattern is particularly useful when you have to create a complex object. This pattern declares an interface for all objects that follow this pattern and those classes have an abstract method `clone()` defined in them. Prototype pattern delegates the actual object copying to original object which needs to be copied. The concrete classes from the interface have actual implementation of `clone()` method which copies data members. They can also have additional logic and other methods. An object that has these `clone()` method defined is called a *prototype*. This is similar to factory prototypes where we can model multiple new items based on a prototype.

In standard java library, `Object` class has a `clone()` method defined in it. This is typically used with `Registry` which is used to store prototypes and provides easy access to them. The costly process of object creation is handled by the client if needed. During implementation of `clone()` method, we can decide if we want to have a deep copy or a shallow copy although usually deep copy is used.

## How to implement Prototype pattern?

1. First of all, a common interface is defined for all prototype products which has an abstract method `clone()` declared in them. This method can have a different name if needed.
2. Based on this common interface, we will have multiple concrete prototype products. These products have parameters defined in them. They also implement `clone()` method which handles copying object's data members into new object. This also takes care of copying reference type properties and primitive properties.
3. The client code can now simply call `clone()` method and assign the new copy to a new variable. In Java, the prototype classes implement `Cloneable` marker interface to indicate that the `clone()` method is defined and we can call that method. If it is not implemented, we may get exception `CloneNotSupportedException`.
4. If needed, add a `Registry` class which stores all prototype objects for easy access. This can be in the form of `HashMap` to store key-value pairs of name and object.

### Advantages:

- Avoids unnecessary subclasses by allowing objects to be created using `clone()` method. This acts as an alternative to inheritance.
- This is useful when new object creation using `new` keyword is lot more costly. This helps improve the performance of the system.
- It hides complexities of object creation from the client code.
- helps reduce code duplication by just copying existing prototype and modify only required properties.

## Disadvantages:

- All concrete classes have to implement `clone()` method.
- This can be cumbersome when we want to modify all of the properties of the prototype object.
- Cloning complex objects might result in circular references which might be difficult to track.

### Comparison between Factory and Prototype pattern

| Factory Pattern                                           | Prototype Pattern                                     |
|:----------------------------------------------------------|:------------------------------------------------------|
| object construction process might be heavy                | light weight construction process                     |
| focused on creating flexible objects.                     | focused on light weight copy construction             |
| Everytime a new instance is created                       | A copy of existing instance is created                |

## Summary

- Prototype pattern ensures that we receive a unique instance everytime a `clone()` method is called.
- This pattern can help improve performance when object creation is a heavy process.