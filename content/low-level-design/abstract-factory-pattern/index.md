---
title: "Abstract Factory Pattern"
date: 2024-02-16T18:22:49-05:00
draft: false
---

Abstract Factory pattern is a creational design pattern that allows you to create families of inter-related (dependent) objects without directly specifying their actual concrete classes.

<!--more-->

## What is Abstract Factory Pattern?

Factory method is good when we have only few concrete classes to build. If we have lots of concrete classes and probably similarly related classes for each of them, we might end up creating too many unnecessary Factory classes. For example, in banking scenario, let's say we have `PersonalAccount` and `BusinessAccount`. Each of these types of accounts can have `CheckingAccount`, `SavingsAccount` and `TradingAccount`. This kind of inter-related objects might need their own separate Creator classes with common interface. However, that will be too much code to write. Abstract Factory method helps solve such issues.

- This pattern is very similar to factory method pattern.
- It is implemented as factory of factories hierarchy
- It's used in `javax.xml.parsers.DocumentBuilder` and several other classes in standard Java library.

## Intuition

Let's say you're working with an online furniture store and you want to sell different types of furnitures. These include foldable furniture and non-foldable Furniture. In each furniture category, you have products like `Table`, `Chair`, `Sofa`, `Bed` etc. These would require creating classes for each subclass which might be too much code. Every time we have to add a new type of furniture, we have to create a new subclass.

To solve this problem, we can create an interface for `Furniture` which defines methods for each type of furniture. For example, it will have methods for creating table, sofa, bed and chair. These methods do not specify specific type of product being created, but it simply returns more abstract type such that it provides more flexibility. We will also have factory for `Furniture` which have methods defined for creating non-foldable furniture and foldable furniture. This way we are decoupling the code into their own subclasses along with major furniture type into their factories. In this pattern, we group multiple factories together by making a single factory which has methods to create concrete Product types. It also needs a parameterized create method in order to create specific type of factory just like factory method pattern.

## Code Example




### Advantages

- Client code only interacts with abstract factory which makes it more flexible and maintainable.
- Adding new concrete product families or related objects is easy. This requires creating new concrete factories without modifying existing code.

### Disadvantages

- It is more complicated to write this factory pattern.
- It uses runtime switch between different factories. Client has to know upfront which type of client they want to create.

### Comparison with Factory Method

| Factory Method | Abstract Factory |
|:---------------|:-----------------|
| focuses on creating one specific type of object. | focuses on creating family of related objects. |
| has just one `create` method for creating desired type of object. | uses multiple `create` methods. Each for specific type of object within a family. |
| relatively simpler | more complex but more flexible for large number of objects. |
| less flexible | more flexible. |
| have to write more subclasses than abstract factory | requires relatively less subclasses compared to factory method. |

## Summary

- It is used to group similar factories together.
- This can be relatively complex than other creational patterns.
- It relies heavily on interfaces and abstract classes to define interface and also uses composition.