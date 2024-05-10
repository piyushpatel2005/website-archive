---
title: "Template Method Pattern"
date: 2024-04-29T20:23:40-04:00
draft: false
---

Template design pattern is used to define an algorithm skeleton while also allowing subclasses to redefine parts of this algorithm without changing the original structure.

<!--more-->

## What is Template Pattern?

Template design pattern is a behavioral design pattern which defines the skeleton of an algorithm in super class which is usually abstract and sub-classes will implement specific part of the algorithm or they may redefine differently.

In simple terms, it is similar to a recipe defined in a cookery book. The steps are mentioned in broad way. The specific step might have little differences depepnding on your taste and style. For example, the step might say something like "Add salt according to your tastes." and you might add 1 tbsp salt in your dish.

Another example might be for the shopping orders. Whenever we go for shopping whether online or in-store, we follow specific steps. We add items in basket or cart, we pay, get a receipt of purchase and we get the items. We can have a method to process an order which would have these four methods defined but the actual implementation of these methods may be dependent on specific type of order, i.e. whether online, phone order or whether in-store. So, we can have a template with `abstract` methods and specific type of order overrides those methods. These methods may have default behavior which child classes can override. 

All the common methods are used in a separate method which outlines the common steps in orders. This method is called *template method*. The common abstract methods are called *hooks*.

## How to implement Template Pattern?

The template method pattern is relatively simple. It consists of following.

- Abstract class: It has a defined method which calls abstract methods. It also declares methods that act as steps of the algorithm we are processing. These steps can have default implementation if it makes sense else they can be `abstract` which means class may have to be `abstract` as well.
- Subclasses: The concrete classes can override all the steps declared in abstract class and provide specific implementation.

This pattern is useful when you want to let clients extend only specific parts of an algorithm, but not the structure of the algorithm. This pattern can be used when you have several classes with similar algorithm. In this case, we can have those similar steps defined in the parent class and only the different parts can be implemented as a hook in child classes for specific algorithms.

## Practical Code - Shopping Orders

In this tutorial, we take example of Shopping orders.

1. Define abstract class with template method. In this case, we have `OrderTemplate` defined as an `abstract` class with template method `processOrder()` which goes over specific steps. Some of those methods are `abstract` and some have default implementation. Note that the template method is defined as `final` so that other classes cannot override the behavior of this method.

```java
public abstract class OrderTemplate {
    public final void processOrder() {
        checkout();
        processPayment();
        provideConfirmation();
        deliver();
    }

    public void checkout() {
        System.out.println("Checking out items in the cart");
    }

    public abstract void processPayment();

    public abstract void provideConfirmation();

    public abstract void deliver();
}
```

2. Create concrete classes extending abstract class.

    a. Define `InStoreOrder` class representing in-store orders. Provide implementation for in-store orders.

    ```java
    public class InStoreOrder extends OrderTemplate {
        @Override
        public void processPayment() {
            System.out.println("Process payment with cash, debit, credit or gift card");
        }

        @Override
        public void provideConfirmation() {
            System.out.println("Print receipt for the order.");
        }

        @Override
        public void deliver() {
            System.out.println("Bag items at the counter");
        }
    }
    ```

    b. Create `OnlineOrder` class providing implementation for online orders.

    ```java
    public class OnlineOrder extends OrderTemplate {
        @Override
        public void processPayment() {
            System.out.println("Provide credit card information and process payment");
        }

        @Override
        public void provideConfirmation() {
            System.out.println("Email receipt for the order.");
        }

        @Override
        public void deliver() {
            System.out.println("Notify the shipping department to pack the item for delivery.");
        }
    }
    ```

    c. Create `PhoneOrder` class which can be used to place order over a phone call.

    ```java
    public class PhoneOrder extends OrderTemplate {
        @Override
        public void processPayment() {
            System.out.println("Process payment with cash on delivery or card on delivery");
        }

        @Override
        public void provideConfirmation() {
            System.out.println("Send order details to customer using SMS or Email.");
        }

        @Override
        public void deliver() {
            System.out.println("Deliver items to customer address.");
        }

        @Override
        public void checkout() {
            System.out.println("Confirm order with customer over the phone and check out items.");
        }
    }
    ```

3. The client can now work with template method simply by executing `processOrder()` on any type or oders.

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Web Order Example");
        OnlineOrder webOrder = new OnlineOrder();
        webOrder.processOrder();
        System.out.println("--------------------");

        System.out.println("In Store Order Example");
        InStoreOrder inStoreOrder = new InStoreOrder();
        inStoreOrder.processOrder();
        System.out.println("--------------------");

        System.out.println("Phone Order Example");
        PhoneOrder phoneOrder = new PhoneOrder();
        phoneOrder.processOrder();
    }
}
```

### Advantages:
- It reduces code duplication by providing common methods in abstract parent class with default implementation for some other methods.
- It promotes code reusability
- Template method pattern provide flexibility for child classes to override specific step through hook methods.

### Disadvantages:
- You need to ensure that certain methods cannot be overridden.
- If the core of the algorithm needs to change, it will require changes in all subclasses.
- Understanding the flow of the algorithm might be little difficult due to inheritance structure.

### Comparison with Strategy Pattern:

| Strategy Pattern                              | Template Pattern                              |
|:----------------------------------------------|:----------------------------------------------|
| This has complete algorithm per strategy class| It provides specific step of the algorithm in sub class. |
| This is driven by interface.                  | This is class-based design.                   |
| Used when you need to choose algorithm at runtime. | This is chosen at compile time.          |

## Summary
- Template method pattern is based on inheritance and polymorphism principles.
- This pattern promotes code reusability by extracting common part of the algorithm and providing hooks to implement specific steps.
- It may be easier to implement this pattern.
