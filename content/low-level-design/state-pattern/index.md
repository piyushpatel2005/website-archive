---
title: "State Pattern"
date: 2024-04-29T20:05:08-04:00
draft: false
---

In the state pattern, request handling takes into account the current state of the object. This tutorial explains State pattern with Java examples.
<!--more-->

## What is State Pattern?
The state pattern is a behavioral design pattern which can be used to represent state machine in code. 
It is used to localize the state behavior. The state of an object is stored in objects rather than local variables of different types. This is used to represent finite state machine. At a given point in time, the program can be in one of the finite states. For each state, the system behaves diferently. Depending on the current state of the system, it may or may not switch to other states. A simple example of state pattern is followed by switches in home. The switch can be in one of the two states: on or off. If the switch is OFF, it can switch to only ON state.

This pattern can be applied to work progress boards. The issue can only move to `IN PROGRESS` from `BACKLOG` or `BLOCKED` state. It can be moved to `DONE` only from `IN PROGRESS` state, etc. We could implement this using conditionals making sure if current state is `BACKLOG`, it can move to only `IN PROGRESS`. This might be ok for only few states but what if we have lots of states which can go through. In that case, our code will have huge `if...else` blocks. It will be difficult to manage because even a simple logic change will require lot more attention to modify the code.

The state pattern recommends to create a new class for all possible states of an object and methods for specific behaviors.

## How to implement State Pattern?

The state pattern consists of following actors:
- Context: This stores a reference to one of the concrete states. The context object will communicate with states using state interface.
- State: This is an interface that defines required methods for moving state from one state to another. There will be implementations of this interface with concrete states. This state object may store a reference to the context object which can be useful to fetch any required info from the context.

## Practical Code - Washing Machine states

1. Define an interface for `State` objects. Note that each operation takes a context washing machine object.

```java
public interface WashingMachineState {
    void start(WashingMachine machine);
    void chooseCycle(WashingMachine machine);
    void pause(WashingMachine machine);
    void stop(WashingMachine machine);
    void openDoor(WashingMachine machine);
    String getStatus();
}
```

2. Define concrete states for each of these. Depending on current state, it may not be able to switch to other state. For example, in `OffState`, the system cannot transition to `PausedState`.

    a. `OffState` for machine

    ```java
    public class OffState implements WashingMachineState {
        @Override
        public void start(WashingMachine machine) {
            System.out.println("Select wash type first");
        }

        @Override
        public void chooseCycle(WashingMachine machine) {
            System.out.println("Cycle selected");
            machine.setState(machine.getWashingState());
        }

        @Override
        public void pause(WashingMachine machine) {
            System.out.println("Machine is already off so cannot pause.");
        }

        @Override
        public void stop(WashingMachine machine) {
            System.out.println("Machine is already off so cannot stop.");
        }

        @Override
        public void openDoor(WashingMachine machine) {
            System.out.println("You can open the doors.");
        }

        @Override
        public String getStatus() {
            return "Off";
        }
    }
    ```

    b. `CycleSelected` state

    ```java
    public class CycleSelectedState implements WashingMachineState {
        @Override
        public void start(WashingMachine machine) {
            System.out.println("Starting the washing machine");
            machine.setState(machine.getWashingState());
        }

        @Override
        public void chooseCycle(WashingMachine machine) {
            System.out.println("Cycle selected");
        }

        @Override
        public void pause(WashingMachine machine) {
            System.out.println("Cannot pause while cycle selected");
        }

        @Override
        public void stop(WashingMachine machine) {
            System.out.println("Stopping the washing machine");
            machine.setState(machine.getOffState());
        }

        @Override
        public void openDoor(WashingMachine machine) {
            System.out.println("Cannot open the door while cycle selected");
        }

        @Override
        public String getStatus() {
            return "Cycle Selected";
        }
    }
    ```

    c. `PausedState` 

    ```java
    public class PausedState implements WashingMachineState {
        @Override
        public void start(WashingMachine machine) {
            System.out.println("Resuming the washing machine");
            machine.setState(machine.getWashingState());
        }

        @Override
        public void chooseCycle(WashingMachine machine) {
            System.out.println("Cannot choose cycle while paused");
        }

        @Override
        public void pause(WashingMachine machine) {
            System.out.println("Already paused");
        }

        @Override
        public void stop(WashingMachine machine) {
            System.out.println("Stopping the washing machine");
            machine.setState(machine.getOffState());
        }

        @Override
        public void openDoor(WashingMachine machine) {
            System.out.println("You can open the door now.");
        }

        @Override
        public String getStatus() {
            return "Paused";
        }
    }
    ```

    d. `WashingState` state

    ```java
    public class WashingState implements WashingMachineState {
        @Override
        public void start(WashingMachine machine) {
            System.out.println("Already washing");
        }

        public void chooseCycle(WashingMachine machine) {
            System.out.println("Already washing");
        }

        @Override
        public void pause(WashingMachine machine) {
            System.out.println("Pausing the washing machine");
            machine.setState(machine.getPauseState());
        }

        @Override
        public void stop(WashingMachine machine) {
            System.out.println("Stopping the washing machine");
            machine.setState(machine.getOffState());
        }

        @Override
        public void openDoor(WashingMachine machine) {
            System.out.println("Cannot open the door while washing");
        }

        @Override
        public String getStatus() {
            return "Washing";
        }
    }
    ```

