---
title: "0013 Roman to Integer"
date: 2023-12-10T16:13:37-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Roman numerals are represented by seven different symbols: `I`, `V`, `X`, `L`, `C`, `D` and `M`.

| Symbol | Value |
|:-------|:------|
| I      | 1     |
| V      | 5     |
| X      | 10    |
| L      | 50    |
| C      | 100   |
| D      | 500   |
| M      | 1000  |

For example, `2` is written as `II` in Roman numeral, just two ones added together. `12` is written as `XII`, which is simply `X + II`. The number `27` is written as `XXVII`, which is `XX + V + II`.

Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not `IIII`. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as `IX`. There are six instances where subtraction is used:

- `I` can be placed before `V` (5) and `X` (10) to make 4 and 9. 
- `X` can be placed before `L` (50) and `C` (100) to make 40 and 90. 
- `C` can be placed before `D` (500) and `M` (1000) to make 400 and 900.

Given a roman numeral, convert it to an integer.

### Example 1:

```
Input: s = "III"
Output: 3
Explanation: III = 3.
```

### Example 2:

```
Input: s = "LVIII"
Output: 58
Explanation: L = 50, V= 5, III = 3.
```

### Example 3:

```
Input: s = "MCMXCIV"
Output: 1994
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
```

### Constraints:

- `1 <= s.length <= 15`
- `s` contains only the characters `('I', 'V', 'X', 'L', 'C', 'D', 'M')`.
- It is guaranteed that `s` is a valid roman numeral in the range `[1, 3999]`.

## Solution

To find the decimal number, we can simple store the conversion characters in a `HashMap`. The benefit is that everytime we want to look up value, it is constant time. Next we iterate through each characters of the string `s` from left to right. If it's first character, we simply add it as it is. For all other numbers, we check if `previous` numbers is less than `current` character. When this happens, we actually need to deduct `current - 2 * previous` from running sum. The problem states that we have a valid roman number. That means, every time we see the next number being greater than previous number from left, it needs previous number to be deducted from the sum. We will have to add amount equal to `current - 2 * previous` because in the previous iteration, we had added `previous` value accidentally without knowing the next number. The numbers are valid, that means we have not seen more than one number lower than `current` one. For example, there is no valid number like `IIV` or `IIX`.

Based on these ideas, our solution looks like this.


```java
class Solution {
    public int romanToInt(String s) {
        Map<Character, Integer> romanToInteger = new HashMap<>();
        romanToInteger.put('I', 1);
        romanToInteger.put('V', 5);
        romanToInteger.put('X', 10);
        romanToInteger.put('L', 50);
        romanToInteger.put('C', 100);
        romanToInteger.put('D', 500);
        romanToInteger.put('M', 1000);
        int sum = 0;
        int previous = 0;
        for (int i = 0; i < s.length(); i++) {
            int current = romanToInteger.get(s.charAt(i));
            System.out.println("current: " + current + ", previous: " + previous);
            if (i != 0 && current > previous) {
                sum += (current - 2 * previous);
            } else {
                sum += current;
            }
            previous = current;
        }
        return sum;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)` because we have only 7 roman characters that we store in our `HashMap`.