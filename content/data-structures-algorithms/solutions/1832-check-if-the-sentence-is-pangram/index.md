---
title: "1832 Check if the Sentence Is Pangram"
date: 2023-12-02T18:26:08-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing", "Array"]
languages: ["Java"]
---

## Description

A **pangram** is a sentence where every letter of the English alphabet appears at least once.

Given a string `sentence` containing only lowercase English letters, return `true` if `sentence` is a pangram, or `false` otherwise.


### Example 1:

```
Input: sentence = "thequickbrownfoxjumpsoverthelazydog"
Output: true
Explanation: sentence contains at least one of every letter of the English alphabet.
```

### Example 2:

```
Input: sentence = "leetcode"
Output: false
```

### Constraints:

- `1 <= sentence.length <= 1000`
- `sentence` consists of lowercase English letters.

## Solution

Here, the sentence consists of only lowercase English letters. That means there are no punctuations or spaces in the string `sentence`, so we will not have to filter them out, but if this constraint was not there, then we would have to filter out only alphabetic characters. Also ,the problem mentions this consists of only lowercase English letters which means we will not have to care too much about the case of each character. They are all of the same lowercase.

### 1. Brute Force

The brute force approach for this problem might be to iterate through each character in English alphabet and see if they exist in the current string. This will give us time complexity of `O(26 * n)` where `n` is the length of the `sentence`. The simplest optimization we can do is to check if the `sentence` is at least 26 characters long. If it's not, it will definitely not contain all 26 English lowercase letters.

```java
class Solution {
    public boolean checkIfPangram(String sentence) {
        if (sentence.length() < 26) {
            return false;
        }

        for (char c = 'a'; c <= 'z'; c++) {
            if (getIndex(sentence, c) < 0) {
                return false;
            }
        }

        return true;
    }

    private int getIndex(String sentence, char c) {
        for (int i = 0; i < sentence.length(); i++) {
            if (sentence.charAt(i) == c) {
                return i;
            }
        }
        return -1;
    }
}
```

Here, I have defined `getIndex()` method, we could also use `indexOf()` built-in method, but still the that would also take `O(n)` time resulting in time complexity of O(n ^ 2). To be specific in this case, `O(26 * n)`.

### 2. Using Array

In this case, we have to have all 26 characters of lowercase English letters. We can keep track of each character in an array data structure, tracking how many times a given character has occurred. This way storing this information is constant time and even retrieving this information is in constant time. However, we do use space of `O(26)` to store each character frequency. This algorithm gives us time complexity of `O(n)` even though we have two iterations in it, once through all characters of the `sentence` and second time through the array which stored the frequency of each character.

```java
class Solution {
    public boolean checkIfPangram(String sentence) {
        if (sentence.length() < 26) {
            return false;
        }

        int[] charCount = new int[26];
        for (int i = 0; i < sentence.length(); i++) {
            charCount[sentence.charAt(i) - 'a']++;
        }

        for (int i = 0; i < charCount.length; i++) {
            if (charCount[i] == 0) {
                return false;
            }
        }

        return true;
    }
}
```

### 3. Using Hashing

Another potentially cleaner approach would to iterate through `sentence`. In each iteration, we store the character in `HashMap` or `HashSet`. At the end, we have to verify that we have size equal to 26 which means all characters have occurred at least once. Below example uses `HashSet` but similar logic will apply to `HashMap` as well.

```java
class Solution {
    public boolean checkIfPangram(String sentence) {
        Set<Character> charSet = new HashSet<>();
        for (char c: sentence.toCharArray()) {
            charSet.add(c);
        }
        return charSet.size() == 26;
    }
}
```