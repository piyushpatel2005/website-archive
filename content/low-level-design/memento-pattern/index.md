---
title: "Memento Pattern"
date: 2024-04-28T19:12:52-04:00
draft: false
---

Memento is a behavioral design pattern which can be used to externalize the state of an object to provide rollback functionality. This tutorial explains this pattern with Java code examples.

<!--more-->

## What is Memento Pattern?

Memento pattern allows you to save and restore the previous state of an object without exposing the details of its implementation. Let's suppose we have a payroll desktop application and we want the employees to be able to edit their employee information including name, address and phone number for now. Eventually, we decide to offer undo option. In order to perform undo, we have to save the state of the objects somewhere. The first option would be to create a `Stack` of `Employee` object. Everytime, the user saves their state or periodically the state gets stored in the stack. When the user wants to revert, we can `pop` the state from the `Stack` and apply them to current `Employee` object. There are several problems with this approach.

1. In order to save the state, we have to iterate through all fields of the object we want to save and store their values in another copy. For this we need access to all fields of the `Employee` object. This can work only if `Employee` had those fields available to other objects using `public` access modifier. In real-life objects, it may not allow others to look into those internal details and may be hiding those details in private fields.
2. If we relax this requirement and make all fields public or accessible for other object, we can copy the state easily. However, if you modify the available fields of the original `Employee` object, we have to modify the object which is responsible for copying the state of all the original `Employee` object.

The problem is we are trying to externalize the state saving to other object. Instead, if we add this logic to the object itself, it can access its `private` fields and we can have logic to store whatever we want to store. The Memento pattern delegates the state snapshot creation to the actual owner of the state. This pattern recommends storing the copy of object's state in an object known as **memento**. The data from the memento is not accessible to any other object except the original producer. Other objects communicate memento objects using only getters, but does not allow getting the state of the original object. We also have *caretaker* objects which stores memento objects. Again, this does not allow caretaker to modify the contents of the memento object. This also allows us to store only required fields as memento can have only subset of fields from original object. This pattern is useful whne you have objects whose behavior depend on their current state.

## How to implement Memento Pattern?

The Memento pattern consists of following main actors:
- Originator: This is the class whose snapshots we want to capture and this will be the class that can produce the snapshots. This class with have methods for taking snapshot `save()` and `restore()` to revert the state. It works with memento objects.
- Memento: This is an object which stores the state of `Originator`. Most likely this will be immutable, that is it will not have any setter method defined in it.
- Caretaker: This is an object which stores the memento. It also hides implementation of how the data is stored. It only exposes methods on how to save the memento and how to revert the previous state. Usually `Stack` is used to store memento objects in caretaker.


## Practical Code - Payroll App

1. We have an object that we want to store state of. In this case, you have Payroll app and you want to store the state of `Employee` object.

```java
public class Employee {
    private String employeeId;
    private String name;
    private String address;
    private String phone;

    public Employee(String employeeId, String name, String address, String phone) {
        this.employeeId = employeeId;
        this.name = name;
        this.address = address;
        this.phone = phone;
    }

    public Employee() {}

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public EmployeeMemento save() {
        return new EmployeeMemento(employeeId, name, phone);
    }

    public void revert(EmployeeMemento employee) {
        this.name = employee.getName();
        this.address = employee.getAddress();
        this.phone = employee.getPhone();
    }

    @Override
    public String toString() {
        return "Employeed ID: " + employeeId + " with name: " + name + " residing at " + address + " has phone number: " + phone;
    }

}
```

2. Create `EmployeeMemento` containing only information that we want to store from original `Employee`. In this case, the app will not allow employee to change the `employeeId` so we are not going to store that data into our memento. Also, note that memento only provides getters such that we cannot modify the stored state.

```java
public class EmployeeMemento {
    private String name;
    private String address;
    private String phone;

    public EmployeeMemento(String name, String address, String phone) {
        this.name = name;
        this.address = address;
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public String getName() {
        return name;
    }

    public String getPhone() {
        return phone;
    }

    public String toString() {
        return name + " residing at " + address + " has phone number: " + phone;
    }
}
```

3. Next define the `Caretaker` object which will store the history.

```java
public class EmployeeCaretaker {
    private Stack<EmployeeMemento> history = new Stack<>();

    public void save(Employee employee) {
        history.push(employee.save());
    }

    public void revert(Employee employee) {
        employee.revert(history.pop());
    }
}
```

4. Now the client works with `Caretaker` object to save and rollback the history.

```java
public class ClientMain {
    public static void main(String[] args) {

        EmployeeCaretaker caretaker = new EmployeeCaretaker();

        Employee john = new Employee();

        john.setEmployeeId("123");
        john.setName("John Doe");
        john.setAddress("101 King Street");
        john.setPhone("999-555-6666");

        System.out.println("Saving Employee: " + john);
        caretaker.save(john);

        john.setPhone("444-555-6666");
        caretaker.save(john);

        System.out.println("Employee Details: " + john);
        john.setPhone("333-999-6666");
        // When we call save, it will save the current state and next revert will revert to this state
//        caretaker.save(john);
        caretaker.revert(john);

        System.out.println("Employee Details: " + john);
        caretaker.revert(john);
        System.out.println("Employee Detail: " + john);
    }
}
```

### Advantages:
- This is great pattern when we want to have rollback feature.
- It encapsulates originator and allows to hide internal members.

### Disadvantages:
- This pattern can be expensive in memory if we have to store large copy of originator data.
- It requires careful implementation to not expose information of memento objects.
- Caretaker object needs to handle how much history it should keep and how to delete older states.

## Summary
- When we want to implement undo/redo kind of functionality, Memento pattern is very suitable one.
- This pattern can be used to create snapshots of the originator object.
- It looks similar to command pattern with history and state.
- You need to be careful with caretaker to not store infinite history.