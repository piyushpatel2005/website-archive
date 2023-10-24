---
title: "1456 Maximum Number of Vowels in Substring"
date: 2023-10-23T17:04:39-04:00
draft: true
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Sliding Window"]
languages: ["Java"]
---

## Description

Given a string `s` and an integer `k`, return the maximum number of vowel letters in any substring of `s` with length `k`.

Vowel letters in English are 'a', 'e', 'i', 'o', and 'u'.

### Example 1:

**Input:** `s = "abciiidef"`, `k = 3`

**Output:** `3`

**Explanation:** The substring "iii" contains 3 vowel letters.

### Example 2:

**Input:** `s = "aeiou"`, `k = 2`

**Output:** `2`

**Explanation:** Any substring of length 2 contains 2 vowels.

### Example 3:

**Input:** `s = "leetcode"`, `k = 3`

**Output:** `2`

**Explanation:** "lee", "eet" and "ode" contain 2 vowels.
 
### Constraints:

- `1 <= s.length <= 10^5`
- `s` consists of lowercase English letters.
- `1 <= k <= s.length`

## Solution

This problem can be solved using sliding window with two pointers. We can start by two pointers `left = right = 0`. As long as `right <= s.length()` we can iterate through all possible substrings of length `k`. We also initialize `currentVowelsCount = 0` and `maxVowels = 0` at the beginning. Every time we add a new character using `right` index position, we increment `currentVowelsCount` by 1 and when the size is `k`, we check it against existing `maxVowels` and replace the value if `currentVowelsCount` is greater than existing `maxVowels`. In this case, we can use fixed window of length `k` and we have to count the number of vowels as we add more characters into our window. Once we have reached the specified size, we also have to remove one elements which can be done by `left++`

```markdown
left = right = 0 = currentVowelsCount = 0
maxVowels = minimum possible value
for right = 0; right less than s.length(); right++
    if s[right] is vowel
        currentVowelsCount += s[right]
    if (right - left + 1 == k)
        maxVowels = max of maxVowels and currentVowelsCount
        if s[left] is vowel
            currentVowelsCount -= s[left]
        left++
return maxVowels
```

```java
class Solution {
    public int maxVowels(String s, int k) {
        if (s == null || s.length() == 0) return 0;
        int left = 0, currentVowelsCount = 0;
        int maxVowelsCount = Integer.MIN_VALUE;
        for (int right = 0; right < s.length(); right++) {
            if (s.charAt(right) == 'a' || s.charAt(right) == 'e' || s.charAt(right) == 'i' || s.charAt(right) == 'o' || s.charAt(right) == 'u') {
                currentVowelsCount++;
            }
            if (right - left + 1 == k) {
                maxVowelsCount = Math.max(maxVowelsCount, currentVowelsCount);
                if (s.charAt(left) == 'a' || s.charAt(left) == 'e' || s.charAt(left) == 'i' || s.charAt(left) == 'o' || s.charAt(left) == 'u') {
                    currentVowelsCount--;
                }
                left++;
            }
        }
        return maxVowelsCount;
    }
}
```