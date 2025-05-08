---
title: "0234 Palindrome Linked List"
date: 2024-03-15T19:10:26-04:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["LinkedList"]
languages: ["Java"]
---

## Description

Given the `head` of a singly linked list, return `true` if it is a palindrome or `false` otherwise.

### Example 1:

```
Input: head = [1,2,2,1]
Output: true
```

### Example 2:

```
Input: head = [1,2]
Output: false
```

### Constraints:

- The number of nodes in the list is in the range `[1, 10^5]`.
- `0 <= Node.val <= 9`
 

**Follow up:** Could you do it in `O(n)` time and `O(1)` space?

## Solution

This problem can be solved using `ArrayList`. We can iterate through the given list and store its elements into an `ArrayList`. Next, we iterate through this `ArrayList` in reverse and store its values in another array list. Next, we iterate through array list comparing elements of first list with reversed list. If any element does not match then the list is not palindome else at the end of the iteration, we do not have any non-matching number and the list is palindrome. This is the intuitive solution but takes `3n` time complexity and requires `2n` space for two `ArrayList`s.

### Using Fast and Slow Pointers

The better approach would be to compare first half of the list with second half. In order to do that, we have to first find the middle of the list and reverse the second half of the list. Next, we compare the reversed half with the first half checking for any non-matching numbers.

```java
class Solution {
    public boolean isPalindrome(ListNode head) {
        if (head == null) return true;
        ListNode slow = head, fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }
        ListNode prev = null, current = slow, next;
        while (current != null) {
            next = current.next;
            current.next = prev;
            prev = current;
            current = next;
        }
        // We have broken the original list after the middle node
        ListNode left = head, right = prev; // alternatively we could use head and prev instead of left and right
        while (right != null) {
            if (left.val != right.val) return false;
            left = left.next;
            right = right.next;
        }
        // Below gives error NullPointerException because list is broken at the middle after reversing
//        System.out.println(head.val + " " + head.next.val + " " + head.next.next.val + " " + head.next.next.next.val);
        return true;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(1)`