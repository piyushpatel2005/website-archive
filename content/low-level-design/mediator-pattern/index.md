---
title: "Mediator Pattern"
date: 2024-04-28T19:12:46-04:00
draft: false
---

Mediator is a behavioral design pattern which is used to define how objects interact with one another without explicitly referring them. It promotes loose coupling between objects by introducing a mediator object that acts as an intermediary for communication between them.

<!--more-->

## What is Mediator Design Pattern?
In this pattern, a central object coordinates the activities of many other objects.

Mediator discourages direct communication between two objects because it leads to tight coupling. Instead, it promotes having a mediator which faciliates communication between these two objects. For example, in a library, each account holder do not communicate and pass books to each other. That would become very difficult. Instead, each library account holder communicates through librarian who act as a mediator. The same thing happens in business as well. If a team needs help with something, they communicate the requirement to manager and the manager passes the request to individual developer. If there was no manager acting as a mediator, it will be chaotic and developer would be swamped by requests from multiple different teams. 

This pattern is useful when you need to decouple two objects. This improves maintainability and reuse of those classes. This is used where a well-defined objects need to collaborate in a complex way. This acts as a hub router in which all communication to each network connected device is routed through the hub router. The router connects various devices like printer, laptop, drives to communicate with one another.

## How to implement Mediator Pattern?

The mediator pattern consists of following:
- Mediator: This is an interface which declares methods for communication between different component objects. We will also have concrete implementataion of mediator objects implementing this interface. These concrete mediators encapsulate relationship between different components. These concrete mediators can keep references of all components they manage.
- Component: These are different classes which have bussiness logic. Components do not need to be aware of other components. If a component need to communicate with other component, it notifies the mediator and based on the sender of the notification, the mediator knows whom to pass the response. The sender does not need to know who will handle the request submitted by it and similarly the receiver of the request from the mediator does not know who sent the request.

### Hub router Example Code

1. Identify the two objects which are tightly-connected and they include collaboration logic along with their business logic. In this case, we have a `Computer` and `Printer` which might be tightly coupled and we want to faciliate their collaboration using a mediator. So, declare methods for collaboration between `Printer` and `Computer` in `Mediator` interface.

```java
public interface Mediator {
    void register(Device device);
    void send(Device sender, String message);
}
```

2. Implement this interface using `HubRouter` through which each of these connected devices communicate. This mediator includes references to all devices it manages.

```java
public class HubRouter implements Mediator {
    private List<Device> devices;

    public HubRouter() {
        this.devices = new ArrayList<>();
    }

    @Override
    public void register(Device device) {
        devices.add(device);
    }

    @Override
    public void send(Device sender, String message) {
        for (Device device: devices) {
            if (device != sender) {
                device.receive(message);
            }
        }
    }
}
```

3. Now, our components `Printer` and `Computer` have a reference to `Mediator`. Notice that when a `send()` operation is done from `Computer`, it passes through `Mediator`.

```java
public class Computer implements Device{
    private final String name;
    private final Mediator mediator;

    public Computer(String name, Mediator mediator) {
        this.name = name;
        this.mediator = mediator;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void send(String message) {
        System.out.println(name + " sends: " + message);
        mediator.send(this, message);
    }

    @Override
    public void receive(String message) {
        System.out.println(name + " received: " + message);
    }

    public void browse(String url) {
        System.out.println("Browsing url : " + url);
    }

    public void download(String file) {
        System.out.println("Downloading file : " + file);
    }
}
```

4. Similarly, for `Printer` once printing is done, message is sent using `Mediator`.

```java
public class Printer implements Device {
    private final String name;
    private final Mediator mediator;

    public Printer(String name, Mediator mediator) {
        this.name = name;
        this.mediator = mediator;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void send(String message) {
        System.out.println(name + " sends: " + message);
        mediator.send(this, message);
    }

    @Override
    public void receive(String message) {
        System.out.println(name + " received: " + message);
    }

    public void print(String file) {
        System.out.println("Printing file : " + file);
    }
}
```

