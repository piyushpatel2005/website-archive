---
title: "Chain of Responsibility Pattern"
date: 2024-04-15T09:50:08-04:00
draft: false
---

Chain of Responsibility is a behavioral design pattern which allows you to pass requests along a chain of objects. Each of these objects can either be able to handle the request or pass it along the chain until it gets handled.

<!--more-->

## What is Chain of Responsibility Pattern?

This is a design pattern where we can have several layers of hierarchy to handle user requests. It allows multiple entries to handle requests. For example, if we want to create a hierarchy of responsibility, we can use this pattern to build such hierarchy where the lower level executives can handle low priority requests and upper level can handle higher value or higher priority requests. The customer service is a great example of this system. When a customer needs to cancel a request or get a refund for their orders, they may go through such chain. If the order is relatively recent and the order amount is not high, the customer service representive could be able to cancel or refund the order. If there are disputes or the amount of order value is large, it may have to go through other hierarchy such as manager or finance department in order to approve the refunds.

This pattern is useful when we want to execute several handlers in a particular order. This also allows to set handlers at runtime. It's a great pattern for decoupling the sender and receiver. The client does not need to know who actually handled the request.

## How to implement Chain of Responsibility?

This pattern mainly consists of following components:
- Abstract Handler: This is an interface or abstract class which defines two methods. The `setSuccessor()` method defines the next `successor` who can handle client requests if this handler is unable to handle it. Another method `handle(request)` is implemented by concrete handlers based on request information. We can define `setSuccessor()` in this abstract class itself unless we need to handle different kind of logic in which case, we can override the behavior of this method in concrete handlers.
- Concrete Handler: These are actual handlers of the requests. They are of the type `Handler` such that each handler can look and behave like other handlers. These handlers extend abstract handler and implement actual logic for how to handle the incoming request.
- Client: The client code can compose chain in the code or application logic. The request will pass through chain of objects. The first handler does not necessarily have to handle the request. It can simply pass the request to next handler.

## Practical Example - Order Refunds/Cancellation

1. Create abstract handler with two methods. One `abstract` method to handle incoming requests and another to set the next successor. In below code, `handleRequest(request)` is used to handle the requests and `nextSuccessor(successor)` is used to set the next successor. Notice that, the second method is implemented in abstract handler, but it could be overridden.

```java
public abstract class Handler {

    protected Handler successor;

    public void nextHandler(Handler successor) {
        this.successor = successor;
    }

    public abstract void handleRequest(Request request);
}
```

2. Define `Request` objects that we want to handle. This code is for handling only two types of requests: cancellation and refund of orders.

```java
public enum RequestType {
    CANCELLATION, REFUND;
}
```

```java
public class Request {

    private RequestType requestType;
    private double amount;

    public Request(RequestType requestType, double amount) {
        this.requestType = requestType;
        this.amount = amount;
    }

    public RequestType getRequestType() {
        return requestType;
    }

    public double getAmount() {
        return amount;
    }
}
```

2. Create concrete handlers which extend the `Handler` and implement custom logic for handling requests. In this case, I have three concrete handlers to handle customer refund or cancellation requests.

```java
public class CustomerServiceExecutive extends Handler {
    @Override
    public void handleRequest(Request request) {
        if(
                (request.getRequestType() == RequestType.CANCELLATION && request.getAmount() <= 1000) ||
                (request.getRequestType() == RequestType.REFUND && request.getAmount() <= 500)
        ) {
            System.out.printf("Customer service executive has approved this request for amount $%.2f.\n", request.getAmount());
        } else {
            System.out.println("Customer service executive has escalated this request to supervisor.");
            successor.handleRequest(request);
        }
    }
}
```

Notice that `CustomerServiceExecutive` the `handleRequest()` can handle refund requests upto $500 and cancellation requests upto $1000. For other requests, it will pass the request to its successor which in this case will be `Supervisor`

```java
public class Supervisor extends Handler {

    @Override
    public void handleRequest(Request request) {
        if(
                (request.getRequestType() == RequestType.CANCELLATION && request.getAmount() <= 5000) ||
                        (request.getRequestType() == RequestType.REFUND && request.getAmount() <= 2000)
        ) {
            System.out.printf("Supervisor executive has approved this request for amount $%.2f.\n", request.getAmount());
        } else {
            System.out.println("Supervisor has escalated this request to manager.");
            successor.handleRequest(request);
        }
    }
}
```

Again, `Supervisor` can handle requests upto certain value and if the request is for larger amount, it will pass the request to its successor `Manager`.


```java
public class Manager extends Handler {
    @Override
    public void handleRequest(Request request) {
        if (request.getAmount() <= 10000) {
            System.out.println("Manager has approved this request.");
        } else {
            System.out.println("Manager can only provide credits upto 10000. Please file a complaint and billing department will get back to you.");
        }
    }
}
```

If `Manager` cannot handle the request, it will need to be escalated to billing department and they will investigate on this and revert back with resolution to the customer.

The client code of this pattern might look something like this.

```java
public class Main {
    public static void main(String[] args) {
        CustomerServiceExecutive customerServiceExecutive = new CustomerServiceExecutive();
        Supervisor supervisor = new Supervisor();
        Manager manager = new Manager();

        customerServiceExecutive.nextHandler(supervisor);
        supervisor.nextHandler(manager);

        customerServiceExecutive.handleRequest(new Request(RequestType.CANCELLATION, 1000));
        customerServiceExecutive.handleRequest(new Request(RequestType.CANCELLATION, 5001));
    }
}
```

### Advantages:
- This promotes loose coupling between sender and receiver of the requests.
- When we want to handle requests differently, we can set the hierarchy of handlers at runtime using configuration or factory classes.
- You can add new handlers easily in the hierarchy without affecting other handler code or tests. This follows Open/Closed principle

### Disadvantages:

- Some requests may not have any defined handlers and go unhandled.
- If the chain length is too big, it may result in performance overheads.

### Comparison with Command Pattern

| Chain of Responsibility Pattern                   | Command Pattern                                   |
|:--------------------------------------------------|:--------------------------------------------------|
| deals with user requests using handlers           | commands are also unique                          |
| This is used to create hierarchy of handlers      | This is used to encapsulate requests              |
| The order is defined at runtime, but not reversible once executed. | Commands on the other hand, are reversible |

## Summary

- CoR is a great pattern for decoupling sender and receiver.
- It helps provide runtime configurations for setting different handlers.
- Chain of responsibility can help set up hierarchical nature of handlers in your design.
- Large chains should be avoided and there is no guarantee that all requests will be handled.