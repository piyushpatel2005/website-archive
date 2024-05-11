---
title: "Facade Pattern"
date: 2024-04-03T10:35:23-04:00
draft: false
---

Facade is a structural design pattern provides a simple interface for client to interact with a complex system. The system internally might have lots of different classes and methods. Facade provides a simple abstraction on that system or library. This tutorial explains Facade with practical Java examples.

<!--more-->

## What is Facade?

If you have built a system which uses 3rd party API or library and is tied to their implementation of specific functionality, you might have various different classes initialized to meet the requirements of the API provided by that library. Those classes and objects may not be relevant for your use case but you still needed follow the API. The end user for your application might only care about specific set of functionalities and they do not need to care about those details. In this case, Facade can provide a very simple interface for the end users of your application which hides the complexity of the system. Facade usually includes only the required features that the client wants.

For example, complex ecommerce web applications might have order placement service. Behind the scenes those services might be interacting with third party services like Stripe. Although Stripe might have lots of different funtionalities to have payment option, the order placement service might only need a simple function which has method like `charge(double amount, CreditCard cc)` which charges a creditcard with specific `amount` of money. This is an example of Facade design pattern. You might have already applied this design pattern several times without even noticing it.

In banking, when you want to contact bank operator with a phone, you might go through automated system, that's also an example of real world facae. It hides lots of different functions that bank might be performing but you get simple options to choose.

## How to implement Facade pattern?

1. Identify the complex subsystem and if it's possible to provide simpler interface for the client code.
2. Identify and define the Facade interface that you want to provide for the client. This may or may not mean actually declaring an `interface` in Java. Implement this interface in a new class. This Facade should actually interact with subsystem but client interacts only with this Facade. Facade should have instance of the subsystem to work with it.
3. Make client code communicate with Facade rather than subsystem code. This way we decouple subsystem from the client and it becomes easier to update Facade to user newer API when subsystem updates to newer version.

In standard Java library, `java.net.URL` is a great example of Facade pattern. It hides the complexity of interacting with different protocols. It can work with FTP, HTTP, HTTPs, etc. without client directly interacting with those handlers.

### Facade for Payment Service

Let's say we want to provide various payment options for our customers, but we want to hide the implementation of our different payment processors.

```java
public interface PaymentService {
    boolean pay(double amount, String accountNumber);
}
```

We have concrete payment processors for Debit card, credit card and gift card that handles payment methods of respective card type.

```java
public class DebitCardPayment implements PaymentService {
    @Override
    public boolean pay(double amount, String accountNumber) {
        System.out.println("Paying $" + amount + " using debit card " + accountNumber);
        return true;
    }
}
```

```java
public class CreditCardPayment implements PaymentService {
    @Override
    public boolean pay(double amount, String accountNumber) {
        System.out.println("Paying $" + amount + " using credit card " + accountNumber);
        return true;
    }
}
```

```java
public class GiftCardPayment implements PaymentService {
    @Override
    public boolean pay(double amount, String accountNumber) {
        System.out.println("Paying $" + amount + " using gift card " + accountNumber);
        return true;
    }
}
```

For client, we want to provide a simple `makePayment()` method which takes the credit card number, card type and the amount which needs to be charged. For this, we can create a Payment Facade which will handle respective payment type. It will have instance of respective `PaymentService`.

```java
public class PaymentServiceFacade {
    private CreditCardPayment creditCardPayment;
    private DebitCardPayment debitCardPayment;
    private GiftCardPayment giftCardPayment;

    public PaymentServiceFacade() {
        creditCardPayment = new CreditCardPayment();
        debitCardPayment = new DebitCardPayment();
        giftCardPayment = new GiftCardPayment();
    }

   public boolean makePayment(double amount, String accountNumber, String paymentType) {
        if (paymentType.equals("credit")) {
            return creditCardPayment.pay(amount, accountNumber);
        } else if (paymentType.equals("debit")) {
            return debitCardPayment.pay(amount, accountNumber);
        } else if (paymentType.equals("gift")) {
            return giftCardPayment.pay(amount, accountNumber);
        } else {
            return false;
        }
    }
}
```

Here `PaymentServiceFacade` provides a high level method `makePayment()` for the client and it decides on the concrete payment method which needs to handle the payment behind the scene.

### Facade with Order Management

Another complex system could be order management. When we place an order, there are lots of checks that need to go through before order is accepted and money being charged. We can hide these complexities using a facade. It needs to handle Inventory to update inventory and verify if we have enough inventory to take this order, it has to actually create an order in the system, it has to charge the credit card or other form of payment and it has to notify the user that their order has been successfully place and further a shipping team has to be notified to ship this product promptly. All these complexities could be hiddden with simple `placeOrder()` method in Order management facade.

