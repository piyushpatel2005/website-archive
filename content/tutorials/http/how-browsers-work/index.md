---
title: "How Browsers Work"
date: 2024-06-09T18:06:41Z
draft: false
---

Everyday we interact with web using a browser like Google Chrome, Microsoft Edge, Opera or Firefox browser. These browsers are called web clients to interact with web and are usually install on the system by default. This tutorial aims to explain how browsers work.
<!--more-->

## What is Browser?

Browser is basically a software which renders web pages. The web pages are written in mark up language called HTML (Hyper Text Markup Language) with some styles applied using CSS (Cascading Style Sheets). The web browser downloads these files from web server and displays them to the user in a meaningful or appealing way. The user simply enters the website address that they want to visit in the URL bar and it downloads the related HTML documents in the system to display them.

There are five major vendors of browsers.
1. Google Chrome
2. Microsoft Edge
3. Mozilla Firefox
4. Opera Browser
5. Apple Safari

## Standardization of Web

There is a [W3C](https://www.w3.org/) which manages the standards for the web. Web browser vendors are supposed to follow those standards in order to make each browser experience compatible with each other. However, some vendors also add extra features into their browsers on top of the standards defined by W3C body and it's also common that those features may become part of the standards defined by W3C.

When developing your web application, you can decide if you want to support particular web browser or only few web browsers. Some of the styling using CSS works differently in different browser. That's where you will have to choose whether you want to support all of those browsers or just a few. Of course, if you want to support all browsers, you will require testing on all supported browsers which will take extra efforts in terms of cost and technical resource. Just to give you a brief context, Chrome has the biggest percentage of users followed by Firefox, Edge, Safari and Opera browsers. So, you may choose to support only Chrome or possibly all of them.

Last but not least, there are also mobile browsers like Opera Mini, Android browser, etc which might have little different behavior not just on browsers but also on different devices. So, those kind of devices might also require additional testing for web UI.

## How Browsers work?

Browser sends a request to web server. In web browser you can input the address of the website you want to visit in address bar at the top. The address is defined by URL (Uniform Resource Locator). The URL contains protocol, domain name and file path. The following process happens when you browse using web browsers.

## Step-by-Step Process

### 1. URL Request
When you type a URL into the address bar and press enter, the browser begins its operations by analyzing the entered URL. First, it needs to find the location of the website you're visiting. For this, it needs to convert the URL into an IP address.
The browser contacts a Domain Name System (DNS) server to translate the human-readable address (e.g., www.example.com) into an IP address that computers can understand.

### 2. HTTP Request
With the IP address obtained, the browser establishes connection with the server that hosts website's files and it sends an HTTP request to retrieve resources like HTML documents from a web server. Along with this HTML document, it will also receive CSS and Javascript files.

### 3. Server Response
In response to browser's request, the server responds with the requested resources or an error message if something goes wrong (e.g., "404 Not Found"). These files are delivered over the internet to the browser.

### 4. Rendering
Once browser receives all files, the rendering engine starts parsing HTML documents along with associated CSS and JavaScript files to display content on your screen.

1. **HTML:**
   - The rendering engine parses HTML line by line to construct something called the DOM (Document Object Model).
   
2. **Applying CSS:**
   - It then applies CSS rules to style elements within the DOM tree.
   - The positions of various elements are calculated in this phase based on styling rules.
   
3. **Javscript:**
   - This adds interactivity and dynamic elements to the page. This allows for cool animations and forms making web pages appealing.

4. **Painting**
   - Finally, elements are painted bit by bit onto your screen forming what you see as a complete webpage.

## Networking and Security 

Modern browsers also prioritize security and use encryption to ensure data safety.

- Whenever data travels between servers via networks browsers use protocols like HTTP/HTTPS while ensuring efficient network usage through techniques like caching, compression & secure connections.
- Security features prevent unauthorized access
- Same-origin policy restricts scripts from different sites interacting without permission preventing malicious activities thereby keeping users safe!

