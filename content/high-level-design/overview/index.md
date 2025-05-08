---
# type: docs 
title: Overview of Systems Design Interview
date: 2025-05-05T18:16:34-04:00
weight: 100
featured: false
draft: false
comment: true
toc: true
reward: true
pinned: false
carousel: false
series:
categories: []
tags: []
images: []
---

This lesson focuses on the objective of High level system design, what it covers and how it is assessing you as a candidate.

<!--more-->

## Overview

High level System design or System design interview in general is one of the most important interviews these days. These interviews start with an interviewer providing you a short and purposefully vague system that you need to design.

These interviews are used to test your depth of knowledge in designing a particular system as well as your ability to communicate these designs to other engineers. These interviews are used critically to determine your level of seniority. So, these interviews are sometimes rated higher than other types of interviews for senior positions. These interviews can be very challenging especially because you have to design a complex system within an hour. The complexity is even more because you might have to think, draw and talk at the same time to your interviewer. System design is more of an art because you have to think of a design in the given constraints like resources, time to suit your current and future requirements.

## It's a tradeoff

System design discussion is more about one's ability to discuss multiple possible approaches and weight their advantages and disadvantages for the given problem. The interviewer is looking for your ability to clearly communicate your thoughts and ideas. They are also not looking for perfect solution but it's more about how you can convince them to a particular solution. So, having knowledge of various technologies and their tradeoffs is essential for this interview.

## What skills do you need?

Systems design interview is a test of multiple skills. You need to demonstrate at least communication skills, quick thinking, asking good questions and performance optimization skills. Of course this being timed interview, you also need to demonstrate time management skills.

### Communication Skills

You need to demonstrate an organized cohesive communication process as a senior candidate. Make sure that you do not rush into the design by talking too quickly or too much. You need to be able to collaborate with the interviewer. Sometimes, you will receive some feedback from the interviewer and you might need to respond to his ideas. I have noticed that interviewers are willing to help you in the interview, but relying too much on their feedback can sometimes result in negative feedback. The interviewer might try to direct you in the right direction by saying something like "What if you use a queue here?" or something like "How do you handle the tight coupling between system A and system B?". When you hear something like this, you might need to respond with details. Again, it depends whether you accept the interviewer's feedback or not, but you should be able to defend your point of view.

### Quick Thinking

In the interview, you're actually solving a complex problem and that means, you need to be able to respond to interviewer's question as well as think about your design as well. This is something you develop with practice, so take your time to prepare with other candidates before the interview. Having a clearly organized way to answer system design question as a whole can also help you better prepare for the interview.

### Asking Good Questions

The system design interviews start with a vague requirement. This is the point where you need to ask clarifying questions with the interviewer. This demonstrates your attention to detail for a system you're designing. in general, all system design interviews start with question and answers between the interviewer and the candidate. At this stage, you should also start writing functional and non-functional requirements of a system you're designing.

### Performance Optimization

Once you've presented your system, you should always go back and suggest some improvements. No system is perfect and there will always be some form of improvements you can make. This section is what I call as performance optimization section. Usually, this should be the last stage of the discussion. This also demonstrates your depth of knowledge in specific topics.

## High Level Stages of Interview

I prefer to frame interview in following stages. These are not rigid set of steps but they help you be ready with a proper sequence of steps to follow in an interview.

1. Understand the problem statement
2. Ask clarifying questions to define functional and non-functional requirements.
3. Calculate system requirements. These include number of users, number of queries per second, storage requirements, etc.
4. When designing system, it's better to represent those systems using C4 models. These are divided into several layers. Inisially, you present high level diagram and APIs you need to support.
5. Next, you get deeper into the components you specified in the previous step. This is where you can go deeper and show the depth of knowledge in specific components while also clearly communicating what sequence of events occur with your system.
6. Deep Dive into specific sections of your system.
7. Performance optimization: This is where you can recommend some impreovements like using analytics or machine learning systems or caching data to support business growth.
8. Answer interviewer's questions.