3. Next, we have `WashingMachine` which will have methods for normal machine operations. Note that washing machine has a current state as a member.

```java
public class WashingMachine {
    private WashingMachineState state;

    public WashingMachine() {
        state = new OffState();
    }

    public void start() {
        state.start(this);
    }

    public void chooseCycle() {
        state.chooseCycle(this);
    }

    public void pause() {
        state.pause(this);
    }

    public void stop() {
        state.stop(this);
    }

    public void openLid() {
        state.openDoor(this);
    }

    public String getStatus() {
        return state.getStatus();
    }

    public void setState(WashingMachineState state) {
        this.state = state;
    }

    public WashingMachineState getState() {
        return state;
    }

    public WashingMachineState getOffState() {
        return new OffState();
    }

    public WashingMachineState getCycleSelectedState() {
        return new CycleSelectedState();
    }

    public WashingMachineState getPauseState() {
        return new OffState();
    }

    public WashingMachineState getWashingState() {
        return new WashingState();
    }
}
```

Now, the client code can work with washing machine.

```java
public class ClientMain {
    public static void main(String[] args) {
        WashingMachine washingMachine = new WashingMachine(); // OffState
        System.out.println("Current state: " + washingMachine.getStatus()); // Off
        washingMachine.start(); // Select wash type first
        washingMachine.chooseCycle(); // Cycle selected
        System.out.println("Current state: " + washingMachine.getStatus()); // Cycle Selected
        washingMachine.openLid(); // Cannot open the door while cycle selected
        washingMachine.start(); // Starting the washing machine
        System.out.println("Current state: " + washingMachine.getStatus()); // Washing
        washingMachine.start(); // Already washing
    }
}
```

### Advantages:
- The code becomes easier to understand with each state in its own class.
- It also becomes easier to add new states. We can add new state class without modifying existing state objects.

### Disadvantages:
- Having implemented this pattern, we might end up with lots of classes for each state. Having new object for each of states may result in memory overhead.
- If you have very few state changes, this pattern might be an overkill.

### Comparison between State and Strategy Patterns

| State Pattern                                 | Strategy Pattern                                  |
|:----------------------------------------------|:--------------------------------------------------|
| This is interface driven.                     | This is based on algorithm or strategy.           |
| Each state only knows about the next state.   | Different strategies don't know about each other. They are independent. |
| Each state has its own class                  | In this case, each algorithm has their own class. |

## Summary
- This pattern can be used to implement Finite State machine for the system.
- It can be little complicated if there are lots of state changes happening. It also adds lots of state classes.
- It simplifies complexities of having multiple `if..else` conditions and make code more maintainable. We can easily add new state by adding new class without modifying existing states. This follows Open/Closed principle.
- State pattern looks similar to Strategy pattern, but the intent is different.