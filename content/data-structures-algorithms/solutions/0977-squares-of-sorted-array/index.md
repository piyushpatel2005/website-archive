---
title: "0977 Squares of Sorted Array"
date: 2023-10-18T18:12:34-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

## Description:

Given an integer array `nums` sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.

### Example 1:

**Input:** nums = [-4,-1,0,3,10]

**Output:** [0,1,9,16,100]

**Explanation:** After squaring, the array becomes [16,1,0,9,100].

After sorting, it becomes [0,1,9,16,100].

### Example 2:

**Input:** nums = [-7,-3,2,3,11]

**Output:** [4,9,9,49,121]
 
### Constraints:

- `1 <= nums.length <= 10^4`
- `-10^4 <= nums[i] <= 10^4`
- `nums` is sorted in non-decreasing order.


**Follow up:** Squaring each element and sorting the new array is very trivial, could you find an O(n) solution using a different approach?

## Brute Force

In brute force approach, we can square each of the numbers and then sort them in non-decreasing, i.e. ascending order.

```markdown
for element in nums
    nums[i] = nums[i] * nums[i]
sort nums array
```

The brute force approach would look like this. In this case, we can also implemented our own sorting algorithm as a function. However, the best time complexity for sorting algorithm is `O(n log n)`. So, our overall solution can never be better than `O(n log n)` with this algorithm.

```java
class Solution {
    public int[] sortedSquaresBrute(int[] nums) {
        int[] result = new int[nums.length];

        // find squares
        for(int i = 0; i < nums.length; i++) {
            result[i] = nums[i] * nums[i];
        }
        // sort the array
        Arrays.sort(result);

        return result;
    }
}
```

- Time Complexity: `O(n log n)`
- Space Complexity: We are using a `result` array of the same size as the input array. So, in this case, space complexity is `O(n)`.
 
## Better Solution:

```markdown
two pointers approach
left = 0, right = nums.length - 1, i = nums.length - 1
Initialize result array with same size as nums to store sorted result
while (left < right)
    if (square of nums[left] greater than square of nums[right])
        result[i] = square of nums[left]
        left++
        i--
    else
        result[i] = square of nums[right]
        right--
        i--
return result
```

The implemention for above algorithm will look like this.

```java
class Solution {
    public int[] sortedSquares(int[] nums) {
        int[] result = new int[nums.length];

        int left = 0, right = nums.length - 1;
        int i = nums.length - 1;

        while (left < right) {
            if (nums[left] * nums[left] > nums[right] * nums[right]) {
                result[i--] = nums[left] * nums[left];
                left++;
            } else {
                result[i--] = nums[right] * nums[right];
                right--;
            }
        }

        return result;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`