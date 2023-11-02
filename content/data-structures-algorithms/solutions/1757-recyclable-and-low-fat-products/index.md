---
title: "1757 Recyclable and Low Fat Products"
date: 2023-10-09T18:41:06-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Databases"]
ideas: []
languages: ["SQL"]
---

## Description:

Table: Products

| Column Name | Type    |
|:------------|:--------|
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |

`product_id` is the primary key for this table.
`low_fats` is an ENUM of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
`recyclable` is an ENUM of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.


Write an SQL query to find the ids of products that are both low fat and recyclable.

Return the result table in any order.

The query result format is in the following example.

### Example 1:

**Input:**

`Products` table:

| product_id  | low_fats | recyclable |
|:------------|:---------|:-----------|
| 0           | Y        | N          |
| 1           | Y        | Y          |
| 2           | N        | Y          |
| 3           | Y        | Y          |
| 4           | N        | N          |

**Output:**

| product_id  |
|:------------|
| 1           |
| 3           |

**Explanation:** Only products 1 and 3 are both low fat and recyclable.

## Solution

```sql
SELECT product_id FROM Products WHERE low_fats = 'Y' AND recyclable = 'Y';
```
