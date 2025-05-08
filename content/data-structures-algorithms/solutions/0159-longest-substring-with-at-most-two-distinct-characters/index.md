---
title: "0159 Longest Substring With at Most Two Distinct Characters"
date: 2023-12-09T14:19:47-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing", "Sliding Window"]
languages: ["Java"]
---

## Description

Given a string `s`, return the length of the longest 
substring that contains at most two distinct characters.


### Example 1:

```
Input: s = "eceba"
Output: 3
Explanation: The substring is "ece" which its length is 3.
```

### Example 2:

```
Input: s = "ccaabbb"
Output: 5
Explanation: The substring is "aabbb" which its length is 5.
```

### Constraints:

- `1 <= s.length <= 10^5`
- `s` consists of English letters.

## Solution

This also looks like sliding window problem. In order to track 2 distinct characters, we can use `HashMap` to store those characters as keys. As long as keys count is less or equal to 2, we can continue counting the longest substring. When it becomes more than 2, our window becomes invalid, at this point, we have to remove the characters located at `left` pointer.

```java
class Solution {
    public int lengthOfLongestSubstringTwoDistinct(String s) {
        if (s.length() < 3)
            return s.length();
        int left = 0, right = 0, maxLength = 0;
        Map<Character, Integer> map = new HashMap<>();
        while (right < s.length()) {
            char c = s.charAt(right);
            map.put(c, map.getOrDefault(c, 0) + 1);
            while (map.size() > 2) {
                char leftChar = s.charAt(left);
                map.put(leftChar, map.get(leftChar) - 1);
                if (map.get(leftChar) == 0) {
                    map.remove(leftChar);
                }
                left++;
            }
            maxLength = Math.max(maxLength, right - left + 1);
            right++;
        }
        return maxLength;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)` since we can have at most 3 keys in HashMap before we start reducing its size.