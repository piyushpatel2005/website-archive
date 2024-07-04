---
title: "Visitor Pattern"
date: 2024-04-29T20:07:58-04:00
draft: false
---

Visitor is a behavioral pattern used to separate algorithm from the objects on which it operates. This tutorial explains visitor patten with Java examples.

<!--more-->

## What is Visitor Pattern?

Imagine you have a bunch of shapes, like circles and squares. You want to perform different actions on them, like `calculateArea`, `calculatePerimeter` or `draw` them on the screen.

Normally, you'd add this logic directly to the shapes themselves. But what if you later want to add a new action, like counting the number of sides? You'd have to modify all the shapes again.

The visitor pattern offers a better solution. The visitor pattern recommends we create a separate class called **Visitor**. This visitor acts like a specialist that can visit different shapes.
Each shape has a method to `accept` a visitor.

The visitor has different methods for each type of shape (`Circle`, `Square`, etc.). Now, when you want to perform an action on a shape, you create a visitor with that specific action and "visit" all the shapes with it. This way, you can add new actions (visitors) without changing the shapes themselves.

This pattern is useful when you want to separate algorithm for specific function from the object structure. For example, drawing is not the functionality of core shape. It's polluting `Shape` object by adding how it should draw itself. So, it's useful to clean up auxiliary behaviors. This pattern can be used when you expect lot of changes and new features being added down the line. This pattern can be useful when you want to perform an operation on all elements in a collection type structure. This pattern can also be used when a method makes sense only in some classes from a hierarchy, but not in others. In such situation, we can extract this behavior into a separate visitor class and implement only those visiting methods that accept objects of relevant classes and leave other methods empty.

## How to implement Visitor Pattern?

The visitor pattern consists of following actors:
- Visitor: The `Visitor` interface declares a set of methods to visit concrete elements of an object as argument. Each concrete Visitor implements these methods for different concrete `Element` classes. In our example, we have `AreaVisitor` and `PerimeterVisitor` as concrete visitors.
- Element: It is an interface which declares a method to `accept` visitors. This method accepts a visitor using interface rather than concrete visitor type. Each concrete `Element` will implement the `accept` method. In example, we have `Square` and `Circle` as `Element` concrete classes.
- The Client may have a collection of elements. The client works with `Element` interface rather than concrete type.

## Practical Code - Shapes with different Functionalities

1. First declare the interface for the `Visitor` based on which `Element` types you want to support.

```java
public interface ShapeVisitor {
    void visit(Square square);

    void visit(Circle circle);
}
```

2. Define `Element` interface with single method which accepts a visitor using its interface. Notice that `accept` method is using only `ShapeVisitor` and no concrete `ShapeVisitor`

```java
public interface Shape {
    void accept(ShapeVisitor visitor);
}
```

3. Define concrete `Element` types. In this case, define concrete `Shape` subclasses. Each subclasses implement `accept` method for `ShapeVisitor`.

    a. In this case, I have `Circle`. 

    ```java
    public class Circle implements Shape {
        private double radius;

        public Circle(double radius) {
            this.radius = radius;
        }

        public double getRadius() {
            return radius;
        }

        @Override
        public void accept(ShapeVisitor visitor) {
            visitor.visit(this);
        }
    }
    ```

    b. Create another child class of `Shape` depending on how many shapes you want to support.

    ```java
    public class Square implements Shape {
        private double side;

        public Square(double side) {
            this.side = side;
        }

        public double getSide() {
            return side;
        }

        @Override
        public void accept(ShapeVisitor visitor) {
            visitor.visit(this);
        }
    }
    ```

4. Implement different `Visitor` concrete classes. In this case, I have `AreaVisitor` to calculate area of a shape, `PerimeterVisitor` to calculate perimeter of a shape and `DrawVisitor` to draw any shape.

    a. `AreaVisitor` having logic to calculate area of a given shape.

    ```java
    public class AreaVisitor implements ShapeVisitor {
        @Override
        public void visit(Square square) {
            double area = square.getSide() * square.getSide();
            System.out.println("Area of Square: " + area);
        }

        @Override
        public void visit(Circle circle) {
            double area = Math.PI * circle.getRadius() * circle.getRadius();
            System.out.println("Area of Circle: " + area);
        }
    }
    ```

    b. `PerimeterVisitor` to calculate perimeter of a shape.

    ```java
    public class PerimeterVisitor implements ShapeVisitor {
        @Override
        public void visit(Square square) {
            double perimeter = 4 * square.getSide();
            System.out.println("Perimeter of Square: " + perimeter);
        }

        @Override
        public void visit(Circle circle) {
            double perimeter = 2 * Math.PI * circle.getRadius();
            System.out.println("Perimeter of Circle: " + perimeter);
        }
    }
    ```

    c. `DrawVisitor` to draw a shape.

    ```java
    public class DrawVisitor implements ShapeVisitor {
        @Override
        public void visit(Square square) {
            System.out.println("Drawing square of side: " + square.getSide());
        }

        @Override
        public void visit(Circle circle) {
            System.out.println("Drawing cirlce with radius: " + circle.getRadius());
        }
    }
    ```

5. Finally, the client can easily work with collection of shapes or even single `Shape`.

```java
public class ClientMain {
    public static void main(String[] args) {
        Square square1 = new Square(5);

        // Use AreaVisitor
        ShapeVisitor areaVisitor = new AreaVisitor();
        square1.accept(areaVisitor);

        // Use DrawVisitor
        ShapeVisitor drawVisitor = new DrawVisitor();
        square1.accept(drawVisitor);

        System.out.println("==================");
        Square square2 = new Square(4);
        Circle circle = new Circle(3.5);

        List<Shape> shapes = Arrays.asList(square1, circle, square2);
        for (Shape shape: shapes) {
            shape.accept(drawVisitor);
        }

    }
}
```

### Advantages:
- Visitor pattern follows Open/Closed principle allowing easier extension.
- This pattern also makes code flexible using Single Responsibility principle. Each class single responsibility in this case.

### Drawbacks:
- Each time a new `Element` is added or removed, you'll have to modify all visitors.
- The indirection of `Element` using `Visitor` and vice a versa can be confusing to understand.
- Each visitor may sometimes need access to private fields of `Element` which may require creating public methods for those fields and exposing them.

### Comparison with Iterator Pattern

| Visitor Pattern                                       | Iterator Pattern                                          |
|:------------------------------------------------------|:----------------------------------------------------------|
| This is designed using interfaces.                    | This is also interface based but may use anonymous class. |
| focuses on externalizing behavior                     | This encapsulates navigation but does not externalize it. |
| Useful when you have multiple visitors.               | Usually single iterator in an application.                |

## Summary
- Visitor pattern is good for externalizing some behavior which does not make sense in the original `Element` class. Thus promoting single responsibility.
- It is useful when you are expecting changes in the application but can be sometimes difficult to know upfront.
- It can add little complexity in code.
- It can require changes in visitors whenever new element is added or removed.