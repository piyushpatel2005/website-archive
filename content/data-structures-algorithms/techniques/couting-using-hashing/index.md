---
title: "Couting Using Hashing"
date: 2023-12-04T23:10:53-05:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
ideas: ["Hashing"]
---

HashMap and Hash set are great data structures when we have to count occurrences of something. In this technique, we will see various kind of problems which might be solved easily with HashMap or HashSet.

<!--more-->

## Problem Pattern 1

Some of the problems might ask you to check the frequency of all elements of the input array of string. For counting frequency of anything, `HashMap` can be a great choice because we can retrieve their frequency very easily. Here is how you can calculate the frequency of all words in a sentence using `HashMap` in Java. Other programming languages also have similar way to put and retrieve this information from similar hash based data structures.

```java
class Counter {
    public Map<String, Integer> countFrequency(String[] arr) {
        Map<String, Integer> result = new HashMap<>();
        for (String s : arr) {
            result.put(s, result.getOrDefault(s, 0) + 1);
        }
        return result;
    }
}
```

This is very fundamental problem that can be solved using `HashMap` is counting the frequency of each letter or each word in a sentence. In this case, the algorithm might be as simple as adding a key with value as 1 or update the existing value by incrementing it by 1. This is very trivial computer science problem.

Example: [Check If all Characters Have Equal Number of Occurrences](../../solutions/1941-check-if-all-characters-have-equal-number-of-occurrences/)

## Pattern 2: count with some constraints

One of the patterns of problems we saw which could be solved using sliding window was that of finding longest length of substrings containing at most `k` 0s. Similarly, if the problem was asking to find longest substring containing at most `k` distinct characters, this would bring the use of `HashMap` Let's see an example of this problem. Suppose you're given an input string `s = "ababdck` and `k=2`, then in this case the longest substring will be `"abab"` which has a length of 4. So, the answer will be `4`. This problem uses combination of `HashMap` with sliding window. In this case, the window becomes invalid when we have number of unique characters greater than 2. We can count number of unique characters using `HashMap` so, when this `HashMap` key set has more than `k` keys, the window becomes invalid. Again, we can find the length of the current window using `right - left + 1`.

Example 1: [Longest Substring with At Most K Distinct Characters](../../solutions/0340-longest-substring-with-at-most-k-distinct-characters/)

Example 2: [Longest Substring with At Most Two Distinct Characters](../../solutions/0159-longest-substring-with-at-most-two-distinct-characters/)

## Pattern 3: Number of subarrays with exact constraint

Another pattern similar to above pattern. It is to find all subarrays from the input array that have some exact constraint. For example, find number of subarrays that have let's say exact sum of some value `k`.

This could be solved using prefix sum along with HashMap. At each iteration, we calculate the prefix sum of the array we have seen so far. We add the frequency of those sum into a hash map. At each step, we can see if we have seen a number which will be less than current sum by amount `k`. That is we look for previous prefix sum where it has a value of `sum - k`. Now, there can be more than one occurrences of such a value, that means there were more than one subarrays which would have satisfied our condition. For example, array with values `nums = [1, 1, -1, 4, -3, 7]` we would get prefix sum of `[1, 2, 1, 5, 2, 9]`. Let's say our target was `k=1`, then we see that we had 5 different combinations which would result in subarray sum of `1`. These would be `[[1], [1], [1, 1, -1], [4, -3], [1, -1, 4, -3]]`. In prefix sum, at each stage, we have to check if we have seen `sum - k`. If we have seen that number, then we need to add the frequency of such number before this number. For example, at index position 4, we have seen `1` two times earlier, so, we have to perform `count += 2`.

Example 1: [Subarray sum equal to K](../../solutions/0560-subarray-sum-equals-k/)

If the problem asks us to find subarrays which have `k` number of odd elements into it, then we have to convert our prefix sum to track odd elements. What we put in prefix sum depends on the constraint we are given.

Example 2: [Count Number of Nice Subarrays](../../solutions/1248-count-number-of-nice-subarrays/)