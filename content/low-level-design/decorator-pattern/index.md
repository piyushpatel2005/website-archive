---
title: "Decorator Pattern"
date: 2024-03-31T16:33:17-04:00
draft: false
---

Decorator pattern is a structural pattern which adds new functionality to an existing object without modifying its original structure. This tutorial explains decorator pattern with practical examples in Java code.

<!--more-->

## What is Decorator Pattern?

Decorator pattern is used to dynamically add behavior to existing objects. It's like wrapping a gift item into multiple boxes and/or decorative ribbons without changing the gift itself. The main feature of this pattern is that it does not change the original object. For example, if you had a `Car` and you wanted to add several different features such as car with hybrid engine or car with gas engine or may be a flying car? We can add those features by extending the original `Car` class but then we might need `HybridCar` with manual gears or `HybridCar` with automatic gears. So, if we try to create these using subclasses, we might have to create so many subclasses for each simple variation. Also, this kind of inheritance structure is very inflexible. Each subclass can have only one parent as most languages do not support multiple inheritance.

It is better to use composition to handle these scenarios. With composition, we can delegate the work to another object reference. With composition, an object can use various behavior of different classes by using their objects and delegating them all kinds of work. We can wrap the original object in different kinds of wrapper to alter its behavior. That's why this pattern is also called **wrapper pattern**. A *wrapper* is an object that can be connected with some other *target* object. It has same set of methods as the target object, however, wrapper may also alter the result by doing something before or after it passes the client request to the target object. This pattern uses both inheritance and composition.

This pattern is useful when it's awkward or impossible to extend an object's behavior using inheritance. For example, if the superclass has defined class with `final` keyword, it cannot be extended to add new functionalities. In this case, the only way to extend the behavior would be to wrap this object in another object using decorator pattern.

## How to implement Decorator Pattern?

Let's say we want to implement PaintApp. That app can draw different shapes. Now, on top of drawing these shapes, we can apply different visual efffects like borders or fill the shape with different colors. We can apply these extra effects using Decorator pattern.

We have a `Shape` interface which defines the `draw()` method.

```java
public interface Shape {
    void draw();
}
```

We also have concrete implementation of this `Shape` interface which have their own drawing logic.

```java
public class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a circle");
    }
}
```

We can have more than one shape implementing this common interface.

```java
public class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a square");
    }
}
```

Let's say we want to have shapes with colors and shapes with borders or which are filled with different number of dots. In this case, we can define a `ShapeDecorator` abstract class. This class will have an instance of `Shape` which can be extended with different concrete `ShapeDecorator`s. Notice that it contains `Shape` instance and delegates the `draw()` method to respective decorator which can add additional functionality.

```java
public abstract class ShapeDecorator implements Shape {
    private Shape decoaratedShape;

    public ShapeDecorator(Shape decoratedShape) {
        this.decoaratedShape = decoratedShape;
    }

    @Override
    public void draw() {
        decoaratedShape.draw();
    }
}
```

Now, we have conrete `ShapeDecorator` which can fill color into any shape.

```java
public class ColorShapeDecorator extends ShapeDecorator {
    private final String color;

    public ColorShapeDecorator(Shape decoratedShape, String color) {
        super(decoratedShape);
        this.color = color;
    }

    @Override
    public void draw() {
        super.draw();
        System.out.println(" with Color: " + color);
    }
}
```

We can also have decorator which can create dots inside the shape of different colors.

```java
public class DottedShapeDecorator extends ShapeDecorator {
    private final int dots;
    private final String dotColor;

    public DottedShapeDecorator(Shape decoratedShape, int dots, String dotColor) {
        super(decoratedShape);
        this.dots = dots;
        this.dotColor = dotColor;
    }

    @Override
    public void draw() {
        super.draw();
        System.out.println(" with " + dotColor + " colored " + dots + " dots");
    }
}
```

With these constructs, we can create shape with different color and dots.

```java
public class Main {
    public static void main(String[] args) {
        Shape circle = new Circle();

        Shape blueCircle = new ColorShapeDecorator(circle, "blue");
        blueCircle.draw();

        Shape dottedBlueCircle = new DottedShapeDecorator(blueCircle, 100, "red");
        dottedBlueCircle.draw();
    }
}
```

