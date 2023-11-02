---
title: "0125 Valid Palindrome"
date: 2023-10-18T19:39:00-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

## Description

A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

Given a string `s`, return `true` if it is a palindrome, or `false` otherwise.

### Example 1:

**Input:** `s = "A man, a plan, a canal: Panama"`

**Output:** `true`

**Explanation:** "amanaplanacanalpanama" is a palindrome.

### Example 2:

**Input:** `s = "race a car"`

**Output:** `false`

**Explanation:** "raceacar" is not a palindrome.

### Example 3:

**Input:** `s = " "`

**Output:** `true`

**Explanation:** s is an empty string "" after removing non-alphanumeric characters.
Since an empty string reads the same forward and backward, it is a palindrome.
 

### Constraints:

- `1 <= s.length <= 2 * 10^5`
- `s` consists only of printable ASCII characters.

## Solution:

If we think about how we would do it, we can say, replace all non-alphanumerical characters from the string with empty string, convert the string to lowercase string and then check each characters. The last step can also be replaced with reverse the string and verify the strings are matching.

This approach will work like this.

```markdown
If string is null
    return true
Replace all non-alphanumeric characters with empty string
Convert uppercase to lowercase
Initialize two pointers left = 0, right = s.length() - 1
while left is less than right
    if s[left] != s[right]
        return false
    left++
    right--
return true
```


```java
class Solution {
    public boolean isPalindromeBrute(String s) {
        if (s == null)
            return true;
        s = s.replaceAll("[^a-zA-Z0-9]", "").toLowerCase();
        int left = 0, right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right))
                return false;
            left++;
            right--;
        }
        return true;
    }
}
```

## Better Solution

This could be solved using two pointers approach. One pointer starts from the end and another from the beginning. In this case, we can initialize `left = 0` and `right = s.length() - 1`.
If the character we have found at `left` or `right` index is not alphanumeric, then we just move on to the next index using `left++` or `right--`.
If both characters are alphanumeric, then we make each of them lowercase and then compare if they are same. If they are not same, we right away return `false`. If they are same, we increment `left` pointer and decrement `right` pointer to check the next characters. Once we have checked all characters and if we didn't find any mismatch, that means the string is palindrome.

```markdown
If s = null or s = ""
    return true
Initialize two pointers left = 0, right = s.length() - 1
while left is less than right
    leftChar = left.toCharacter
    rightChar = right.toCharacter
    if (leftChar is not alphanumeric)
        left++
    else if (rightChar is not alphanumeric) 
        right--
    else 
        if (leftChar.toLowerCase != rightChar.toLowerCase)
            return false
        left++
        right--
return true
```

```java
class Solution {
    public boolean isPalindrome(String s) {
        if (s == null || s.trim().length() == 0)
            return true;
        int left = 0, right = s.length() - 1;
        while (left < right) {
            char leftChar = s.charAt(left);
            char rightChar = s.charAt(right);
            if (!Character.isLetterOrDigit(leftChar)) {
                left++;
            } else if (!Character.isLetterOrDigit(rightChar)) {
                right--;
            } else {
                if (Character.toLowerCase(leftChar) != Character.toLowerCase(rightChar)) {
                    return false;
                }
                left++;
                right--;
            }
        }
        return true;
    }
}
```

