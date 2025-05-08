---
title: "0049 Group Anagrams"
date: 2023-12-23T19:41:30-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: [Medium"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given an array of strings `strs`, group the anagrams together. You can return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

### Example 1:

```
Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
```

### Example 2:

```
Input: strs = [""]
Output: [[""]]
```

### Example 3:

```
Input: strs = ["a"]
Output: [["a"]]
```

### Constraints:

- `1 <= strs.length <= 10^4`
- `0 <= strs[i].length <= 100`
- `strs[i]` consists of lowercase English letters.

## Solution

In this case, we want to group all anagrams into single List or array. All anagrams if sorted by their character will look exactly same. So, we can use this sorted word as the key for map and store all anagram words in the list as a value. If the string is sorted, the characters will always appear in the same order.

```java
class Solution {
    public List<List<String>> groupAnagrams(String[] strs) {
        if (strs == null || strs.length == 0) {
            return new ArrayList<>();
        }
        Map<String, List<String>> groups = new HashMap<>();
        for (String str: strs) {
            char[] chars = str.toCharArray();
            Arrays.sort(chars);
            String key = String.valueOf(chars);
            if (!groups.containsKey(key)) {
                groups.put(key, new ArrayList<>());
            }
            groups.get(key).add(str);
        }
        return new ArrayList<>(groups.values());
    }
}
```

- Time Complexity: In this case, we iterate through `strs` array once to insert them into our map. For each insertion, we also have to sort each word in the `strs` array. Let's assume that maximum length of the word in the input array is of length `k`. Then, this sorting would take at most `O(k log k)` time complexity. So, the overall time complexity is `O(n * k log k)`
- Space Complexity: We will need to store all values of the `strs` array which would take `O(n)` and also keys in sorted manner which can take upto `O(k)`. Overall, space complexity is `O(n * k)`.