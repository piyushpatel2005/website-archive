---
title: "2389 Longest Subsequence With Limited Sum"
date: 2024-10-08T16:01:49-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["Java"]
---

## Description

You are given an integer array `nums` of length `n`, and an integer array `queries` of length `m`.

Return an array `answer` of length `m` where `answer[i]` is the maximum size of a subsequence that you can take from `nums` such that the sum of its elements is less than or equal to `queries[i]`.

A subsequence is an array that can be derived from another array by deleting some or no elements without changing the order of the remaining elements.

### Example 1:

```plaintext
Input: nums = [4,5,2,1], queries = [3,10,21]
Output: [2,3,4]
Explanation: We answer the queries as follows:
- The subsequence [2,1] has a sum less than or equal to 3. It can be proven that 2 is the maximum size of such a subsequence, so answer[0] = 2.
- The subsequence [4,5,1] has a sum less than or equal to 10. It can be proven that 3 is the maximum size of such a subsequence, so answer[1] = 3.
- The subsequence [4,5,2,1] has a sum less than or equal to 21. It can be proven that 4 is the maximum size of such a subsequence, so answer[2] = 4.
```

### Example 2:

```plaintext
Input: nums = [2,3,4,5], queries = [1]
Output: [0]
Explanation: The empty subsequence is the only subsequence that has a sum less than or equal to 1, so answer[0] = 0.
```

### Constraints:

- `n == nums.length`
- `m == queries.length`
- `1 <= n, m <= 1000`
- `1 <= nums[i], queries[i] <= 10^6`


## Solution

There are two ways to solve this which are better than brute force approach.

1. Sort and Count
2. Prefix Sum and Binary Search

### 1. Sort and Count

1. In this approach first sort the `nums` array. This way all elements are sorted from lowest to highest number. 
2. Initialize the `answer` array with the size of `queries` array.
3. Iterate over the `queries` array and for each `query[i]`, iterate over the sorted `nums` array and keep adding the elements to the `sum` until the `sum` of elements is less than or equal to the `query[i]`. Add the count of elements to the `answer[i]`.
4. Return the `answer` array.

```java
class Solution {
    public int[] answerQueries(int[] nums, int[] queries) {
        int count = 0;
        int sumSoFar = 0;
        int[] answer = new int[queries.length];
        Arrays.sort(nums);
        for (int i = 0; i < queries.length; i++) {
            int query = queries[i];
            for (int j = 0; j < nums.length; j++) {
                sumSoFar += nums[j];
                if (sumSoFar > query) {
                    break;
                } else {
                    count++;
                }
            }
            answer[i] = count;
            sumSoFar = 0;
            count = 0;
        }
        return answer;
    }
}
```

- Time Complexity: `O(n * m + n log(n))`. This is because we first sort the `nums` array which takes `O(n log(n))` time and then iterate over the `queries` array and for each query iterate over the `nums` array which takes `O(n * m)` time.
- Space Complexity: `O(m)`. We are using an additional array of size `m` to store the `answer`. The sorting itself may take `O(log n)` space. So, it's higher of the two values.

### 2. Prefix Sum and Binary Search

In this case, we will use the prefix sum and binary search to find the maximum size of the subsequence.

1. Sort the `nums` array.
2. Create a prefix sum array of the `nums` array where `prefixSum[i]` is the sum of elements from `0` to `i`.
3. Initialize the `answer` array with the size of `queries` array.
4. Iterate over the `queries` array and for each `query[i]`, find the index of the element in the `prefixSum` array which is less than or equal to the `query[i]`. This can be done using the binary search.
5. Return the `answer` array.

For example, for the input `nums = [4,5,2,1]` and `queries = [3,10,21]`, 

```java
nums = [1, 2, 4, 5]
prefixSum = [1, 3, 7, 12]
```

```java
class Solution {
    public int[] answerQueries2 (int[] nums, int[] queries) {
        int[] answer = new int[queries.length];
        int n = nums.length;
        int m = queries.length;
        Arrays.sort(nums);
        int[] prefixSum = new int[n];
        prefixSum[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefixSum[i] = prefixSum[i - 1] + nums[i];
        }

        for (int i = 0; i < m; i++) {
            int query = queries[i];
            int index = binarySearch(prefixSum, query);
            answer[i] = index;
        }
        return answer;
    }

    private int binarySearch(int[] nums, int target) {
        int left = 0;
        int right = nums.length - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] == target) {
                return mid + 1;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return nums[left] > target ? left: left + 1;
    }
}
```

- Time Complexity: `O(n log(n) + m log(n))`. This is because we first sort the `nums` array which takes `O(n log(n))` time and then iterate over the `queries` array and for each query find the index using binary search which takes `O(m log(n))` time.
- Space Complexity: `O(n)`. We are using an additional array of size `n` to store the `prefixSum` array. The sorting itself may take `O(log n)` space. So, it's higher of the two values.