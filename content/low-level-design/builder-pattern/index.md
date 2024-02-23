---
title: "Builder Pattern"
date: 2024-02-19T19:06:50-05:00
draft: false
---

Builder design pattern is yet another creational pattern which is very useful when you have lots of configurations to perform on the object. The object may have too many attributes to set in constructor. This tutorial discusses about Builder design pattern in great detail with Java language.

<!--more-->

## What is Builder Pattern?

This is one of the most popular design patterns for creating objects. It's widely used in frameworks and libraries to create objects that require a lot of parameters. Usually initializing those objects with all parameters might be cumbersome because sometimes they are not needed but other times they might be needed. So, builder pattern provides a way to initialize only required parameters with other parameters getting the default values. This pattern also ensures that the object parameters are immutable once created. If we were to create constructors for this kind of objects, we might end up creating lots of overloaded constructors with few parameters. These are called telescoping constructors which might pollute our code. This pattern solves that problem. It's used quite a lot in standard Java library. The most common ones are `StringBuilder`, `DocumentBuilder`, etc.

## How to implement Builder Design Pattern?

Let's say, we are working for a burger shop and we want to be able to build burger based on some ingredients. These ingredients might vary widely depending on the customer. Some customers might prefer to have vegetables like tomatoes, lettuce, onion, etc. whereas other customers might prefer non-vegetarian ingredients. Some customers might even omit few of the vegetables. Let's see how we might start creating these burgers. For this demo, I am assuming only three ingredients available: onion, tomatoes, lettuce, but there may be many more. Also, for simplicity, I have represented the ingredients as boolean, but they may have their own class with weight or other measurements.

```java
public class Burger {
    private boolean onion;
    private boolean tomatoes;
    private boolean lettuce;

    public Burger(boolean onion, boolean tomatoes, boolean lettuce) {
        this.onion = onion;
        this.tomatoes = tomatoes;
        this.lettuce = lettuce;
    }

    public Burger(boolean onion, boolean tomatoes) {
        this(onion, tomatoes, false);
    }

    public Burger(boolean tomatoes) {
        this(false, tomatoes, false);
    }
}
```

In this case, we have assumed only three possible ingredients and had to add two extra overloaded constructors. On top of that, we also have to have fat constructors which might be initializing lots of parameters which is unreadable.

In order to convert this to a Builder pattern, we have to extract the `Burger` making into a separate class `BurgerBuilder`. In order to extract to a builder pattern, we have to follow below steps.

1. Make constructor for the Product class private so that there is no way to directly invoke it.
2. Create static inner class `Builder` in the Product class with single parameter of Product class defined with default values.
3. Define methods for each parameter of the Product class which returns the `Builder` itself while setting the parameter for the Product class.
4. At the end define `build()` method in the `Builder` class which actually returns the Product itself.

Following these steps, we will have a code similar to below.

```java
package com.github.piyushpatel2005.builder.simple.burger;

public class Burger {

    private String breadType;
    private boolean onion;
    private boolean tomatoes;
    private boolean lettuce;
    private boolean cheese;

    private Burger(String breadType, boolean onion, boolean tomatoes, boolean lettuce, boolean cheese) {
        this.breadType = breadType;
        this.onion = onion;
        this.tomatoes = tomatoes;
        this.lettuce = lettuce;
        this.cheese = cheese;
    }

    public static class Builder {
        private Burger burger = new Burger("", false, false, false, false);

        public Builder withBread (String breadType) {
            burger.breadType = breadType;
            return this;
        }

        public Builder withTomatoes() {
            burger.tomatoes = true;
            return this;
        }

        public Builder withOnion() {
            burger.onion = true;
            return this;
        }

        public Builder withLettuce() {
            burger.lettuce = true;
            return this;
        }

        public Builder withCheese() {
            burger.cheese = true;
            return this;
        }

        public Burger build() {
            return burger;
        }

    }

    @Override
    public String toString() {
        return "Burger{" +
                "breadType='" + breadType + '\'' +
                ", onion=" + onion +
                ", tomatoes=" + tomatoes +
                ", lettuce=" + lettuce +
                ", cheese=" + cheese +
                '}';
    }
}
```

Now, the client can easily create objects with required ingredients and it will look lot more cleaner.

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Create Burger with tomatoes only");
        Burger burger = new Burger.Builder()
                .withBread("Wheat")
                .withTomatoes()
                .build();
        System.out.println(burger);

        System.out.println("Create burger with tomatoes, lettuce and cheese");
        burger = new Burger.Builder()
                .withBread("Wheat")
                .withTomatoes()
                .withLettuce()
                .withCheese()
                .build();
        System.out.println(burger);
    }
}
```

## Builder Design Pattern with Director

Although above pattern works, we might segregate construction of object out of client. In above code, the client code is actually building the Product which may not be convenient. We can extract those construction logic into Director class. The director class simply provides building steps and the bulider provides the actual implementation for those steps. Sometimes, this might be important to make sure we have prerequisite set before setting the next parameter. This class completely hides the details of product construction from the client code. The client simply needs to assign specific type of builder with a director. In this case, we also have more than one type of concrete builders. We will have `Builder` defining the common interface for creating different types of products with concrete Builders actually implementing the methods from Builder interface.

The client code can pass the actual concrete builder using one of the parameters in the constructor or by using configuration file.

### Advantages:

- This pattern handles complex object creation with multiple parameters or configurations.
- The builder actually controls the object construction and doesn't expose the object directly promoting encapsulation.
- The code for object construction with its properties reside in the same class if implemented as a static inner class.
- This pattern can also be implemented easily for legacy code.

### Disadvantages:

- Static inner classes add to the complexity of implementation.
- Having separate builder classes along with the main product classes increase the overall code complexity.
- Builder pattern for objects with very few parameters might be an overkill.

### Comparison with Abstract Factory Pattern:

| Abstract Factory Pattern                          | Builder Pattern                                                   |
|:--------------------------------------------------|:------------------------------------------------------------------|
| focuses on building families of related objects   | focuses on creating object step by step                           |
| it returns the product object immediately         | it adds construction steps one by one and finally returns object. |
| class usually includes less number of params.     | class includes lots of parameters to pass into constructor.       |

## Summary

- Builder pattern provides nice construction method to avoid telescoping constructors.
- It avoids having to write multiple unnecesary constructors to handle large number of optional parameters.
- With director, we can control the sequence of construction of objects.
- It abstracts away object creation and follows single responsiblity principle.