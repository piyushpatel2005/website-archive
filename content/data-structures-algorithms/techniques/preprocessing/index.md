---
title: "Preprocess Elements"
date: 2023-10-24T05:09:27-04:00
draft: false
categories: ["Coding Interview"]
topics: ["Programming"]
ideas: ["Preprocessing"]
---

In this tutorial, we are going to talk about a very commonly known technique of preprocessing. This is widely used in data processing and can be applied in algorithmic problems to solve them with `O(n)` time complexity. This is the best we can achieve with this.
<!--more-->

There are several variations of this technique and this can be applied to sequence data types (strings, arrays, lists) in general. Pre-processing is a very useful technique which can be applied to various problems. In this case, we are storing pre-computed data in a data structure before running solving the problem.

## 1. Sum
The idea is to create a new array which contains the sum of previous elements at a given index. For example, for new array `sum` created from `nums` array, `sum[i]` will be equal to all sum of all elements of `nums` where `i` is greater than 0 and less than or equal to `i`. Let's take a hypothetical example.

We have `nums = [3, 2, 5, 3, 1]`. 
For this we can create new `sum` array which will have elements `[3, 5, 10, 13, 14]`. These are created by summing all elements of `nums`.

```java
sum[0] = nums[0]
sum[1] = nums[0] + nums[1]
sum[2] = nums[0] + nums[1] + nums[2]
```

With this newly created array, it becomes relatively easier to answer some problems. One such problem is finding the sum of subarray between index 5 and 3. This can be easily found even without `sum` array, but if we are asked to find difference of `nums[3:5] - nums[1:3]`. In this case, we may have to iterate through elements twice

### How to build this array

for building this initial array, it will take linear time complexity. However, once it's built, we won't need to recalculate or iterate through elements of original array to answer certain questions. The algorithm for building this array looks like this.

Initially we start with empty array. The first element of this new array will be same as the input array. Starting from index position 1, the element will be equal to `nums[i] + sum[i - 1]`. Now, because our `sum` array includes sum of elements up to previous element, it works well.

```markdown
Start at the zero index of the input array
sum[0] = nums[0]
for (int i = 1; i < nums.length; i ++)
    sum[i] = nums[i] + sum[i - 1]
```

It costs us to build this preprocessed array. However, once processed, we can answer multiple queries of same type involving subarray problems. So, it can improve the performance of the algorithm by `n`.

### Problem: 
Given an integer array `nums`, find sum of subarrays represented by `subarrays = [[0, 3], [2, 4], [1, 5]]`.

In this case, we want to answer multiple subarray problems. So, building up `sums` array might make more sense. Building that array would cost us `O(n)` where `n = length of the input array`, but going forward alls these `subarrays` sum can be answered in `O(1)` time.

Now, to find the sum of elements between `[i, j]` pair from `subarrays`, we can use this equation `sums[j] - sums[i] + nums[i]`. So, in this case, for each pair of `subarrays`, we have to store the sum of all those subarrays in new array `answer` and finally return it.

```console
Initialize sums array with size = nums.length
sums[0] = nums[0]
for i = 1; i < nums.length; i++
    sums[i] = sums[i - 1] + nums[i]
Initialize result array with same size as subarrays
for int i = 0; i < subarrays.length; i++
    result[i] = sums[subarrays[i][1]] - sums[subarrays[i][0]] + nums[subarrays[i][0]]
return result
```

```java
class Solution {
    public int[] sumOfSubarrays(int[] nums, int[][] subarrays) {
        if (nums.length == 0 || subarrays.length == 0) {
            return new int[0];
        }
        int[] sums = new int[nums.length];
        sums[0] = nums[0];
        for (int i = 1; i < nums.length; i++) {
            sums[i] = sums[i - 1] + nums[i];
        }
        int[] answer = new int[subarrays.length];
        for (int i = 0; i < subarrays.length; i++) {
            answer[i] = sums[subarrays[i][1]] - sums[subarrays[i][0]] + nums[subarrays[i][0]];
        }
        return answer;
    }
}
```

## Problem 2:

Another variation of the same problem might be to find all subarrays that satisfy certain condition. This condition may vary.
For example, given an integer numbers array `nums` and array of pairs representing `i` and `j` in `subarrays`, find all pairs from `subarrays` whose difference is less than a given `limit`.

Another variation could be to return another array which returns `true` if sum of subarray is greater than given `limit` or `false` otherwise.

```java
class Solution {
    public boolean[] sumOfSubarraysLessThanK(int[] nums, int[][] subarrays, int limit) {
        if (nums.length == 0 || subarrays.length == 0) {
            return new boolean[0];
        }
        int[] sums = new int[nums.length];
        sums[0] = nums[0];
        for (int i = 1; i < nums.length; i++) {
            sums[i] = sums[i - 1] + nums[i];
        }
        boolean[] result = new boolean[subarrays.length];
        for (int i = 0; i < subarrays.length; i++) {
            if (sums[subarrays[i][1]] - sums[subarrays[i][0]] + nums[subarrays[i][0]] < limit) {
                result[i] = true;
            }
        }
        return result;
    }
}
```

