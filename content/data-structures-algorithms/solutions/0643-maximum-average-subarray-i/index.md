---
title: "0643 Maximum Average Subarray I"
date: 2023-10-21T15:52:07-04:00
draft: true
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Sliding Window"]
languages: ["Java"]
---

## Description

You are given an integer array `nums` consisting of `n` elements, and an integer `k`.

Find a contiguous subarray whose length is equal to `k` that has the maximum average value and return this value. Any answer with a calculation error less than `10^-5` will be accepted.

### Example 1:

**Input:** nums = `[1,12,-5,-6,50,3]`, `k = 4`

**Output:** `12.75000`

**Explanation:** Maximum average is `(12 - 5 - 6 + 50) / 4 = 51 / 4 = 12.75`

### Example 2:

**Input:** `nums = [5]`, `k = 1`

**Output:** `5.00000`

### Constraints:

- `n == nums.length`
- `1 <= k <= n <= 105`
- `-10^4 <= nums[i] <= 10^4`

## Solution

This can be solved using sliding window. Here we are looking for fixed window size of `k` elements. However, we also need to know the sum of all `k` elements. So, we cannot start directly with initial values `left = 0` and `right = k - 1`. We also initialize our `maxAverage = Integer.MIN_VALUE` and `currentSum = 0` If we do that, then we have to calculate the sum of all elements between these two indices. So, we start from `left = right = 0` and calculate sum until we reach `k` elements window. When we have reached `k` elements, we calculate the sum of elements and calculate the current average using `currentSum / k`. If this is greater than our initial `maxAverage`, then we replace that value with our newly calculated `currentAverage`. At this stage, we have reached `k` elements, hence we have to remove one element from `left` in order to make our window size fixed. So, we remove one element from `currentSum` and increment `left` pointer. We also increment `right` outside this `if` condition to ensure that we actually terminate the `while` loop when we have last `k-1` elements left.

Also one more caveat with this problem is that we have to set the initial value of `maxAverage = Integer.MIN_VALUE`. For datatype double, the min value is actually positive. So, it will not replace `maxAverage` if we have average as negative value.

```markdown
left = right = 0
maxAverage = minimum possible value
currentSum = 0
currentAverage = minimum possible value
while right less than nums.length
    currentSum += nums[right]
    if (right - left + 1 == k)
        currentAverage = currentSum / k
        maxAverage = maximum between currentAverage and maxAverage
        currentSum -= nums[left]
        left++
    right++
return maxAverage
```


```java
class Solution {
    public double findMaxAverage(int[] nums, int k) {
        int left = 0, right = 0;
        int currentSum = 0;
        double maxAverage = Integer.MIN_VALUE;
        double currentAverage = Double.MIN_VALUE;
        while (right < nums.length) {
            currentSum += nums[right];
            if (right - left + 1 == k) {
                currentAverage = (double) currentSum / k;
                maxAverage = Math.max(maxAverage, currentAverage);
                currentSum -= nums[left];
                left++;
            }
            right++; // This has to be outside otherwise while loop will not terminate
        }
        return maxAverage;
    }
}
```