```java
interface InventoryService {
    void update(String productId, int quantity);
    boolean isAvailable(String productId, int quantity);
}

class InventoryServiceImpl implements InventoryService{
    private Map<String, Integer> inventory;

    public InventoryServiceImpl() {
        this.inventory = new HashMap<>();
        populateInventory();
    }

    private void populateInventory() {
        inventory.put("A", 100);
        inventory.put("B", 10);
        inventory.put("C", 1000);
        inventory.put("D", 0);
    }

    @Override
    public void update(String productId, int quantity) {
        System.out.println("Updating inventory for product " + productId + " quantity " + quantity);
    }

    @Override
    public boolean isAvailable(String productId, int quantity) {
        int itemsAvailable = inventory.getOrDefault(productId, 0);
        return itemsAvailable >= quantity;
    }
}
```


```java
interface OrderProcessingService {
    void createOrder(String product, int quantity, String customerInfo);
}

class OrderProcessingServiceImpl implements OrderProcessingService{
    @Override
    public void createOrder(String product, int quantity, String customerInfo) {
        // Business logic to create an order
        // Add entry into backend database (systems)
        System.out.println("Order created for product - " + product + " with quantity - " + quantity + " and customer info - " + customerInfo);
    }
}
```

```java
interface PaymentService {
    boolean processPayment(double amount, String creditCardDetails);
}

class PaymentServiceImpl implements PaymentService{
    @Override
    public boolean processPayment(double amount, String creditCardDetails) {
        System.out.println("Payment processed for amount " + amount + " using credit card " + creditCardDetails);
        return true;
    }
}
```

```java
interface NotificationService {
    void sendOrderConfirmation(String orderNumber);
    void sendOrderShipped(String orderNumber);
    void sendOrderDelivered(String orderNumber);
    void sendOrderCancelation(String orderNumber);
}

class NotificationServiceImpl implements NotificationService{
    @Override
    public void sendOrderConfirmation(String orderNumber) {
        // Inform shipping department or shipping provider to ship the product
        System.out.println("Your order has been placed for order number: " + orderNumber);
    }

    @Override
    public void sendOrderShipped(String orderNumber) {
        System.out.println("Order shipped for order number " + orderNumber);
    }

    @Override
    public void sendOrderDelivered(String orderNumber) {
        System.out.println("Order delivered for order number " + orderNumber);
    }

    @Override
    public void sendOrderCancelation(String orderNumber) {
        System.out.println("Order cancellation sent for order number " + orderNumber);
    }
}
```

```java
interface ShippingService {
    void shipOrder(String productId, String shippingAddress);
}

class ShippingServiceImpl implements ShippingService {
    @Override
    public void shipOrder(String productId, String shippingAddress) {
        System.out.println("Shipping product " + productId + " to address: " + shippingAddress);
    }
}
```

For this example, we have five services which will be used when a user places an order. This is relatively simple design. In practice, it will be lot more complicated. We can create `OrdersFacade` which will coordinate with these classes to place an order.

```java
public class OrdersFacade {
    private OrderProcessingService orderProcessingService;
    private NotificationService notificationService;
    private PaymentService paymentService;
    private ShippingService shippingService;
    private InventoryService inventoryService;

    public OrdersFacade() {
        this.orderProcessingService = new OrderProcessingServiceImpl();
        this.notificationService = new NotificationServiceImpl();
        this.paymentService = new PaymentServiceImpl();
        this.shippingService = new ShippingServiceImpl();
        this.inventoryService = new InventoryServiceImpl();
    }

    public void placeOrder(String productId, int quantity, String customerInfo, String shippingAddress, String creditCardDetails) {
        String orderId = "1234";
        if (!inventoryService.isAvailable(productId, quantity)) {
            notificationService.sendOrderCancelation(orderId);
            return;
        }
        orderProcessingService.createOrder(productId, quantity, customerInfo);
        if (paymentService.processPayment(100.0, creditCardDetails)) {
            notificationService.sendOrderConfirmation("1234");
            shippingService.shipOrder(productId, shippingAddress);
        } else {
            notificationService.sendOrderCancelation("1234");
        }
    }
}
```

The client will need to only call `OrdersFacade` object with `placeOrder()` method.

```java
public class Client {
    public static void main(String[] args) {
        OrdersFacade ordersFacade = new OrdersFacade();
        ordersFacade.placeOrder("B", 10, "John Doe", "1 Master St, San Jose, CA, United States", "1234-5678-4321-8765");
    }
}
```

### Advantages:
- This patten helps reduce the complexity of the system and is great for refactoring.
- It enables client code to become loosely coupled with the complex system by providing middle layer which can easily be modified when third party implementation changes.
- Facade makes code more readable by providing simple function which will have descriptive names to understand what facade is doing.

### Disadvantages:
- It can add additional layer of code.
- Adds little performance overhead due to additional facade middle layer

## Summary
- This pattern hides the complex details of the system for the client.
- This is very easy to implement as there are no constraints on how to implement it.
- We can also create facade classes which further hides another facade complexity.
- It is also considered one of the refactoring pattern as it's commonly applied during refactor process.