---
title: "Factory Method Pattern"
date: 2024-02-16T15:23:50-05:00
draft: false
---

This is a creational design pattern where object creation is done without actually specifyihng exact class of the object needed. This method is not so popular because Abstract Factory pattern overtakes this pattern.

<!--more-->

## What is Factory Pattern?

This pattern delegates concrete instantiation to a method of a subclass. This pattern focuses on object creation without specifying the exact class of the object needed. The factory pattern, as the name suggests, acts like a factory which can produce desired product (object type) and delivers the objects without code needing to know the specific details of how to create it. This pattern does not expose the instantiation logic to the client and defers the instantiation logic to subclasses. Client only knows the common interface available for object creation.

This is usually implemented by the framework you use in your code but a developer can also incorporate in their code if appropriate. Factory is responsible for the lifecycle of objects and it is referenced from a common interface. It can create multiple concrete classes and will include a method to request an object using parameterized `create` method. This method is also called **virtual constructor** pattern.

This pattern is used when the superclass does not know about what type of object to create.

## Simple Factory Pattern:

Suppose, you're creating a banking system where initially you offer `CurrentAccount`. You have embedded all code for depositing and withdrawing money in the same `CurrentAccount`. Let's say after few years, you want to expand your account offerings and want to add `SavingsAccount`, you can easily create `BankAccount` interface with `CurrentAccount` and `SavingsAccount` implementing this interface. However, your code is all in `CurrentAccount`. It's become tightly coupled with this class and will require major refactor. 

You can use factory design pattern to remove direct call of creating different types of accounts. Now, there are two variations of this pattern. One is called simple factory and another called factory method pattern.

In simple factory, we simply pass a parameter specifying what type of Product class we want to create and Factory will take care of it. However, when we have to add new Product class, we have to modify Factory class method with new `if..else` block to accommodate new Product instantiation. This can lead to bugs with factory class. It breaks Open/Closed principle.

In this case, if we have to add another type of account, we have to modify not only client code but also the factory class.


## Factory Method Pattern:

Another variation of Factory design pattern is called Factory method pattern. In this, we define Product using common interface and then Creator also has its own common interface. The `Creator` class declares a factory method that returns new generic `Product` objects. It has to have return type as a common interface for Product class. The `Creator` class also declares abstract factory method to force all subclasses of Creator to implement their own version of factory method. The factory methods helps decouple the object creation logic from the concrete product class. The subclasses of `Creator` class override the base factory method so it returns a different type of Product. The factory method doesn't always need to create new object. They can also return existing objects from local cache.

Here, if we have to add new type of account, we simply have to subclass the `Creator` class and `Product` class and only modify the client code to create new type of account. This is loose coupling.

### Code Example:


### Advantages:

- This promotes loose coupling because the client code is not tied to the specific concrete class. So, it makes the code more maintainable.
- The factory encasulates object creation logic and hides implementation details from the client.
- To add new product (actual concrete class) is easy without modifying existing code. Thus less possibility of breaking existing code.
- Replacing Product with something else is relatively easy.

### Disadvantages:

- It is relatively complex in the logic and requires lot more code.
- The object creation logic is not in the factory class but it is in the actual subclass being created.
- We might need to unnecessarily subclass the Creator class just to create a new concrete Product.

### Comparison with Singleton Pattern

| Singleton                         | Factory Pattern                    |
|:----------------------------------|:-----------------------------------|
| returns same instance every time  | returns new instance every time    |
| one constructor with no arguments | multiple constructors are involved |
| There is no interface             | It's mostly driven by interface    |
| There is no subtypes involved.    | It's mostly inheritance driven.    |

## Summary

- This pattern is parameter driven.
- It solves the problem of complex creation of objects in different ways
- It can be little bit complicated due to added subclasses.
