---
title: "Strategy Pattern"
date: 2024-04-29T20:06:16-04:00
draft: false
---

The strategy pattern is a behavioral pattern which lets you dynamically choose an algorithm from family of algorithms at runtime.

<!--more-->

## What is Strategy Pattern?

The strategy pattern is useful when you have multiple algorithms to choose from at runtime. You can avoid awkward looking `if...else` logic using strategy pattern. In this pattern a strategy class encapsulates an algorithm. The client also knows about what algorithm to choose and the client selects which strategy to execute. In standard Java library, `java.util.Comparator` is a good example of this pattern. The client decides how to compare two objects using this `Comparator`.

## How to implement Strategy Pattern?

The strategy pattern mainly consists of following actors.
- Context: This is the object on which the algorithm or strategy to be applied. It has a reference to one of the conrete strategies. The context object has a setter method which can be used to set the concrete strategy object.
- Strategy: This is an interface which is implemented by concrete strategies. This interface also declares a method the context uses to execute a strategy. The concrete strategies implement the algorithm using the method declared in the interface. These concrete strategies also implement that method.
- Client: The client knows about all strategies and actually creates a strategy object. It specifies which of the strategies to use for the context.

## Practical Code - Order Discounts

In our example, we will write code for having multiple different order discount strategies.

1. In the context class identify an algorithm, that's changing based on `if..else` conditional. Based on this define a `Strategy` interface. In this case, I have defined `DiscountStrategy` interface which declares a method for `getDiscount(price)` with parameter price of the order.

```java
public interface DiscountStrategy {
    double getDiscount(double price);
}
```

2. Based on this implement all possible discount strategies.

    a. `ZeroDiscountStrategy` applies zero discount on given order. 

    ```java
    public class ZeroDiscountStrategy implements DiscountStrategy {
        @Override
        public double getDiscount(double price) {
            return 0;
        }
    }
    ```

    b. `FixedDiscountStrategy` applies fixed amount of discount which is passed in the constructor parameter.

    ```java
    public class FixedDiscountStrategy implements DiscountStrategy {
        private final double discountAmount;

        public FixedDiscountStrategy(double discountAmount) {
            this.discountAmount = discountAmount;
        }

        @Override
        public double getDiscount(double price) {
            if (price < discountAmount) {
                return price;
            } else {
                return discountAmount;
            }
        }
    }
    ```

    c. `PercentageDiscountStrategy` applies percentage of the cost of order.

    ```java
    public class PercentageDiscountStrategy implements DiscountStrategy {
        private final double discountPercentage;

        public PercentageDiscountStrategy(double discountPercentage) {
            this.discountPercentage = discountPercentage;
        }

        @Override
        public double getDiscount(double price) {
            return price * discountPercentage / 100;
        }
    }
    ```

3. The context class has to have a method to set the strategy. In this case, `Order` has a method to set discount strategy. Notice that it works with the interface.

```java
public class Order {
    private double price;
    private DiscountStrategy discountStrategy;

    public Order(double price, DiscountStrategy discountStrategy) {
        this.price = price;
        this.discountStrategy = discountStrategy;
    }

    public Order(double price) {
        this(price, new ZeroDiscountStrategy());
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setDiscountStrategy(DiscountStrategy discountStrategy) {
        this.discountStrategy = discountStrategy;
    }

    public double getTotal() {
        return price - discountStrategy.getDiscount(price);
    }
}
```

4. Now, the client can required strategy as they wish.

```java
public class Main {
    public static void main(String[] args) {
        Order order = new Order(100);
        System.out.println("Total price with zero discount: " + order.getTotal());

        order.setDiscountStrategy(new FixedDiscountStrategy(10));
        System.out.println("Total price after 10$ discount: " + order.getTotal());

        order.setDiscountStrategy(new PercentageDiscountStrategy(24));
        System.out.println("Total price after 24% discount: " + order.getTotal());
    }
}
```

### Advantages:
- Each algorithm has its own class. This way code becomes more flexible and you can easily add new strategy without modifying existing ones.
- Strategy pattern follows single responsibility principle making code maintainable.

### Drawbacks:
- It adds several additional classes to manage.
- Client has to be aware of all available concrete strategies.

## Summary
- Strategy pattern is good pattern to have multiple interchangeable algorithms organized into their classes.
- The client decides at runtime which strategy to use.
- This can be useful to reduce conditional logic statements in the system. The client can simply decide the algorithm and set it on the context object.