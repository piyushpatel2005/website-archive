---
title: "What Are Design Patterns"
date: 2024-02-16T14:32:49-05:00
draft: false
---

Design patterns are reusable proven solutions to commonly occuring problems. In software industry, there are several use cases which require a specific kind of solution to make your software code be more maintainable and reusable. Design patterns provide a general way of organizing code such that it solves specific problem
<!--more-->

Design patterns also provide common language for communication with your colleagues and other developers. There are three main categories of Design patterns.

1. Creational Patterns: deals with object creation
2. Structural Patterns: focus on how to organize classes and objects to make the code more flexible and reusable.
3. Behavioral Patterns: focus on collaboration between different objects in a software system.

Each of these categories include several different patterns mentioned below.

## 1. Creational Design Patterns

- Factory Method Pattern: This provides an interface for creating objects in a superclass but actual class is created based on derived subclasses.
- Abstract Factory Pattern:
- Singleton Pattern: This pattern is also widely used for creating only one instance of an object. This object then will be available globally for relevant use.
- Builder Pattern: This is widely used to create objects with additional properties or options. We can configure the actual final object by method chaining to add new options.
- Prototype Pattern: This pattern is used to copy existing objects without strong coupling with the original classes.

## 2. Structural Design Patterns

- Adapter Pattern: This pattern provides a way to collaborate objects with incompatible interfaces. It is like we need adapter for exchanging information between two incompatible systems.
- Bridge Pattern: This pattern decouples abstraction from its implementation allowing for easy changes or extension of either part of the system independently. They can be developed independently.
- Composite Pattern: This lets you compose objects into tree like hierarchical structure and treats a group of objects as a single object allowing you to work with them in a uniform manner.
- Decorator Pattern: Allows to add new behaviors to objects by wrapping it in a decorator object. Thus, we don't have to modify the original object's code.
- Facade Pattern: This provides a simplified interface to a complex system and hides the underlying implementation details from the client.
- Flyweight Pattern: It helps improve memory efficiency by sharing common parts of state between multiple objects instead of keeping all the data in each object.
- Proxy Pattern: This provides a proxy or substitute or placeholder for another instance. This can be used in various scenarios like for access control, to perform additional actions before or after the request, lazy loading, etc.

## 3. Behavioral Design Patterns

- Command Pattern: This pattern is used to encapsulate client requests into an object.
- Chain of Responsibility: This creates a chain of objects which can handle incoming requests. The request passes through this chain until one of the objects handle the request.
- Iterator Pattern: This pattern allows the access to elements of an objects without actually exposing the underlying structure of the object. How those elements are stored inside the object is not exposed.
- Mediator Pattern: This pattern is used to restrict direct communication between two objects and forces them to collaborate using a mediator object.
- Memento Pattern: This pattern allows capturing and restoring the internal state of an object without revealing its implementation details.
- Observer Pattern: This allows an object to monitor the changes of another object. When an object changes its state, all the observer objects are notified and updated automatically with this pattern.
- State Pattern: In this pattern, an object alters its behavior when its internal state changes. This allows for different  behavior of the object based on object's state.
- Strategy Pattern: This pattern is used to define family of algorithms. This allows subclasses have different algorithm implementation and to redefine certain aspects of algorithms without changing the algorithm's structure.
- Template Method Pattern: This defines a template (skeleton) of an algorithm in parent class. The child classes can then override specific steps without changing its structure.
- Visitor Pattern: This pattern defines a new operation and can be applied to hierarchy of objects without changing the classes of these objects.

