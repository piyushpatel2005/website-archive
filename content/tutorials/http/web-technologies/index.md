---
title: "Web Technologies"
date: 2024-05-23T22:46:46-04:00
draft: false
---

Web technologies are building on mostly three technologies: These are HTML, CSS and Javascript.

<!--more-->

## What are web technologies?

Web technologies are tools that developers use to create and manage websites and web applications. They include languages, frameworks, libraries, database systems, and other essential tools.

### 1. HTML

HTML is HyperText Markup Language. This is simply a mark up language which has some tags defined to mark the documents. In real world analogy, you can think of these as the actual building in construction which contains different partitions and general layout of the building. It simply lays out content of text and images.
HTML consits of tags, attributes and elements. A very simple HTML code looks like this.

```html
<!DOCTYPE html>
<html>
    <head>
        <title>My First Web Page</title>
    </head>
    <body>
        <h1>Hello, World!</h1>
        <p>This is a paragraph.</p>
    </body>
</html>
```

### 2. CSS

Cascading Style Sheets, also known as CSS provides styles to the document written with HTML. As mentioned above HTML simply provides structure of the document, but you can make them look different by providing different colors and font sizes with different shapes of images. CSS is what makes websites or webpages appealing and pleasing to read. In real-world, you can think of these as the actual interior design of the building. Even though the building had same size and structure of each offices, it would look very different depending on the interior furniture, wall paintings, colors etc.

The styles are assigned to specific part of the HTML code using selectors. These help target specific element in HTML document. Similarly, there are properties which define what part of the style should be changed such as color, font-size or background-color. Each of these properties are assigned a value specifying what color or how much margin or padding to apply to HTML element. Along with HTML selectors there are specific selectors to target specific part of the HTML document using class selectors. A simple CSS styles are defined like this.

```css
body {
    background-color: teal;
}

h1 {
    color: white;
    text-align: center;
}
```

### 3. Javascript

Javascript is programming language available in each web browser. Many people may not know but they already have a language available in their web browsers. Javascript provides interactivity to web documents. Without them, the webpages would look very boring. You would have interacted with Javascript when you noticed a subscription notification signup or even in login operations.

As mentioned Javascript is a programming language, so we can do pretty much all things using this language in the browser. There is also Javascript for server side which can be used to build server side applications. It can have variables, functions and can react based on certain events in the browser. For example, when you click "Login", it can show a notification on the top right saying that you've logged in or if you enter invalid birthdate, it can inform that birth date format is incorrect or invalid.

## Frameworks and Libraries

Frameworks and libraries are code written by other developers to help create webpages or to write server side code. Framework usually provides a structure to your codebase whereas library provides a general purpose function or ability to perform some specific action. There are CSS and Javascript frameworks which help develop web pages faster and easily such as Bootstrap, Tailwind, Materialize CSS, etc. Similarly, there are Javascript frameworks such as React, Angular and VueJS which help in handling user interactivity on the browser side or also known as client side. 