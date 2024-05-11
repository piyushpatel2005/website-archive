---
title: "Flyweight Pattern"
date: 2024-04-06T14:11:44-04:00
draft: false
---

Flyweight is a structural design pattern which tries to optimize the memory usage by decreasing the creation of duplicate objects. It enables us to share common state between multiple instances such that each new object do not need a new state of a member variable. This tutorial explains flyweight design pattern using Java code examples.

<!--more-->

## What is Flyweight Design Pattern?

When we have to create multiple objects of similar type which have only few fields which are different from other objects, we can share the same object properties across different instances and create only the differing properties. This way we reduce the memory requirement of the objects and thus the system. The shared data is called instrinsic data or state. Usually, this instrinsic data is immutable and hence can be shared across multiple objects. The unique data across each object is called the extrinsic data and this can be modified and is mutable. For example, when we have an ecommerce platform, we could have multiple objects of the same product. We could definitely create a new instance of each product, but it would be rather simple if we could use the product of same type to share their data. In order to achieve this, usually we will have some kind of cache mechanism which holds these product data and we will have a factory method which will provide a specific type of product intrinsic data.

This pattern is very common in gaming industry where we can have different types of enemies or coins. All those coins have same properties like their value and they all can share the instrinsic state using this flyweight pattern. 

In Java standard library, `String` class implements Flyweight pattern using string pool. It creates new string instance only when it's different from the existing ones else there is a shared pool. Similarly, `Integer.valueOf()` method also caches values of integers. So, if we request same value, we will get exactly same object which can be verified by checking their identity. This pattern is useful when you have large number of similar objects with a small number of unique data members.

## How to implement Flyweight Pattern?

The Flyweight pattern consist of following main components.
- Flyweight: It is the core class that contains the shared state. Usually, this class should be immutable such that no instance can modify the shared state.
- Intrinsic State: This is the common shared data stored in Flyweight object. This is shared across multiple objects.
- Extrinsic State: These are member variables which are not shared across multiple instances. Each object has their own extrinsic state.

1. Create a common `Flyweight` object with intrinsic data.
2. We have to store the intrinsic state somewhere. We can store them in some form of container.
3. To retrieve intrinsic data, we need a mechanism to retrieve it. The easiest and manageable option is to create a factory for this. So, create a factory class which will provide a convenient method to retrieve intrinsic data.
4. Now, client can use factory to retrieve objects. Factory has a mechanism to check if it has a common intrinsic data and it will return that else it will store intrinsic data and return the new instance of the object. This new instance will be used next time a similar object is requested from the factory.

```java
public interface Product {
    String getName();
    double getPrice();
}
```

```java
public class Book implements Product {
    private static int count = 0;
    private final String title;
    private final String author;
    private final double price;

    public Book(String name, String author, double price) {
        this.title = name;
        this.author = author;
        this.price = price;
        count++;
    }

    @Override
    public String getTitle() {
        return title;
    }

    @Override
    public double getPrice() {
        return price;
    }

    public String getAuthor() {
        return author;
    }

    public static int getCount() {
        return count;
    }
}
```

Here `Book` is the object which has many similar instances with same `title`, `author` and `price`. In order to store intrinsic state, we can have a `ProductFactory` which will provide us the instance of the `Product` when we ask for `Product` with a given name, author and price. If it's not available in cache, it will create one store it in the cache and return it.

```java
public class ProductFactory {
    private Map<String, Product> products;

    public ProductFactory() {
        products = new HashMap<>();
    }

    public Product createProduct(String name, String author, double price) {
        return products.computeIfAbsent(name, k -> new Book(k, author, price));
    }

    public int getProductsSize() {
        return products.size();
    }

    public Product getProduct(String name, String author, double price) {
        Product product = products.get(name);
        if (product == null) {
            product = createProduct(name, author, price);
            products.put(name, product);
        }
        return product;
    }
}
```

Next, we want to implement shopping cart, so we have `CartItem` class which is one line of the cart. It includes information about the product as well as number of quantities being order for a given product.

```java
public class CartItem {
    private Product product;
    private int quantity;

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public int getQuantity() {
        return quantity;
    }
}
```

We have shopping cart which actually includes all `CartItem`s being ordered in current order.

```java
public class ShoppingCart {
    private List<CartItem> items;
    ProductFactory productFactory = new ProductFactory();

    public ShoppingCart() {
        this.items = new ArrayList<>();
    }

    public double calculateTotal() {
        return items.stream()
                .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();
    }

    public void addItem(String title, String author, double price, int quantity) {
        Product product = productFactory.getProduct(title, author, price);
        items.add(new CartItem(product, quantity));
    }

    public List<CartItem> getItems() {
        return items;
    }
}
```

The client can now interact with the shopping cart object. Even though our shopping cart has 23 total items, the number `Product` instances created are just 4 because we have shared the common state across all objects and there are only 4 unique `Book` instances being ordered. 

```java
public class ClientMain {
    public static void main(String[] args) {
        ShoppingCart cart = new ShoppingCart();
        cart.addItem("Lord of the Rings", "J.R.R. Tolkien", 49.99, 1);
        cart.addItem("Design Patterns", "Erich Gamma", 54.99, 2);
        cart.addItem("Design Patterns", "Erich Gamma", 54.99, 2);
        cart.addItem("Clean Code", "Robert C. Martin", 43.99, 3);
        cart.addItem("Clean Code", "Robert C. Martin", 43.99, 3);
        cart.addItem("Effective Java", "Joshua Bloch", 47.99, 4);
        cart.addItem("Effective Java", "Joshua Bloch", 47.99, 4);
        cart.addItem("Effective Java", "Joshua Bloch", 47.99, 4);

        System.out.println("Total: " + cart.calculateTotal());
        System.out.println("Number of instances: " + Book.getCount());
        System.out.println("Number of items in the cart: " + cart.getItems().size());
        System.out.println("Number of products in the factory: " + cart.getItems().stream()
                .map(item -> item.getQuantity())
                .reduce(0, Integer::sum));
    }
}
```

## Practical Code Examples


### Advantages:
- It optimizes memory usage by reducing the number of data members needed across objects.
- It helps simplify code because we do not need to create and manage numerous similar objects.
- It is useful when the cost of object creation is very high and they share similar data members across different instances.

### Disadvantages:
- It can be difficult to implement
- It can be difficult to know when this pattern might be useful

## Summary
- This is great pattern when we have large number of objects with similar data. We can share same data across different objects and reduce memory requirements.
- This pattern can be little bit harder to implement.
- This pattern is widely used by core API and other third party libraries as it helps optimize the performance by reducing memory footprint.