---
title: "Stacks and Queues"
date: 2024-05-08T22:12:12-04:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
ideas: ["Stacks and Queues"]
---

Stacks and queues are different kind of data structure which are derived from other collection data type. However, they efficiently implement putting data into it and retriving data.

## Stack

Stack is a LIFO (Last In First Out) data structure where elements are added and removed from the same end. If we think about stack of books, we can grab the books from the top. The last book we placed will be on the top and we can first get that book from the desk. In stacks, the last item inserted is the first one that we can retrieve.

Stacks are implemented using `LinkedList` or `Array`. Stacks has two main methods: `push(item)` to push an item into a stack and `pop()` to retrieve the last inserted element. The time complexity of stack operations depend on underlying implementation. It's common to use `LinkedList` for it with `tail` pointer. The main methods of stack are as mentioned below.

| Method        | Description               |
|:------------------|:--------------------------------------------------------------|
| `push(element)`   | Pushes an element on top of a stack.                          |
| `pop()`           | Removes an element from the top of the stack and returns it.  |
| `peek()`          | Returns element from the top of stack but does not remove it. |
| `empty()`         | It returns `true` if stack is empty else `false`.             |

Stack is useful in question where we need LIFO data structure.

### Problem of Valid Parentheses
One of the common problems which can be solved using stack is finding if parentheses are valid. The parentheses are considered valid only if there are equal number of opening parentheses as the closing ones and they have to be in the correct order. For example, `{()}` is considered a valid parentheses but `{(})` or `{()})` are not valid parentheses. 

In this example, the correct order can be defined as whatever last parentheses we put in there, there should be equivalent closing parentheses as a next parentheses. This is where LIFO structure can come in handy. Whenever we encounter a closing parentheses, we should have corresponding opening parentheses in the stack which we can pop out on getting a closing parentheses.

Check [Valid Parentheses Solution](../../solutions/0020-valid-parentheses/) for more explanation on this.


### Problems where we need LIFO structure

Another problems is situation where we need LIFO data structure. For example, given an input string, remove duplicates until there are no more duplicates. Return this final string. An example of this is for `input= "abaaccba`, we can remove `"aa"` and `"cc"` in first iteration. When we move those, we have `"abba`, again we can remove `"bb"`. After removing these `b`s, we have `"aa"` so we can remove `a`s. If we notice carefully, it's LIFO pattern. We iterate through characters of the input string. If our list is empty, we simply insert this character else if the new character matches the character in the stack, we remove them and iterate through next character.

[Remove All Duplicates in a String](../../solutions/1047-remove-all-adjacent-duplicates-in-string/)

[Backspace String Compare](../../solutions/0844-backspace-string-compare/)