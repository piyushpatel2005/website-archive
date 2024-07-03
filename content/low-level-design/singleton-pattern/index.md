---
title: "Singleton Pattern"
date: 2024-02-22T22:58:18-05:00
draft: false
---

Singleton pattern is also another most commonly used pattern. This pattern ensures that a class has only one instance and provides this single object to all associated classes globally. If there is already existing instance, it returns that instance else this creates a new one.

<!--more-->

## What is Singleton Pattern?

Singleton design pattern is useful when you want to provide access to some shared resource such as a database or a shared file. If an instance already exists, it returns that instance. In order to achieve this, we must make constructor private so that noone can call the constructor. Whenever we call the constructor, it by definition returns a brand new object. This instance also provides single point of access to some object. This is heavily used in standard Java library in `Runtime`, `SecurityManager` classes. It's also widely used in standard Loggers available as open source products.

For example. if you need system wide single Logger class instance. You can create multiple logger instances but managing those instances will be cumbersome and can also cause issues. Also possible usecase is when you want to control system-wide seetings or configurations. In these cases, you would like to use singleton pattern.

## How to implement Singleton pattern?

1. Restrict access to new object creation by making the constructor private.
2. Provide a static method for creating an instance if it doesn't exist and return existing object if it already exists. This method provides a single point of access to get an object.
3. For multi-threaded implementation, make sure to make this method `synchronized` to avoid race conditions resulting due to multiple threads trying to access the instance of the class.

## Practical Example - Logger

```java
public class Logger {
    private static Logger instance;

    private Logger() {
        if (instance != null) {
            System.out.println("Logger instance already exists");
        }
    }

    public static Logger getInstance() {
        if (instance == null) {
            instance = new Logger();
        }
        return instance;
    }

    public void log(String message) {
        System.out.println(message);
    }
}
```

In above code, I have defined `Logger` class with `private` constructor. Other classes cannot instantiate this class instance because the constructor is private. Next, I have defined `getInstance()` static method which acts as a single point of access. Here, I check if there already exists and instance, I return the available instance else I create a new one and return it. In this code, we also do not create the member variable `instance` until the method is called first time. This is called lazy initialization where instance is created only when it's actually needed.

In the `main()` method below, we try to create two instances of the `Logger` class, but when we check equality, they actually refer to the same instance of the class.

```java
public class Main {
    public static void main(String[] args) {
        Logger logger = Logger.getInstance();
        logger.log("Hello World");

        // Even if we try to create new instance, it returns the same instance of the class.
        Logger logger2 = Logger.getInstance();
        System.out.println(logger == logger2);
    }
}
```

To avoid race condition in multi-threaded environment, we have to make `getInstance()` method `synchronized`.

```java{ lineNos=false}
    public static synchronized Logger getInstance() {
        // code for instance creation
    }
```

One of the problems with this kind of synchronized block is that regardless of whether we want to create an instance or not, we are locking this method. This can be expensive for multi-threaded operation. In order to easily handle this situation, we can first check if the `instance` is `null`. If yes, then we assign a lock and next, we have to again check `null` to make sure no other thread has created an instance of this class. This is also called double check locking.

```java
    public static Logger getInstance() {
        if (instance == null) {
            synchronized (Logger.class) {
                if (instance == null) 
                    instance = new Logger();
            }
        }
        return instance;
    }
```

This makes sure if the instance is not initialized, then only we assign the lock. This gives performance improvement.

### Advantages:

- Provides single point of access for instances of a class.
- With lazy initialization, it avoid unnecessary object creation.

### Disadvantages:

- It can be difficult to unit test Singleton objects.
- In multi-threaded environment, it can be difficult to make it threadsafe.
- If overused in multi-threaded environment, it can result in performance hit due to necessary synchronization.

### Comparison with Factory pattern

| Factory Pattern                                           | Singleton Pattern                                                     |
|:----------------------------------------------------------|:----------------------------------------------------------------------|
| Factory can return multiple instances of a class.         | Singleton returns only single instance.                               |
| It can have multiple constructors                         | It has single private constructor.                                    |
| This is usually interface driven.                         | This has just a single static method and do not need interface.       |

## Summary

- This is widely used to ensure there is only one instance of the class.
- This pattern is relatively easy to implement in single-threaded environment but does require some additional tweaking to make it work in multi-threaded system.
- This pattern is used to access a shared resource to avoid overhead of creating multiple instances.
