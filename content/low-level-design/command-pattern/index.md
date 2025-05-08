---
title: "Command Pattern"
date: 2024-04-15T09:49:27-04:00
draft: false
---

Command pattern is used to encapsulate a user request as an object. This tutorial explains command pattern in Java using practical examples.

<!--more-->

## What is Command Pattern?

Command pattern is a behvioral pattern which converts a request into a standalone object. This object can have member variables and methods like any other objects so it will encapsulate all the required information about the request. Let's suppose we are building a word doc editor. we have generic button class which we can inherit from and create SaveButton, EditButton, CutButton, etc. All of these buttons will implement `Button` interface. This way, we may end up creating too many buttons which may be very difficult to manage.

Alternatively, we can use command pattern. In this pattern, we write generic command and have different concrete implementations like `WriteCommand`, `CutCommand`, `SaveCommand`, etc. The benefit with this approach is that the command is actually tied with the business logic rather than button. The main purpose behind each button action is to perform some action rather than the button name or button location. We can reuse logic of copy and paste into `CutCommand` or reuse business logic into `UndoCommand`. In order to achieve the same functionality, the `Command` object must also have a field for receiver. This way when this command is received, it will perform the action on the receiver object. The `Command` interface also defines `execute()` method which will be used to invoke action related to this command.

This pattern is often used for button related functionalities. For example, `java.swing.Action` uses this pattern. This pattern has one object per command and the contract of the command interface is mainted.

## How to implement Command Pattern?

This pattern mainly consists of following components:
- Command: This is an interface or an abstract class that defines the method to execute the command. 
- Concrete Commands: The subclasses of this will implement the interface and provide the concrete implementation logic for command to execute. The parameters required to execute the method on a receiving object can be declared as fields in the concrete command.
- Receiver: It is the receiver of the command. This is the object which will actually perform the task when a command object is received. 
- Invoker: This is the object which holds the command object and initiates command execution by calling the `execute()` method on the command object.

## Practical Example - Editor Undo Feature

1. Define the `Command` interface for all commands.

```java
public interface Command {
    void execute();
    void undo();
}
```

Create concrete commands by implementing the interface for all commands. In this case, I have an example of a `WriteCommand` which is used to write some text into a document.

```java
public class WriteCommand implements Command {
    private final WordDocument document;
    public final String text;
    private String previousText;

    public WriteCommand(WordDocument document, String text) {
        this.document = document;
        this.text = text;
        this.previousText = document.getContent();
    }

    @Override
    public void execute() {
        System.out.println("Executing write command for text: " + text);
        previousText = document.getContent();
        document.write(text);
    }

    @Override
    public void undo() {
        System.out.println("Undoing write command for text: " + text);
        document.setContent(document.getContent().replace(document.getContent(), previousText));
    }
}
```

Create invoker object. In this case, the `Document` object is the invoker. It is also the receiver of the commands. 

```java
public interface Document {
    void open();
    void write(String input);
    void save();
    void undo();
    void redo();
    String getContent();
}
```

```java
public class WordDocument implements Document {
    private StringBuilder content;
    private History history;

    public WordDocument() {
        content = new StringBuilder();
        history = new History();
    }

    @Override
    public void open() {
        System.out.println("Document opened.");
    }

    @Override
    public void save() {
        System.out.println("Document saved.");
    }

    @Override
    public void write(String content) {
        this.history.push(new WriteCommand(this, content));
        this.content.append(content);
    }

    @Override
    public void undo() {
        if (history.canUndo()) {
            history.pop().undo();
        }
    }

    @Override
    public void redo() {
        if (history.canRedo()) {
            history.redo().execute();
        }
    }

    public String getContent() {
        return content.toString();
    }

    public void setContent(String content) {
        this.content = new StringBuilder(content);
    }
}
```

This `WordDocument` object uses `History` object to store the history of the commands using a `Stack` data structure.

```java
public class History {
    private Stack<Command> undoStack;
    private Stack<Command> redoStack;

    public History() {
        this.undoStack = new Stack<>();
        this.redoStack = new Stack<>();
    }

    public void push(Command command) {
        undoStack.push(command);
        redoStack.clear(); // Clear redo stack on new command
    }

    public Command pop() {
        Command command = undoStack.pop();
        redoStack.push(command);
        return command;
    }

    public boolean canUndo() {
        return !undoStack.isEmpty();
    }

    public boolean canRedo() {
        return !redoStack.isEmpty();
    }

    public Command redo() {
        return redoStack.pop();
    }
}
```

The client can simply invoke commands using simple interface. All the details to the receiver are passed in the form of an object.

```java
public class ClientMain {
    public static void main(String[] args) {
        Document wordDoc = new WordDocument();
        wordDoc.open();
        wordDoc.write("Hello World!!! ");
        wordDoc.write("Hi there! ");
        System.out.println("Content: " + wordDoc.getContent());
        wordDoc.undo();
        System.out.println("Content: " + wordDoc.getContent());
        wordDoc.write("How are you?");
        System.out.println("Content: " + wordDoc.getContent());
        wordDoc.undo();
        System.out.println("Content: " + wordDoc.getContent());
    }
}
```

### Advantages:
- It decouples sender and receiver and provides more flexibility.
- The same command can be applied of different receivers. Adding different kinds of parameters do not change the invoker object which initiates the command.

### Disadvantages:
- It can sometimes be difficult to understand when this pattern can be used.
- It can be little difficult to understand with lots of commands.

### Comparison with Strategy Pattern

| Command Pattern                               | Strategy Pattern                              |
|:----------------------------------------------|:----------------------------------------------|
| It's structured around an object per command  | This is object per request with focus on strategy |
| The command object contains what we need to do| These objects contain how we want to implement algorithm |
| It encapsulates entire action to be performed | It encapsulates the algorithm to be applied.  |

## Summary

- This is one of the most popular patterns to abstract requests as set of commands.
- Command pattern encapsulates each request as an object and decouples sender and receiver.
