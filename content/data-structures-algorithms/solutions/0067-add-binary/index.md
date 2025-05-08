---
title: "0067 Add Binary"
date: 2023-11-12T14:37:18-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Array"]
languages: ["Java"]
---

## Description

Given two binary strings `a` and `b`, return their sum as a binary string.

### Example 1:

```
Input: a = "11", b = "1"
Output: "100"
```

### Example 2:

```
Input: a = "1010", b = "1011"
Output: "10101"
```

### Constraints:

- `1 <= a.length, b.length <= 10^4`
- `a` and `b` consist only of '0' or '1' characters.
- Each string does not contain leading zeros except for the zero itself.

## Solution 

This is not straight forward and requires complicated logic for binary addition. One simple solution would be use to Integer addition. We can use `Integer` class with `radix=2` to add binary numbers. 

```java
class Solution {
    public String addBinary2(String a, String b) {
        if (a == null || b == null)
            return null;
        if (a.length() == 0)
            return b;
        if (b.length() == 0)
            return a;
        Integer aInt = Integer.parseInt(a, 2);
        Integer bInt = Integer.parseInt(b, 2);
        return Integer.toString(aInt + bInt, 2);
    }
}
```

However, this may overflow `Integer` maximum limits. So, we have to use `BigInteger` class to replace Integer as shown in below snippet. 

```java
        BigInteger aInt = new BigInteger(a, 2);
        BigInteger bInt = new BigInteger(b, 2);
        return aInt.add(bInt).toString(2);
```

Another option is to use complicated arithmetic.

```java
class Solution {
    public String addBinary(String a, String b) {
        StringBuilder sb = new StringBuilder();
        for (int i = a.length() - 1, j = b.length() - 1, carry = 0; i >= 0 || j >= 0 || carry > 0; i--, j--) {
            if (i >= 0)
                carry += a.charAt(i) - '0';
            else
                carry += 0;
            if (j >= 0)
                carry += b.charAt(j) - '0';
            else
                carry += 0;
            sb.append(carry % 2);
            carry = carry / 2;
        }
        return sb.reverse().toString();
    }
}
```