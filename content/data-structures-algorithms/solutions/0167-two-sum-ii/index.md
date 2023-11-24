---
title: "0167 Two Sum Ii"
date: 2023-11-11T15:09:12-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Two Pointers"]
languages: ["Java"]
---

## Description 

Given a 1-indexed array of integers `numbers` that is already sorted in non-decreasing order, find two numbers such that they add up to a specific `target` number. Let these two numbers be `numbers[index1]` and `numbers[index2]` where `1 <= index1 < index2 < numbers.length`.

Return the indices of the two numbers, `index1` and `index2`, added by one as an integer array `[index1, index2]` of length 2.

The tests are generated such that there is exactly one solution. You may not use the same element twice.

Your solution must use only constant extra space.

### Example 1:

```
Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].
```

### Example 2:

```
Input: numbers = [2,3,4], target = 6
Output: [1,3]
Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].
```

### Example 3:

```
Input: numbers = [-1,0], target = -1
Output: [1,2]
Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].
``` 

### Constraints:

- `2 <= numbers.length <= 3 * 10^4`
- `-1000 <= numbers[i] <= 1000`
- `numbers` is sorted in non-decreasing order.
- `-1000 <= target <= 1000`
- The tests are generated such that there is exactly one solution.

## Solution

In this case, it's mentioned that the input array is sorted, so we know that values increase from left to right. The better idea would be to use two pointers and use them to navigate closer to the result. In this case, we have sorted array as input and this allows us to use two pointers, because we know in which direction the numbers will be larger. The basic algorithm for this looks like below. The important point to remember is that this array is 1-indexed. So, we initialize `left` and `right` offset by 1.

```markdown
Initialize one pointer left = 1
Initialize another pointer right = nums.length
while left less than right
    Check if nums[left-1] + nums[right-1] greater than target
        right = right + 1
    Else if nums[left-1] + nums[right-1] less than target
        left = left + 1
    Else 
        return [left, right]
If we didn't find a pair, return [-1, -1]
```

Let's convert this pseudo code into actual Java program.

```java
class Solution {
    public int[] twoSum(int[] numbers, int target) {
        int left = 1, right = numbers.length;
        while (left < right) {
            int sum = numbers[left - 1] + numbers[right - 1];
            if (sum > target) {
                right--;
            } else if (sum < target) {
                left++;
            } else {
                return new int[]{left, right};
            }
        }
        return new int[]{-1, -1};
    }
}
```
