---
title: "0451 Sort Characters by Frequency"
date: 2023-12-27T03:29:01-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing", "Sorting"]
languages: ["Java"]
---

## Description

Given a string `s`, sort it in decreasing order based on the frequency of the characters. The frequency of a character is the number of times it appears in the string.

Return the *sorted string*. If there are multiple answers, return any of them.


### Example 1:

```
Input: s = "tree"
Output: "eert"
Explanation: 'e' appears twice while 'r' and 't' both appear once.
So 'e' must appear before both 'r' and 't'. Therefore "eetr" is also a valid answer.
```

### Example 2:

```
Input: s = "cccaaa"
Output: "aaaccc"
Explanation: Both 'c' and 'a' appear three times, so both "cccaaa" and "aaaccc" are valid answers.
Note that "cacaca" is incorrect, as the same characters must be together.
```

### Example 3:

```
Input: s = "Aabb"
Output: "bbAa"
Explanation: "bbaA" is also a valid answer, but "Aabb" is incorrect.
Note that 'A' and 'a' are treated as two different characters.
``` 

### Constraints:

- `1 <= s.length <= 5 * 10^5`
- `s` consists of uppercase and lowercase English letters and digits.

## Solution

This problem is slightly complex than usual ones. In this case, we want to sort by character frequency which means first we need to find the frequency of each characters and store them in a map called `frequencyMap`. The next part is to sort this by frequency which means we have to convert frequency values to a List and sort them into descending order or rather sort the keys based on their values. In this we can use custom `sort` method which will sort by the values in `frequencyMap`.

Next part is to build the string from these characters based on their frequency. String is immutable which means we cannot perform operation like `s = s + 'a'`. It will work but it would end up consuming lots of extra memory and will require lot more operations. Instead of this, we could use `StringBuffer` or `StringBuilder` to build our string from the character list.

The difference between `StringBuffer` and `StringBuilder` is that `StringBuffer` is thread-safe option but can be little slower than `StringBuilder`.

```java
class Solution {
    public String frequencySort(String s) {
        Map<Character, Integer> frequencyMap = new HashMap<>();
        for (char c : s.toCharArray()) {
            frequencyMap.put(c, frequencyMap.getOrDefault(c, 0) + 1);
        }

        Set<Character> keySet = frequencyMap.keySet();
        List<Character> charactersList = new ArrayList<>(keySet);
        charactersList.sort((a, b) -> frequencyMap.get(b) - frequencyMap.get(a));

        StringBuilder sb = new StringBuilder();
        for (char c : charactersList) {
            int count = frequencyMap.get(c);
            while (count > 0) {
                sb.append(c);
                count--;
            }
        }
        return sb.toString();
    }
}
```

To use `StringBuffer`, we can use similar code as shown in below snippet instead of creating instance of `StringBuilder`. Everything else remains same.

```java
StringBuffer sb = new StringBuffer();
```

- Time Complexity: In this solution, creation of `frequencyMap` can take upto `O(n)`. Next sorting of the List is of time complexity `O(k log k)` where `k` is the number of keys in `frequencyMap`. In worst case, if all characters are unique, it can be upto `O(n log n)`. Next building the string using `StringBuilder` requires iterating through `charactersList` which can be of length `k` if there are `k` unique keys in `frequencyMap`. Again, this may take up to `O(n)` time. So, overall time complexity is `O(n log n)`.
- Space Complexity: Building `HashMap` is `O(k)` with `k` unique characters. Next, building string is `O(n)`. So, overall space complexity is `O(n)`.