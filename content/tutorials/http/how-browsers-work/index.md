---
title: "How Browsers Work"
date: 2024-05-18T17:33:33Z
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