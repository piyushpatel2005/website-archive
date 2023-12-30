---
title: "2225 Find Players With Zero or One Losses"
date: 2023-12-22T10:26:40-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Medium"]
difficulty: ["Medium"]
topics: ["Programming"]
ideas: ["Hashing", "Array"]
languages: ["Java"]
---

## Description

You are given an integer array `matches` where `matches[i] = [winneri, loseri]` indicates that the player `winneri` defeated player `loseri` in a match.

Return a list `answer` of size 2 where:

- `answer[0]` is a list of all players that have not lost any matches.
- `answer[1]` is a list of all players that have lost exactly one match.
- The values in the two lists should be returned in increasing order.

**Note:**

- You should only consider the players that have played at least one match.
- The testcases will be generated such that no two matches will have the same outcome.

### Example 1:

```
Input: matches = [[1,3],[2,3],[3,6],[5,6],[5,7],[4,5],[4,8],[4,9],[10,4],[10,9]]
Output: [[1,2,10],[4,5,7,8]]
Explanation:
Players 1, 2, and 10 have not lost any matches.
Players 4, 5, 7, and 8 each have lost one match.
Players 3, 6, and 9 each have lost two matches.
Thus, answer[0] = [1,2,10] and answer[1] = [4,5,7,8].
```

### Example 2:

```
Input: matches = [[2,3],[1,3],[5,4],[6,4]]
Output: [[1,2,5,6],[]]
Explanation:
Players 1, 2, 5, and 6 have not lost any matches.
Players 3 and 4 each have lost two matches.
Thus, answer[0] = [1,2,5,6] and answer[1] = [].
```

### Constraints:

- `1 <= matches.length <= 10^5`
- `matches[i].length == 2`
- `1 <= winneri, loseri <= 10^5`
- `winneri != loseri`
- All `matches[i]` are unique.

## Solution

Again this is counting problem so we can use either array to sort them or hashmap.

### Using Array

In this case, we can use array of size 100001 because the number for `winner` or `loser` is upto `10^5`. We might end up wasting lots of space if the `matches` array contains only few matches in which case most of the cells in array will have default values. Now, in our case, we have to get all users who have had zero losses. So, we have to change this default value. Another option is to consider `0` as default value and `1` as zero losses. For below code, I have used normal idea of `0` being zero losses. That means I have initialize all array elements to something other than `0`, so I have set them to `-1` to begin with.

```java
class Solution {
    private static final int WINNER_INDEX = 0;
    private static final int LOSER_INDEX = 1;
    private static final int MAX_PLAYER = 10000;

    public List<List<Integer>> findWinners2(int[][] matches) {
        if (matches == null || matches.length == 0) {
            return null;
        }

        // Create array to handle maximum value of player_id
        int[] playerLosses = new int[MAX_PLAYER + 1];
        // Initialize all elements to -1
        Arrays.fill(playerLosses, -1);

        for (int[] match: matches) {
            // If we see this player first time, set it to 0 else increment the winner by 0
            if (playerLosses[match[WINNER_INDEX]] == -1) {
                playerLosses[match[WINNER_INDEX]] = 0;
            } else {
                playerLosses[match[WINNER_INDEX]] += 0;
            }

            if (playerLosses[match[LOSER_INDEX]] == -1) {
                playerLosses[match[LOSER_INDEX]] = 1;
            } else {
                playerLosses[match[LOSER_INDEX]] += 1;
            }
        }

        // The array is already sorted so we don't need to sort it again. We can simply iterate through each element
        List<List<Integer>> answer = Arrays.asList(new ArrayList<>(), new ArrayList<>());
        for (int i = 1; i < MAX_PLAYER; i++) {
            if (playerLosses[i] == 0) {
                answer.get(0).add(i);
            } else if (playerLosses[i] == 1) {
                answer.get(1).add(i);
            }
        }
        return answer;
    }
}
```

- Time Complexity: The time complexity with this one looks like `O(n)` because in this case, we at max iterate through 100001 elements at the end. If we see it with more details, it's `O(n + k)` where `k` is range player ids for winner and loser because regardless of `matches` array length, we have to create an array of `k + 1` size where `k` is the maximum value player id can have.
- Space Complexity: `O(k)` where `k` is the maximum value of player id to store all players in their respective cell.

### Using HashMap
In this case, we are given array of `matches` where the first element is the `winner` number and second is `loser` number. We want to find all players who always won and those players who lost just one game. For tracking this count, we can use `HashMap`. Let's forget about sorting the result of these players as that can be done at the end once we have found the players list.

For this, we at least have to iterate through `matches` and in every iteration make an entry into our HashMap for `lossCounts` where we make entry for both winner and loser. If the entry already exists, increment the entry for winner by 0 and for loser by 1 because they lost one more game. This way at the end of iteration, we will have Map of player and number of losses they have had.

The next part is to iterate through these pairs in the map and check if the player had zero loss count or 1 loss count. If they had zero loss then add entry into new list `noLoss` to track all players who have not lost any game and for those will one loss will be entered into another list `oneLoss`. At the end we need sort these two lists and put them in another list. This way we have `List<List<Integer>>` where the first element has all players with no losses and second element is players with one loss.

```java
class Solution {
    private static final int WINNER_INDEX = 0;
    private static final int LOSER_INDEX = 1;
    public List<List<Integer>> findWinners(int[][] matches) {
        if (matches == null || matches.length == 0) {
            return null;
        }
        Map<Integer, Integer> lossCounts = new HashMap<>();
        for (int[] match: matches) {
            lossCounts.put(match[WINNER_INDEX], lossCounts.getOrDefault(match[WINNER_INDEX], 0));
            lossCounts.put(match[LOSER_INDEX], lossCounts.getOrDefault(match[LOSER_INDEX], 0) + 1);
        }

        List<List<Integer>> answer = new ArrayList<>();
        answer.add(new ArrayList<>());
        answer.add(new ArrayList<>());
        for (Map.Entry<Integer, Integer> entry: lossCounts.entrySet()) {
            if (entry.getValue() == 0) {
                answer.get(0).add(entry.getKey());
            } else if (entry.getValue() == 1) {
                answer.get(1).add(entry.getKey());
            }
        }
        Collections.sort(answer.get(0));
        Collections.sort(answer.get(1));
        return answer;
    }
}
```

- Time Complexity: In this case, we first create a map using `O(n)` time complexity. Next we iterate that map using `O(k)` complexity where `k` is number of unique players. The last part where we sort the two lists can take upto `O(n log n)` time. So, the overall time complexity is `O(n log n)`
- Space Complexity: We are creating new HashMap which may require at most `O(n)` space if each game is with unique players. So, space complexity is `O(n)`.