5. The component do not have any reference to the other component. Each component register with the mediator to collaborate with each other.

```java
public class ClientMain {
    public static void main(String[] args) {
        Mediator mediator = new HubRouter();
        Device computer = new Computer("Dell Laptop", mediator);
        Device printer = new Printer("HP Printer", mediator);

        mediator.register(computer);
        mediator.register(printer);

        computer.send("Hello, Print this document");
        printer.send("Finished printing document");
    }
}
```

### Lights example using Mediator and Command pattern

Usually, mediator pattern can be combined with command pattern.

We have set of lights we want to control.

```java
public interface Light {
    void turnOn();
    void turnOff();
}
```

```java
public class BedroomLight implements Light {
    private boolean on;

    @Override
    public void turnOn() {
        on = true;
        System.out.println("Bedroom light is on");
    }

    @Override
    public void turnOff() {
        on = false;
        System.out.println("Bedroom light is off");
    }

    public boolean isOn() {
        return on;
    }
}
```

```java
public class KitchenLight implements Light {
    private boolean on;

    @Override
    public void turnOn() {
        on = true;
        System.out.println("Kitchen light is on");
    }

    @Override
    public void turnOff() {
        on = false;
        System.out.println("Kitchen light is off");
    }

    public boolean isOn() {
        return on;
    }
}
```

For this, we can define different on and off commands.

```java
public interface Command {
    void execute();
}
```

```java
public class OffCommand implements Command {
    private final Light light;

    public OffCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.turnOff();
    }
}
```

```java
public class OnCommand implements Command {
    private final Light light;

    public OnCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.turnOn();
    }
}
```

Now, we can use the mediator to collaborate between light and the command. This way we can reuse the same command or even lights in other application.

```java
public interface MediatorController {
    void registerLight(String name, Light light);
    void sendCommand(String name, Command command);
}
```

```java
public class LightController implements MediatorController {
    Map<String, Light> lights;

    public LightController() {
        this.lights = new HashMap<>();
    }

    @Override
    public void registerLight(String name, Light light) {
        lights.put(name, light);
    }

    @Override
    public void sendCommand(String name, Command command) {
        Light light = lights.get(name);
        if (light != null) {
            command.execute();
        } else {
            throw new IllegalArgumentException("Light not found");
        }
    }
}
```

From client's perspective, there is no coupling between these two.

```java
public class Main {
    public static void main(String[] args) {
        MediatorController lightMediator = new LightController();
        Light bedroomLight = new BedroomLight();
        Light kitchenLight = new KitchenLight();
        lightMediator.registerLight("Bedroom", kitchenLight);
        lightMediator.registerLight("Kitchen", bedroomLight);

        lightMediator.sendCommand("Bedroom", new OnCommand(bedroomLight));
        lightMediator.sendCommand("Kitchen", new OnCommand(kitchenLight));
        lightMediator.sendCommand("Bedroom", new OffCommand(bedroomLight));
    }
}
```

### Advantages:
- This pattern is used to reduce coupling between two collaborating objects. Thus, it makes code more reusable as well as testable.
- Mediator pattern improves maintainability of the code. We can easily add mediator to facilitate collaboration between well-defined objects.
- Mediator promotes single responsibility principle. It separates the communication concerns from the object's core functionalities.

### Disadvantages:
- The mediator object may add extra layer of complexity to the system.
- If the mediator fails, all communication between objects will break down. This makes mediator single point of failure.

### Comparison with Observer Pattern

| Mediator Pattern                                  | Observer Pattern                                      |
|:--------------------------------------------------|:------------------------------------------------------|
| used to define how objects interact with one another | This is more like obe to many broadcast message    |
| It helps decouple objects by eliminating their direct references. | This focuses on object decoupling in different way |
| It is more specific.                              | It makes a more generic messaging (becoming listener) |

## Summary
- Mediator is a useful pattern when we want to have loose coupling by simplifying collaboration between two tightly coupled objects.
- This pattern can be used with command pattern.
