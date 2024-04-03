---
title: "Composite Pattern"
date: 2024-03-31T12:34:33-04:00
draft: false
---

Composite design pattern is a structural design pattern which allows you to use group of objects as a single object. This creates a tree like structure or directory like structure where composite objects can contain simple objects (leaf) as well as composite objects (branches). This tutorial explains this pattern with examples.

<!--more-->

## What is Composite Pattern?

When we have a situation where our core model can be represented as a tree, we can delegate the work to hierarchy and get the results. This usually ends up creating a tree like structure where we have branches and eventually end nodes which are called leaf nodes. For example, in directory structure, we can have directories of directories as well as we can have files inside a directory. If we want to get the size of the directory, we can traverse its branches recursively and get size of all files and sum them up. In this case, we want directory (branches) and files (leaf nodes) to behave similar.

Similarly, if you want to build a drawing app, you might have `CompositeShape` which consists of different shapes. You can have `Shape` interface which defines the `draw()` method for all shapes. You create hierarchy of shapes as `Circle` and `Square` which are also leaf classes and provide specific implementation of `draw()` method. `CompositeShape` might consist of multiple composite shapes or leaf classes like `Square` or `Circle`. So, it has methods like `addShape()` which will add more children to draw. When the `draw()` method is called on `CompositeShape`, it will simply iterate through its child shapes and delegate the drawing to those child shape `draw()` method. The client code can consider them as shape using their `draw()` method.

The same can be thought for hierarchy of tasks. For example, you might have seen bullet lists consisting of other bullet lists. They can be treated as comoposite objects. The same kind of logic applies for JIRA project management EPICs.

## How to implement Composite Pattern?

The Composite design pattern consists of following components.
- Component: It defines the common operations that are common to simple and complex items of the tree hierarchy.
- Leaf Node: The leaf will be the most basic element of the tree that cannot be sub-divided.
- Container: The container is also the composite object or complex object which might consist of other complex objects or leaf objects. A container has collection of component. Whenever a request is made to container object, it simply delegates the task to children component. 

To implement this pattern do the following.
1. Identify the Leaf class and container class and identify the common operations.
2. Define common interface `Component` for both leaf class and complex class which only declares those methods common to both.
3. Implement this common interface for all possible Leaf classes and complex container classes. 
4. Container class must also have a method to add new child classes of original `Component`.
4. The leaf classes must have concrete implementation for those methods doing the actual work. On the other hand, container classes should delegate the work to its child components.

### Task example

Below is a practical example with `SubTask` as Leaf class and `Task` as container class.

First declare common methods in `TaskItem` interface.

```java
public interface TaskItem {
    public String getName();
    public boolean isCompleted();
    public void complete();
    public void listItems();
}
```

Implement the Leaf class `SubTask`. This class actually does the work.

```java
public class SubTask implements TaskItem {
    private String name;
    private boolean completed;

    public SubTask(String name) {
        this.name = name;
        this.completed = false;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public boolean isCompleted() {
        return completed;
    }

    @Override
    public void complete() {
        completed = true;
    }

    public void listItems() {
        System.out.println("SubTask: " + getName() + " is " + (isCompleted() ? "completed" : "not completed"));
    }
}
```

Define container class or composite class which consists of list of Component objects. This works with common interface and not the actual implementation.

```java
public class Task implements TaskItem {
    private String name;
    private List<SubTask> tasks;

    public Task(String name) {
        this.name = name;
        this.tasks = new ArrayList<>();
    }

    public void addSubTask(SubTask task) {
        tasks.add(task);
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public boolean isCompleted() {
        return tasks.stream()
                .allMatch(SubTask::isCompleted);
    }

    @Override
    public void complete() {
        tasks.forEach(SubTask::complete);
    }

    public void listItems() {
        System.out.println("Task: " + getName());
        System.out.println("----------------------------------");
        for (SubTask task : tasks) {
            task.listItems();
        }
    }
}
```

Now, the client can simply treat both these types as being similar and can simply ask for completion or ask to list items. Behind the scenes, `Task` delegates the work to `SubTask`.

```java
public class Main {
    public static void main(String[] args) {
        Task task = new Task("Learn Java Programming language");
        task.addSubTask(new SubTask("Read Tutorials"));
        task.addSubTask(new SubTask("Type the code examples"));
        task.addSubTask(new SubTask("Build projects"));

        task.listItems();


        System.out.println("==================================");
        System.out.println("Completing the task");
        task.complete();

        System.out.println("==================================");
        task.listItems();
    }
}
```

### FileSystem example

Another example is for filesystem as shown below. The `FileSystemComponent` defines the common operations like `getName()`, `listItems()` and `getSize()`

```java
public interface FileSystemComponent {
    public String getName();
    public void listItems();
    public int getSize();
}
```

The `File` leaf class implements `FileSystemComponent` and stores the name and size information for each file.

```java
public class File implements FileSystemComponent {
    private String name;
    private int size;

    public File(String name, int size) {
        this.name = name;
        this.size = size;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void listItems() {
        System.out.println(" File " + getName() + " with size " + getSize() + " bytes");
    }

    @Override
    public int getSize() {
        return size;
    }
}
```

The `Directory` is a composite class which implements `FileSystemComponent` and can have list of `FileSystemComponent`s. It also defines `addComponent()` method to add child items into directory. The `listItem()` and `getSize()` methods of `Directory` class delegates this calls to child objects.

```java
public class Directory implements FileSystemComponent {
    private String name;
    private List<FileSystemComponent> children;

    public Directory(String name, List<FileSystemComponent> children) {
        this.name = name;
        this.children = children;
    }

    public Directory(String name) {
        this.name = name;
        this.children = new ArrayList<>();
    }

    @Override
    public String getName() {
        return name;
    }

    public void addComponent(FileSystemComponent component) {
        children.add(component);
    }

    @Override
    public void listItems() {
        System.out.println("Directory " + getName());
        for (FileSystemComponent child : children) {
            child.listItems();
        }
    }

    @Override
    public int getSize() {
        return children.stream()
                .mapToInt(FileSystemComponent::getSize)
                .sum();
    }
}
```

The client code can treat both `File` and `Directory` uniformly using `listItems()` and `getSize()` method to get information for the directory or file.

### Advantages:

- This pattern is great for definining hierarchical structure of objects.
- Each classes are treated the same. Thus it makes the code simple to understand.
- We can easily add new types of objects without modifying existing code.
- It follows OCP (Open/Closed principle). That means we can easily extend the functionality of the system by adding new types of objects without modifying existing code.

### Disadvantages:

- There can be performance overhead because of nested lookups. If the structure is very deep, it can be costly traversing the tree recursively.
- Defining common interface might over simplify it. This means we might end up defining methods which some of the child classes may not need and those may end up having to define empty methods just to implement the common interface.

### Comparison with Decorator Pattern

| Decorator Pattern                         | Composite Pattern                         |
|:------------------------------------------|:------------------------------------------|
| contains a separate entity                | This has a tree structure of objects      |
| It modifies the behavior                  | It doesn't modify behavior                |
| It does not change the underlying object  | It creates uniformness between objects    |
| It has one child component                | Composite can have any number of children |

## Summary

- Composite pattern is designed to treat components the same way.
- This is implemented by composing objects into a tree like structure.
- The same operations are applied on individual leaf classes and composite classes.