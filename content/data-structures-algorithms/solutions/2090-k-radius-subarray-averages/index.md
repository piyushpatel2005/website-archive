---
title: "2090 K Radius Subarray Averages"
date: 2023-10-27T15:23:10-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Preprocessing", "Prefix Sum", "Sliding Window"]
languages: ["Java"]
---

## Description

You are given a 0-indexed array `nums` of `n` integers, and an integer `k`.

The k-radius average for a subarray of `nums` centered at some index `i` with the radius `k` is the average of all elements in nums between the indices `i - k` and `i + k` (inclusive). If there are less than `k` elements before or after the index `i`, then the k-radius average is `-1`.

Build and return an array `avgs` of length `n` where `avgs[i]` is the k-radius average for the subarray centered at index `i`.

The average of `x` elements is the sum of the `x` elements divided by `x`, using integer division. The integer division truncates toward zero, which means losing its fractional part.

For example, the average of four elements `2`, `3`, `1`, and `5` is `(2 + 3 + 1 + 5) / 4 = 11 / 4 = 2.75`, which truncates to `2`.

### Example 1:

**Input:** nums = `[7,4,3,9,1,8,5,2,6]`, `k = 3`

**Output:** `[-1,-1,-1,5,4,4,-1,-1,-1]`

**Explanation:**
- `avg[0]`, `avg[1]`, and `avg[2]` are `-1` because there are less than k elements before each index.
- The sum of the subarray centered at index 3 with radius 3 is: `7 + 4 + 3 + 9 + 1 + 8 + 5 = 37`.
  Using integer division, `avg[3] = 37 / 7 = 5`.
- For the subarray centered at index 4, `avg[4] = (4 + 3 + 9 + 1 + 8 + 5 + 2) / 7 = 4`.
- For the subarray centered at index 5, `avg[5] = (3 + 9 + 1 + 8 + 5 + 2 + 6) / 7 = 4`.
- `avg[6]`, `avg[7]`, and `avg[8]` are `-1` because there are less than `k` elements after each index.

### Example 2:

**Input:** `nums = [100000]`, `k = 0`

**Output:** `[100000]`

**Explanation:**
- The sum of the subarray centered at index 0 with radius 0 is: 100000.
  `avg[0] = 100000 / 1 = 100000`.

### Example 3:

**Input:** `nums = [8]`, `k = 100000`

**Output:** `[-1]`

**Explanation:** 
- `avg[0]` is -1 because there are less than `k` elements before and after index 0.
 
### Constraints:

- `n == nums.length`
- `1 <= n <= 10^5`
- `0 <= nums[i]`, `k <= 10^5`

## Solution
### Using Prefix Sum (Preprocessing) technique

This is prefix sum problem because we are required to find the sum of subarrays multiple times.
In this case, if `i - k < 0` then we have to add -1. Similarly, if `i + k >= nums.length` then also we have to add -1.
For numbers in between, these two range, we want to find below. One of the constraints is that the number can be upto 100000 and length of array can be 100000 as well. In this case, it may overflow Integer limits. So, we have to use `Long` data type for calculating sum of our window just in case the window is large enough to cross `Integer` boundaries. We will also have one more element in prefix sum to make it easier to calculate average in the middle.

The pseudocode would look like this.

```pseudocode
Define sum array with same size as nums + 1
sum[0] = 0
for i = 0; i < nums.length; i++
    sum[i + 1] = sum[i] + nums[i];
averages = new int[nums.length]
for i = 0; i < nums.length; i++
    if (i - k >= 0 AND i + k < nums.length)
        averages[i] = int()((sum[i + k + 1] - sum[i - k]) / (2 * k + 1))
return averages
```

The code for this logic looks like below.

```java
class Solution {
    public int[] getAverages(int[] nums, int k) {
        long[] sum = new long[nums.length + 1];
        for (int i = 0; i < nums.length; ++i) {
            sum[i + 1] = sum[i] + nums[i];
        }
        System.out.println(Arrays.toString(sum));
        int[] averages = new int[nums.length];
        Arrays.fill(averages, -1);
        for (int i = 0; i < nums.length; ++i) {
            if (i - k >= 0 && i + k < nums.length) {
                averages[i] = (int) ((sum[i + k + 1] - sum[i - k]) / (2 * k + 1));
            }
        }
        System.out.println(Arrays.toString(averages));
        return averages;
    }
}
```

### Using Sliding Window technique

Now, if we think of this problem from different perspective, it can also be solved using Sliding window where our window is valid as long as the number of elements are within `i -k` and `i + k`. So, we can use sliding window to calculate the sum of elements between those window and in next iteration calculate the average.

```java
class Solution {
    public int[] getAveragesUsingSliding(int[] nums, int k) {
        int left = 0, right = 0;
        long currentSum = 0;
        int i = 0;
        long[] sum = new long[nums.length];
        while (right < nums.length) {
            currentSum += nums[right];
            sum[right] = -1;
            if (right - left == 2*k) {
                sum[i + k] = currentSum;
                i++;
                currentSum -= nums[left];
                left++;
            }
            right++;
        }
        right = 0;
        int[] averages = new int[nums.length];
        while (right < nums.length) {
            if (sum[right] != -1) {
                averages[right] = (int) (sum[right] / (2 * k + 1));
            } else {
                averages[right] = -1;
            }
            right++;
        }
        return averages;
    }
}
```

If we look at athese carefully, they are doing almost similar task except that in the first iteration we are calculating sum and in the next iteration we are calculating average. This reduces time to solution but time complexity still remains `O(n)`. We can reduce space as well by removing unnecessary `sum` variable and directly calculate `average`. We can remove one of the iterations as well if we do both in single iteration. Again, ensure that `currentSum` variable is of type `long` and not `int` otherwise it may overflow.

```java
class Solution {
    public int[] getAveragesUsingSliding(int[] nums, int k) {
        int left = 0, right = 0;
        long currentSum = 0;
        int i = 0;
        int[] averages = new int[nums.length];
        while (right < nums.length) {
            currentSum += nums[right];
            averages[right] = -1;
            if (right - left == 2 * k) {
                averages[i + k] = (int) (currentSum / (2*k + 1));
                i++;
                currentSum -= nums[left];
                left++;
            }
            right++;
        }
        System.out.println(Arrays.toString(averages));
        return averages;
    }
}
```

We can still remove `i` variable because we are using that as an additional value to easily track where to insert new elements. We can do something like below to remove `i`.

```java
averages[k + left] = (int) (currentSum / (2*k + 1));
```