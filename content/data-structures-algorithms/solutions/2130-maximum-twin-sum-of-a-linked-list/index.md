---
title: "2130 Maximum Twin Sum of a Linked List"
date: 2024-03-07T02:28:34-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["LinkedList", "Fast Slow Pointers"]
languages: ["Java"]
---

## Description

In a linked list of size `n`, where `n` is even, the `i`th node (0-indexed) of the linked list is known as the twin of the `(n-1-i)`th node, if `0 <= i <= (n / 2) - 1`.

For example, if `n = 4`, then node `0` is the twin of node `3`, and node `1` is the twin of node `2`. These are the only nodes with twins for `n = 4`.
The twin sum is defined as the sum of a node and its twin.

Given the head of a linked list with **even** length, return the maximum twin sum of the linked list.

### Example 1:

```
Input: head = [5,4,2,1]
Output: 6
Explanation:
Nodes 0 and 1 are the twins of nodes 3 and 2, respectively. All have twin sum = 6.
There are no other nodes with twins in the linked list.
Thus, the maximum twin sum of the linked list is 6.
```

### Example 2:

```
Input: head = [4,2,2,3]
Output: 7
Explanation:
The nodes with twins present in this linked list are:
- Node 0 is the twin of node 3 having a twin sum of 4 + 3 = 7.
- Node 1 is the twin of node 2 having a twin sum of 2 + 2 = 4.
Thus, the maximum twin sum of the linked list is max(7, 4) = 7. 
```

### Example 3:

```
Input: head = [1,100000]
Output: 100001
Explanation:
There is only one node with a twin in the linked list having twin sum of 1 + 100000 = 100001.
```

### Constraints:

- The number of nodes in the list is an **even** integer in the range `[2, 105]`.
- `1 <= Node.val <= 10^5`

## Solution

### Using Array

This problem mentions that the number of nodes in the list is even. So, we will always have twin for each number. The easiest solution would be to convert this linked list into something that will have indices associated with it (an array). Once we have those numbers stored in an array, we can simply use its indices to find twin for each number. This will require two iterations and will result in time complexity of `O(n)`.

```java
class Solution {
    public int pairSum(ListNode head) {
        ListNode current = head;
        List<Integer> numbers = new ArrayList<>();
        while (current != null) {
            numbers.add(current.val);
            current = current.next;
        }

        int maxTwinSum = 0;
        int i = 0, j = numbers.size() - 1;
        while (i < j) {
            maxTwinSum = Math.max(maxTwinSum, numbers.get(i) + numbers.get(j));
            i++;
            j--;
        }
        return maxTwinSum;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`

### Using Fast and Slow Pointers

We can reverse the second half of the list to find the twin for a node. To find the second half, we have to first find the middle of the list. We can use fast and slow pointers to find the middle of the list. Once we have found the middle, we can reverse the second half of the list and create `prev` node. Once we have both `head` and `prev`, we can easily calculate twin sum using `prev` node and `head` node. The `prev` node is very similar to `tail` except that it will have `null` at the middle of the node. This way we do not need to go past half and list. Alternatively, we could store the middle of the list in a new node `middle` and every time we can check if we have reached `middle` node.

```java
class Solution {
    public int pairSum2(ListNode head) {
        // Find the middle of the list
        ListNode slow = head, fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }
        ListNode middle = slow;

        // Reverse the second half to find the tail (prev) node
        ListNode prev = null, current = middle, next;
        while (current != null) {
            next = current.next;
            current.next = prev;
            prev = current;
            current = next;
        }

        // Find the maximum twin sum
        int maxTwinSum = 0;
        while (head != middle) {
            maxTwinSum = Math.max(maxTwinSum, head.val + prev.val);
            head = head.next;
            prev = prev.next;
        }
        return maxTwinSum;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`