---
title: "1748 Sum of Unique Elements"
date: 2023-12-27T01:04:01-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing", "Array"]
languages: ["Java"]
---

## Description

You are given an integer array `nums`. The unique elements of an array are the elements that appear exactly once in the array.

Return the **sum** of all the unique elements of `nums`.

### Example 1:

```
Input: nums = [1,2,3,2]
Output: 4
Explanation: The unique elements are [1,3], and the sum is 4.
```

### Example 2:

```
Input: nums = [1,1,1,1,1]
Output: 0
Explanation: There are no unique elements, and the sum is 0.
```

### Example 3:

```
Input: nums = [1,2,3,4,5]
Output: 15
Explanation: The unique elements are [1,2,3,4,5], and the sum is 15.
```

### Constraints:

- `1 <= nums.length <= 100`
- `1 <= nums[i] <= 100`

## Solution

This problem states that each number n `nums` is between 1 (inclusive) and 101 (exclusive). Also, the problem constraint states that `nums` is never an empty array.

### Brute Force approach

The brute force approach would iterate through all elements of the array `nums` and check if they exists second time in the array. If yes, ignore else add it to `sum` variable. This approach is not optimal as it has time complexity of `O(n^2)`.

```java
class Solution {
    public int sumOfUnique (int[] nums) {
        int sum = 0;
        for (int i = 0; i < nums.length; i++) {
            boolean isUnique = true;
            for (int j = 0; j < nums.length; j++) {
                if (i != j && nums[i] == nums[j]) {
                    isUnique = false;
                    break;
                }
            }
            if (isUnique)
                sum += nums[i];
        }
        return sum;
    }
}
```

- Time Complexity: `O(n^2)`
- Space Complexity: `O(1)`

### Using Array

In this case, we have only 100 unique numbers which we can easily accommodate in an array. We can use their respective indices to track the frequency of the number. Once we have populated this `frequency` array. We have to iterate through it and make sure that we add only those numbers whose frequency is exactly 1 to the `sum` variable. Finally, we return this `sum` variable.

```java
class Solution {
    public int sumOfUnique(int[] nums) {
        int[] frequency = new int[101];
        int sum = 0;
        for (int i = 0; i < nums.length; i++) {
            frequency[nums[i]]++;
        }
        for (int i = 0; i < frequency.length; i++) {
            if (frequency[i] == 1)
                sum += i;
        }
        return sum;
    }
}
```

- Time Complexity: The reading through array is constant time, however, there are two loops. So, it takes at least `O(n)` time complexity
- Space Complexity: We are creating an array of fixed size 101 which means space complexity is constant `O(1)`.

### Using Hashing

Another approach to solve the problem is to track the existence of each number in Hash data structure. First, we iterate through `nums` array to fill this HashMap `frequencyMap` with each number's frequency. For every new number, we add it to the map and if we see the number again, we update the frequency. Next, iterate through this map and sum all elements whose frequency is 1.

You might think `HashSet` might work. In that case, our code would look something like this.

```java
    public int sumOfUnique (int[] nums) {
        Set<Integer> unique = new HashSet<>();
        for (int num : nums) {
            if (!unique.contains(num))
                unique.add(num);
            else
                unique.remove(num);
        }
        int sum = 0;
        for (int num : unique) {
            sum += num;
        }
        return sum;
    }
```

However, with this approach, we might end up giving incorrect results for inputs like `[1, 1, 1, 1, 1]` because in this case, we will add and remove correctly as long as number is repeated even number of times. However, in this case, it's odd and at the last iteration, we will not have this number `1` present in the HashSet and we will add it incorrectly when it should have been ignored. So, we need `HashMap`.

```java
class Solution {
    public int sumOfUnique (int[] nums) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : nums) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
        }
        int sum = 0;
        for (int num : frequencyMap.keySet()) {
            sum += frequencyMap.get(num) == 1 ? num : 0;
        }
        return sum;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: In worst case, it can have upto 100 key-value pairs, so `O(1)`.