---
title: "Iterator Pattern"
date: 2024-04-27T21:22:22-04:00
draft: false
---

Iterator is a behavioral design pattern which allows you to traverse elements of a collection without exposing its internal representation. This tutorial discusses iterator design pattern.

<!--more-->

## What is Iterator Design Pattern?

The important point with Iterator pattern is that it provides iteration logic but it does not expose the underlying data structure used to store the elements. This is particularly useful when we want to have multiple iteration logic. For example, Some of the available data structures like list, array provide inherent way to iterate all elements of the collection. If the collection stores the data using one of these data structures, we can easily iterate through all elements of the collection. However, if the underlying data structure is tree, we can iterate using breadth-first or depth-first traversal. We can add many types of traversal algorithms to the collection, but that's not the purpose of the collection. It's main purpose is to store data efficiently.

The client can implement the traversal algorithm but client should not care about how the data i stored in the collection. The iterator pattern creates an object with traversal logic for the collection. It decouples iteration logic from the collection. The iterator also encapsulates all the traversal details including the current position of the iteration, number of elements in the collection, etc. This allows multiple iterators to iterate a collection at the same time.

This pattern is useful when you have a collection with a complex data structure. You want to create iteration logic that hides the complexity from the client code. This also helps decouple traversal logic from the collection object. It reduces code duplication for traversal if we had to traverse through collection multiple times. In standard Java library, we have `Iterable` interface with collections implementing it to facilitate traversal of their elements.

## How to implement Iterator Pattern?

The iterator pattern consists of following main components:
- Iterator: This is an interface which declares the operations needed for traversing a collection. The primary methods are `next()` and `hasNext()`. We will have different concrete iterators with their own logic for traversing the collection.
- Collection: This is and interface having multiple elements and needs iteration logic. So, it provides one or more methods for getting iterators that can iterate over its elements. These getter methods should declare with return type of Iterator interface so that it can return a concrete iterator. The concrete collection will implement these getter methdos to get specific type of iterator. It will also have other logic related to collection.
- Client: Tthe client works with both iterator and the collection using the interface. This decouples client from the specific concrete class of collection. 

1. In this case, we are designing a simple DVD store, so we have `DVD`s.

```java
public class DVD {
    private String title;
    private String category;
    private boolean available;

    public DVD(String title, String category) {
        this.title = title;
        this.category = category;
        this.available = true;
    }

    public String getTitle() {
        return title;
    }

    public String getCategory() {
        return category;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    @Override
    public String toString() {
        return "DVD{" +
                "title='" + title + '\'' +
                ", category='" + category + '\'' +
                ", available=" + available +
                '}';
    }
}
```

We also have `DvdStore` collection interface which declares the methods for the collection.

```java
public interface DvdStore {
    void add(DVD dvd);
    void remove(DVD dvd);
    void addAll(List<DVD> dvds);
    DvdIterator getIterator();
}
```

and we have concrete implementation for it.

```java
public class DvdStoreImpl implements DvdStore {
    private List<DVD> movies;

    public DvdStoreImpl() {
        this.movies = new ArrayList<>();
    }

    public void add(DVD dvd) {
        movies.add(dvd);
    }

    public void remove(DVD dvd) {
        movies.remove(dvd);
    }

    public void addAll(List<DVD> dvds) {
        movies.addAll(dvds);
    }

    public DvdIterator getIterator() {
        return new SimpleDvdIterator(movies);
    }
}
```

In above code, note that `getIterator()` returns an interface defined below and not the concrete implementation of the iterator.

2. In order to actually create an iterator object, first declare and interface for `Iterator` with required methods declared in it.

```java
public interface DvdIterator {
    boolean hasNext();
    DVD next();
}
```

3. Create concrete `DvdIterator`.

```java
public class SimpleDvdIterator implements DvdIterator {
    private List<DVD> movies;
    private int currentPosition;

    public SimpleDvdIterator(List<DVD> movies) {
        this.movies = movies;
        this.currentPosition = 0;
    }

    @Override
    public boolean hasNext() {
        return currentPosition < movies.size();
    }

    @Override
    public DVD next() {
        if (hasNext()) {
            return movies.get(currentPosition++);
        }
        return null;
    }
}
```

Now, the client can iterate through all elements using simple interface without knowing the internal details of how DVDs are stored in `DvdStore`.

```java
public class ClientMain {
    public static void main(String[] args) {
        DVD dvd1 = new DVD("Titanic", "Romance");
        DVD dvd2 = new DVD("Avatar", "Fantasy");
        DVD dvd3 = new DVD("True Lies", "Action");

        List<DVD> dvds = List.of(dvd1, dvd2, dvd3);
        DvdStoreImpl dvdStore = new DvdStoreImpl();
        dvdStore.addAll(dvds);
        DvdIterator dvdIterator = dvdStore.getIterator();

        while (dvdIterator.hasNext()) {
            System.out.println(dvdIterator.next().getTitle());
        }
    }
}
```

### Advantages:
- This pattern decouples specific traversal algorithms from the specific collection they operate on.
- Iterator pattern hides the internal representation of data in the collection from client. The client doesn't need to know how the data is stored in the collection.
- Iterator pattern promotes single responsibility principle. It also promotes Open/Closed principle. You can easily add new kinds of iteration logic in new iterators and use them without breaking anything.
- This pattern also allows multiple code to iterate through same collection because each iterator object contains its own iteration state.

### Disadvantages:
- If the code contains simple data collection, implementing iterator pattern might be an overkill.
- Iterator pattern do not provide access to current element index which might be important in some cases.

## Summary:
- Iterator pattern is an efficient way to implement complex traversal logic.
- It hides the traversal algorithm from the client and allows for reuse of traversal code.
- This pattern is based on an iterator interface and is widely used in Java standard language.