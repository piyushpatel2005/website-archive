---
title: "Introduction to YAML"
date: 2024-02-07T10:10:15-05:00
draft: false
categories: ["DevOps"]
tags: ["YAML"]
languages: ["YAML"]
---

YAML (YAML Ain't Markup Language) is a human-readable data serialization format that has gained popularity for its simplicity and readability. The syntax of YAML is very succinct compared to XML or JSON format. In this tutorial, we will explore the syntax and data structures of YAML in detail.
<!--more-->

YAML is used widely in configuration management tools used in present day IT infrastructure management.

## Understanding YAML Syntax

YAML employs a straightforward syntax consisting of key-value pairs, lists, and nested structures. Let's delve into the fundamental components of YAML syntax:

### 1. Basic Data Types

Scalars represent single values like strings, numbers, and booleans.

- **Strings**: Strings can be enclosed in single quotes (`''`) or double quotes (`""`).

```yml
name: 'John Doe'
reason: "It's a beautiful day"
```

- **Numbers**: Integers and floats are represented as-is.

```yml
age: 23
rank: 4
```

- **Booleans**: `true` and `false` represent boolean values.

```yml
is_admin: true
is_player: false
```

### 2. Collections
- **Lists**: Lists are denoted by hyphens (-) followed by space for each item. In below example, we define a list of `fruits` which has three elements apple, banana and orange. Notice the elements of the list are indented with hyphen. List is an ordered collection.

```yaml
fruits:
    - apple
    - banana
    - orange
```

- **Dicationary**: A dictionary is represented using key-value pairs. These are represented using key followed by colon (`:`) and a space and then the value associated with this key. Below example shows a dictionary of `person` which has two key-value pairs. 

```yaml
person:
    name: John Doe
    age: 30
```

Dictionaries are unordered collection. That means below is exactly same as above example of dictionary.

```yaml
person:
    age: 30
    name: John Doe
```

### 3. Indentation Rules
- Indentation is crucial in YAML to define hierarchy. Incorrect indentation results in syntax error.
- Two spaces or four spaces are commonly used for indentation. You have to be consistent in terms of the spaces we use in the YAML file.

## YAML Data Structures

In addition to simple scalar values, YAML supports complex data structures which are made from collection types. We can define dicationary of lists or list of dictionary.

### 1. Lists of Dictionaries (Array of Objects)

```yaml
users:
  - name: Alice
    age: 25
  - name: Bob
    age: 30
```

### 2. Nested Structures

YAML allows nesting data structures within one another.

```yaml
employee:
  id: 1234
  details:
    name: John Doe
    department: IT
```

### 3. Inline Collections

Inline collections enable a more compact notation for defining lists and dictionaries. Below example matches with the examples we show earlier but in terms of syntax, this is lot of compact representation.

```yaml
fruits: [apple, banana, orange]
person: {name: John Doe, age: 30}
```

### Conclusion

Understanding YAML's clear syntax and versatile data structures is essential for working with configuration files, data storage, and numerous other use cases.