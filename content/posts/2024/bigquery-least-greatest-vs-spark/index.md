---
title: "Resolve Maven Error Invalid Target Release 17"
date: 2024-05-09T10:07:09-04:00
draft: false
categories: ["SQL"]
tags: ["BigQuery"]
languages: ["SQL"]
---

BigQuery has `LEAST` and `GREATEST` functions which can be used to find minimum and maximum value across multiple columns. This can be handy when you're building user's spend progression or user's order counts etc. You always want to find the latest order amount from the user.

<!--more-->

In this tutorial, I want to explain some of the caveats when you're migrating SQL statements from Spark/Hive into BigQuery SQL. This is one of the projects I'm working on at the moment.

## Introduction

The project I have builds user snapshots. That is what's the latest order amount for the user or what is the latest session timestamp for each user in our website. For this, the design is such as every hour, we calculate `MIN` and `MAX` for these values and they are combined with existing snapshot of the user. So, the SQL would look something like this in Spark.

For demonstration, I have created existing aggregation as `user_orders` and last hour aggregations as `per_hour_orders`. The timestamp values are stored as seconds from the epoch time.

