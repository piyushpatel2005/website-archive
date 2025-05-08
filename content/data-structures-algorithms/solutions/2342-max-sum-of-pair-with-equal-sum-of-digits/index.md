---
title: "2342 Max Sum of a Pair With Equal Sum of Digits"
date: 2023-12-24T02:20:40-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

You are given a 0-indexed array `nums` consisting of positive integers. You can choose two indices `i` and `j`, such that `i != j`, and the sum of digits of the number `nums[i]` is equal to that of `nums[j]`.

Return the maximum value of `nums[i] + nums[j]` that you can obtain over all possible indices `i` and `j` that satisfy the conditions.

### Example 1:

```
Input: nums = [18,43,36,13,7]
Output: 54
Explanation: The pairs (i, j) that satisfy the conditions are:
- (0, 2), both numbers have a sum of digits equal to 9, and their sum is 18 + 36 = 54.
- (1, 4), both numbers have a sum of digits equal to 7, and their sum is 43 + 7 = 50.
So the maximum sum that we can obtain is 54.
```

### Example 2:

```
Input: nums = [10,12,19,14]
Output: -1
Explanation: There are no two numbers that satisfy the conditions, so we return -1.
```

### Constraints:

- `1 <= nums.length <= 10^5`
- `1 <= nums[i] <= 10^9`

## Solution

This problem requires us to find the pair where the sum of those two pairs is largest. These two pairs should also have same sum of digits. We could potentially store digits sum as a key in HashMap and the values can have List of values which have the same sum. Ultimately, we may end up with lots of numbers of with same sum. Finally, we will have to iterate through this map and find the pairs where the sum is greatest.

Instead of storing all numbers with same sum, we could store only those two numbers which makes up largest sum. This way we will have only 2 possible numbers in the HashMap values.

```java
class Solution {
    public int maximumSum(int[] nums) {
        Map<Integer, List<Integer>> sumToNumbersMap = new HashMap<>();
        int maxSum = -1;
        for (int num: nums) {
            int sum = getSumOfDigits(num);
            // when making first entry, add the number to the list
            if (!sumToNumbersMap.containsKey(sum)) {
                List<Integer> list = new ArrayList<>();
                list.add(num);
                sumToNumbersMap.put(sum, list);
            } else {
                List<Integer> list = sumToNumbersMap.get(sum);
                if (list.size() == 2) {
                    // add the pairs which have the biggest sum
                    int first = list.get(0);
                    int second = list.get(1);
                    if (first < num && first < second) {
                        list.remove(0);
                        list.add(num);
                    } else if (second < num) {
                        list.remove(1);
                        list.add(num);
                    }
                } else {
                    list.add(num);
                }
                maxSum = Math.max(maxSum, list.get(0) + list.get(1));
            }
        }
        return maxSum;
    }

    private int getSumOfDigits(int num) {
        int sum = 0;
        while (num > 0) {
            int digit = num % 10;
            sum += digit;
            num = num / 10;
        }
        return sum;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`

### Another solution

Another solution is instead of storing the values as the two numbers with highest sum, we can simply store the highest value seen so far. That way we can check if the `currentNum + maxSeenSoFar` is greater than `maxSum`. If it is, we just update the `maxSum` with new value. Everytime, we get a value with the same sum, we have to add `maxSeenSoFar` with the value of the number which is largest between `currentNum` and `maxSeenSoFar`. The sum of two numbers will be the highest only when the numbers themselves are highest.

```java
class Solution {
    public int maximumSum (int[] nums) {
        Map<Integer, Integer> sumToMaxValue = new HashMap<>();
        int maxSum = -1;

        for (int num: nums) {
            int sumOfDigits = getSumOfDigits(num);
            if (!sumToMaxValue.containsKey(sumOfDigits)) {
                sumToMaxValue.put(sumOfDigits, num);
            } else {
                int maxSeenSoFar = sumToMaxValue.get(sumOfDigits);
                maxSum = Math.max(maxSum, maxSeenSoFar + num);
                sumToMaxValue.put(sumOfDigits, Math.max(maxSeenSoFar, num));
            }
        }
        return maxSum;
    }

    private int getSumOfDigits(int num) {
        int sum = 0;
        while (num > 0) {
            int digit = num % 10;
            sum += digit;
            num = num / 10;
        }
        return sum;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`