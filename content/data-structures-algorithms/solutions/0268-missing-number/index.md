---
title: "0268 Missing Number"
date: 2023-12-03T15:22:28-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

Given an array `nums` containing `n` distinct numbers in the range `[0, n]`, return the only number in the range that is missing from the array.

 
### Example 1:

```
Input: nums = [3,0,1]
Output: 2
Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.
```

### Example 2:

```
Input: nums = [0,1]
Output: 2
Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.
```

### Example 3:

```
Input: nums = [9,6,4,2,3,5,7,0,1]
Output: 8
Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.
``` 

Constraints:

- `n == nums.length`
- `1 <= n <= 10^4`
- `0 <= nums[i] <= n`
- All the numbers of `nums` are unique.
 
**Follow up:** Could you implement a solution using only O(1) extra space complexity and O(n) runtime complexity?

## Solution

### 1. Brute force 

This problem can be solved in so many way. The easiest or brute force approach will be to sort the array and then iterate through each element of the array, checking which element is missing in the array.

```java
class Solution {
    public int missingNumber(int[] nums) {
        Arrays.sort(nums);
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] != i)
                return i;
        }
        return nums.length;
    }
}
```

In this case, sorting operation requires space, so the overall complexity analysis is as below.

- Time Complexity: `O(n log n)`
- Space Complexity: `O(log n)`

### 2. Using Array

In this case, we can create a brand new array to store each element at their respective position. Because we can have numbers from `0` upto `n` inclusive, we have to have array of size which is `n + 1`. In first iteration, we insert each element into their correct position. In the next iteration, we check which position is having the default value and not the actual value.

```java
class Solution {
    public int missingNumber(int[] nums) {
        int[] result = new int[nums.length + 1];
        for (int i = 0; i < nums.length; i++) {
            result[nums[i]] = 1;
        }

        for (int i = 0; i < result.length; i++) {
            if (result[i] == 0)
                return i;
        }
        return -1;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`

### 3. Using Hashing

Another easiest approach is to store all numbers in `HashMap` or `HashSet` and then verify if each number exists in this set. Because inserting elements will take `O(n)` time, it will have overall time complexity of `O(n)`. To avoid compilation error, we have to return `-1` but as per problem statement, there will always be a number missing.

```java
class Solution {
    public int missingNumber(int[] nums) {
        Set<Integer> set = new HashSet<>();
        for (int num: nums) {
            set.add(num);
        }

        for (int i = 0; i <= nums.length; i++) {
            if (!set.contains(i))
                return i;
        }
        return -1;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`

### 4. Using Arithmetic Operation

Now, if we have all numbers from `0...n`, from mathematical operation, their sum will be equal to `n * (n + 1) / 2`. So, if any number is missing, we will have sum equal which is less by the `missingNumber` from the expected sum. This property we can use in order to reach our solution.

```java
class Solution {
    public int missingNumber(int[] nums) {
        int sum = 0;
        for (int i = 0; i < nums.length; i++)
            sum += nums[i];

        int n = nums.length;
        int expectedSum = n * (n + 1) / 2;
        return expectedSum - sum;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity; `O(1)`

### 5. Using Bit Manipulation

This might be difficult to visualize but in mathematics, XOR operation has several important properties.

1. If we XOR the number with itself, we get value `0`
2. If we XOR the number with `0`, we get the number itself.

Using these properties, if we XOR all elements with each other along with their indices which will be from `0` to `n` only, we are expected to reach the final missing number.

```java
class Solution {
    public int missingNumber(int[] nums) {
        int missingNumber = nums.length;
        for (int i = 0; i < nums.length; i++) {
            missingNumber = missingNumber ^ i ^ nums[i];
        }
        return missingNumber;
    }
}
```