This pattern consists of following main parts.

- Component: It is the common interface for both wrapped object and wrapper object. It is actually the object which needs different variants. In example above, `Shape` is a component.
- Concrete Components: These are concrete instances which can be used. In our case, `Circle` and `Square`.
- Base Decorator: This is base decorator which has instance of the component. It is `ShapeDecorator` in above example. The base decorator delegates operations to the wrapped object.
- Concrete Decorators: These are actual decorators which add some new functionality. They override methods of the base decorator.

1. We already have Component and Concrete Comopnents and we want to extend it by adding new behavior
2. Define the base decorator with commom methods. It should have a reference to the wrapped object.
3. Create concrete decorators based on the new functionalities needed.

### Example: Sandwich Decorator

```java
public interface Sandwich {
    public String getDescription();
    public double getPrice();
}
```

```java
public class SimpleCheeseSandwich implements Sandwich {
    @Override
    public String getDescription() {
        return "Simple Sandwich";
    }

    @Override
    public double getPrice() {
        return 2.49;
    }
}
```

Base decorator for Sandwich

```java
public abstract class SandwichDecorator implements Sandwich {
    private Sandwich sandwich;

    public SandwichDecorator(Sandwich sandwich) {
        this.sandwich = sandwich;
    }

    @Override
    public String getDescription() {
        return sandwich.getDescription() + " with " + getExtraItem();
    }

    @Override
    public double getPrice() {
        return sandwich.getPrice() + getExtraItemPrice();
    }

    public abstract String getExtraItem();
    public abstract double getExtraItemPrice();
}
```

```java
public class ExtraCheeseDecorator extends SandwichDecorator {
    public ExtraCheeseDecorator(Sandwich sandwich) {
        super(sandwich);
    }

    @Override
    public String getExtraItem() {
        return ", Double Cheese ";
    }

    @Override
    public double getExtraItemPrice() {
        return 1.0d;
    }
}
```

```java
public class VegetableDecorator extends SandwichDecorator {
    private final String vegetableName;
    private final double price;

    public VegetableDecorator(Sandwich sandwich, String vegetableName, double price) {
        super(sandwich);
        this.vegetableName = vegetableName;
        this.price = price;
    }

    public String getVegetableName() {
        return vegetableName;
    }

    public double getVegetablePrice() {
        return price;
    }

    @Override
    public String getExtraItem() {
        return ", " + getVegetableName();
    }

    @Override
    public double getExtraItemPrice() {
        return getVegetablePrice();
    }
}
```

```java
public class MeatDecorator extends SandwichDecorator {
    public MeatDecorator(Sandwich sandwich) {
        super(sandwich);
    }

    @Override
    public String getExtraItem() {
        return ", Meat ";
    }

    @Override
    public double getExtraItemPrice() {
        return 1.99;
    }
}
```

```java
public class Client {
    public static void main(String[] args) {
        Sandwich sandwich = new SimpleCheeseSandwich();
        System.out.println(sandwich.getDescription() + " costs $" + sandwich.getPrice());

        sandwich = new ExtraCheeseDecorator(sandwich);
        System.out.println(sandwich.getDescription() + " costs $" + sandwich.getPrice());

        sandwich = new VegetableDecorator(sandwich, "tomato", 0.99);
        System.out.println(sandwich.getDescription() + " costs $" + sandwich.getPrice());

        sandwich = new VegetableDecorator(sandwich, "lettuce", 0.49);
        System.out.println(sandwich.getDescription() + " costs $" + sandwich.getPrice());
    }
}
```

### Advantages:

- This allows you to add extra functionalities to objects at runtime, making the code more flexible.
- This pattern does not alter the original object. The datatype is still the same with core functionalities.
- It allows you to add new functionalities using decoarators without modifying the existing class. Thus, following Open/Closed Principle.
- Each decorator follows Single Responsibility principle promoting clean maintainable code.

### Disadvantages:

- Decorators cannot modify the original wrapped object. So, it has limited control over it.
- It can result in performance overhead as we have to create and manage many decorator objects.

## Summary

- This pattern is useful when we want to add simple functionalities to original object.
- It does not alter the original object.
- It uses both inheritance and composition.