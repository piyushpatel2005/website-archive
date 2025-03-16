---
title: "Bridge Pattern"
date: 2024-03-27T17:35:44-04:00
draft: false
---

Bridge design pattern is a structural pattern which allows you to split complex large class or multiple related classes into two hierarchies. These two hierarchies are usually abstraction and implementation which are decoupled from each other.

<!--more-->

## What is Bridge Pattern?

Bridge pattern basically allows you to separate implementation of a class without affecting the client code that uses it. It decouples abstraction from its implementation. It looks similar to adapter pattern but the intent of the pattern is to decouple two separate hierarchies of classes.

Let's say we have `Shape` interface which defines simple methods like `draw()`. We can create multiple subclasses like `Circle`, `Triangle`, `Square` to create concrete shapes. Now, if we want to draw shapes of different colors, we can define a method like `color()` and we can apply different colors to our shapes. The problem is if we need different color shapes, we will have to define separate subclass for each of those. For example, we might inherit `RedCircle`, `PurpleCircle` and `BlueCircle` from `Circle` class. As we add more colors, we might need more subclasses. In fact, the subclasses grow exponentially with each shape and color combinations.

The problem is because there are two dimensions in which we are trying to extend our `Shape` interface. We are extending in terms of color and their shape. The Bridge design pattern solves this by using composition over inheritance. This way we will have `Color` field in each concrete `Shape` class which specifies what color to apply and we delegate the task of applying color to this member variable.

Bridge pattern is useful when you want to divide a large monolithic class with several different variants of functionalities into their own hierarchies.

In Java, `Driver` class behaves like a bridge with `DriverManager`. `java.sql.Driver` interface dfeines a set of methods for interacting with databases like `connect(String url, Properties props)` and database specific implementation like `com.mysql.cj.jdbc.Driver` and `oracle.jdbc.driver.OracleDriver` implement these methods. `java.sql.DriverManager` serves as a mediator between client code and database drivers even though it doesn't completely encapsulate implementation details.

## How to implement Bridge Design Pattern?

In this example, we are going to take example of having `Laptop` and `CellPhone` devices with different operating systems like `Linux`, `Windows` and `iOS`. If we try to implement this hierarchy as a inheritance, we can have `Device` as top level interface and then two subclasses for `Laptop` and `CellPhone`. This will further be subclassed into `WindowsLaptop`, `LinuxLaptop` and `MacLaptop`. If we add one more device, we will need to create three new subclasses or if we add one more OS, we will need two subclasses for each device. This is going to get too big very quickly.

To solve this we can create two hierarchy: One for `OperatingSystem` and another for `Device`. The `Device` should have `protected` reference to `OperatingSystem` which means each concrete classes have to have OS defined in them for it to work.

1. First we have to find out different dimensions which need to be separated into two class hierarchies.
2. Create `interface` for the implementation (`OperatingSystem`) and create abstract class (`Device`) for abstraction. This abstract class should include `protected` reference to the interface we created.
3. Implement this interface for the type of operating systems we need `Linux`, `Windows`, etc.
4. Create subclasses for `Device` like `Laptop`, `CellPhone`. Each of them will need reference to `OperatingSystem`.

**Example: Operating System hierarchy**

The `OperatingSystem` interface defines the basic functionalities of operating system.

```java
public interface OperatingSystem {
    void shutdown();
    void reboot();
    void installOS();
    void displayInfo();
}
```

The concrete implementation of operating system provide the specific implementation for these behaviors.

```java
public class Linux implements OperatingSystem {
    @Override
    public void shutdown() {
        System.out.println("Shutting down Linux");
    }

    @Override
    public void reboot() {
        System.out.println("Rebooting Linux");
    }

    @Override
    public void installOS() {
        System.out.println("Installing Linux");
    }

    @Override
    public void displayInfo() {
        System.out.println("Linux OS");
    }

    @Override
    public String toString() {
        return "Linux Operating System";
    }
}
```

```java
public class Windows implements OperatingSystem {
    @Override
    public void shutdown() {
        System.out.println("Shutting down Windows");
    }

    @Override
    public void reboot() {
        System.out.println("Rebooting Windows");
    }

    @Override
    public void installOS() {
        System.out.println("Installing Windows");
    }

    @Override
    public void displayInfo() {
        System.out.println("Windows OS");
    }

    @Override
    public String toString() {
        return "Windows Operating System";
    }
}
```

**Example: Device hierarchy**

The `Device` is an abstract class that holds `protected` reference to `OperatingSystem` so that each concrete implementation will have to have OS.

```java
public abstract class Device {
    protected OperatingSystem os;

    public Device(OperatingSystem os) {
        this.os = os;
    }

    public void shutdown() {
        os.shutdown();
    }

    public void reboot() {
        os.reboot();
    }

    public void installOS() {
        os.installOS();
    }

    public void displayInfo() {
        os.displayInfo();
    }

    public abstract void displayDevice();

    public void setOs(OperatingSystem os) {
        this.os = os;
    }

    public OperatingSystem getOs() {
        return os;
    }

    @Override
    public String toString() {
        return "Device with " + os.toString();
    }
}
```

Concrete `Device` implementation will extend `Device` and have reference to `OperatingSystem`. They can also have additional methods.

```java
public class CellPhone extends Device {
    public CellPhone(OperatingSystem os) {
        super(os);
    }

    @Override
    public void displayDevice() {
        System.out.println("Cell Phone");
    }

    @Override
    public String toString() {
        return "Cell Phone " + super.toString();
    }
}
```


```java
public class Laptop extends Device {
    public Laptop(OperatingSystem os) {
        super(os);
    }

    @Override
    public void displayDevice() {
        System.out.println("Laptop");
    }

    @Override
    public String toString() {
        return "Laptop " + super.toString();
    }
}
```

With these structure, we can independently add new OS or new device. Every time we add new device, we just have to add one subclass of `Device`  and every time we add new OS, we have to only implement one class with `OperatingSystem` interface. They are decoupled from each other and it is more maintainable.

Now, client code can easily create different kinds of devices and OS combinations. It is client's responsibility to provide correct implementation for the abstraction object.

```java
public class DeviceClient {
    public static void main(String[] args) {
        Device cellPhone = new CellPhone(new Windows());
        cellPhone.installOS();
        cellPhone.reboot();
        cellPhone.displayDevice();
        cellPhone.shutdown();

        System.out.println("=====================================");

        Device laptop = new Laptop(new Linux());
        System.out.println(laptop);
    }
}
```

### Advantages:

- This pattern improves decoupling by separating the abstraction from the implementation. Both of those can be developed further independent of each other.
- This improves maintainability and extensibility as new implementations can be added easily without modifying abstraction.
- This improves code reusability as we do not have to recreate methods defined in implementations. We can simply delegate the work to those from abstraction layer.

### Disadvantages:

- It may be difficult to plan upfront and can be somewhat confusing at first to decide what goes where.

### Comparison with Adapter Pattern

| Adapter Pattern                           | Bridge Pattern                                |
|:------------------------------------------|:----------------------------------------------|
| useful for legacy code or third party code| useful for upfront design decisions           |
| This is retrofitten in existing code      | This is built in advance                      |
| provides different interface for non-compatible legacy code | provides same abstraction   |
| simpler than bridge                       | little more complex to implement              |

## Summary

- The bridge pattern can be used to separate two separate dimensions into two hierarchies.
- This pattern provides lot more flexiblity for code reuse and maintenance.
- It uses composition over inheritance.