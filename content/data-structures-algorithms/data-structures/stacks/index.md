---
title: "Stacks"
date: 2023-12-29T15:42:12-05:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
---

Stack is a data structure which follows a particular order in which the operations are carried out. It can be described as a group of items where an item can only be added and removed from the top, almost like a physical stack of books or plates.

The main two operations involved:
1. "Push": This operation adds an element to the stack.
2. "Pull" (or "Pop"): This removes an element from the top of the stack.

There's also another helpful feature sometimes used:
- "Peek" or "Top": This gives you the topmost element without removing it.

This order is known as LIFO (Last In First Out), meaning that the most recently added element will be the first one to get out.

**Java Implementation:**

```java
import java.util.Stack;
 
public class Main
{
    public static void main(String[] args)
    {
        Stack<Integer> stack = new Stack<Integer>();
 
        stack.push(10);
        stack.push(20);
        stack.push(30);
        
        System.out.println(stack.pop());
        System.out.println(stack.peek());
    }
}
```

In the example above:

- We create a stack of integers.
- We `push` three integers onto the stack. Pushing is like adding an item on top of the pile.
- We then `pop`, which removes and returns the last element we added (30 in this case). Popping is akin to removing the item from the top of the pile.
- Finally, we `peek`, which just returns the current top element without removing it (20 here).

**Python Implementation:**

```python
stack = []

stack.append('a')
stack.append('b')
stack.append('c')

print("Popped:", stack.pop())
print("Peek:", stack[-1])
```

In much similar way, in Python, we:

- Append 'a', 'b', and 'c' to our list. Since it's a stack data structure, they are appends as though they've been "pushed" onto a single-pile stack.
- We then `pop`, which again removes and returns the last appended item ('c' in this case).
- Lastly, by using index `[-1]`, we just return (or "peek at") the current last item without removing it ('b'). It's worth noting that Python doesn't have a built-in peek function as Java does.

The time complexity for the main operations (push, pop, peek) in a stack data structure is O(1):

- **Push**: When we add an element to the top of the stack. The time complexity of this operation is O(1), which means it takes a constant amount of time, regardless of the size of the stack.
  
- **Pop**: When we remove an element from the top of the stack. This operation also has a time complexity of O(1) because it too happens in a constant amount of time no matter how big the stack is.

- **Peek**: Looking at or returning the top element from the stack without removing it. This also has a time complexity of O(1) as it takes place instantaneously regardless of how many items are in our stack.

Hence, push, pop and peek operations are quite efficient on a stack due to their constant time complexities.

## Practical Use Cases for Stack

1. **Undo Mechanisms**: In many software applications like word processors or graphics programs, there's a feature to undo the previous operation. This is implemented using a stack where every new operation is pushed onto the stack and the undo operation simply pops operations from the stack to revert them.

2. **Web Browsing History**: When you hit the 'back' button on your browser, it takes you to previously visited pages, which works on a stack concept where each visited page URL is stacked in order of visit.

3. **Expression Evaluation & Syntax Parsing**: For parsing complex expressions like "2*(3+4) + 5", compilers make use of stack data structure for computation and proper parenthesis matching.

4. **Function Calls/Recursion**: In almost all modern computers, each active function call gets a slab of memory (stack frame) used for storing local variables and other information about the function status. This information is pushed onto a call stack while calling functions, and popped out when completed - preserving program execution context before jumping for other tasks.

5. **Memory Management**: In low-level programming languages such as C++, stacks play an important role in managing memory allocation efficiently.

6. Apart from these, stacks can be used in algorithms like depth-first search(DFS) in graph theory.