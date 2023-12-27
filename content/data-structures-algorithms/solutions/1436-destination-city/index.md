---
title: "1436 Destination City"
date: 2023-12-26T18:28:12-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Hashing"]
languages: ["Java"]
---

## Description

You are given the array `paths`, where `paths[i] = [cityAi, cityBi]` means there exists a direct path going from `cityAi` to `cityBi`. Return the destination city, that is, the city without any path outgoing to another city.

It is guaranteed that the graph of paths forms a line without any loop, therefore, there will be exactly one destination city.

### Example 1:

```
Input: paths = [["London","New York"],["New York","Lima"],["Lima","Sao Paulo"]]
Output: "Sao Paulo" 
Explanation: Starting at "London" city you will reach "Sao Paulo" city which is the destination city. Your trip consist of: "London" -> "New York" -> "Lima" -> "Sao Paulo".
```

### Example 2:

```
Input: paths = [["B","C"],["D","B"],["C","A"]]
Output: "A"
Explanation: All possible trips are: 
"D" -> "B" -> "C" -> "A". 
"B" -> "C" -> "A". 
"C" -> "A". 
"A". 
Clearly the destination city is "A".
```

### Example 3:

```
Input: paths = [["A","Z"]]
Output: "Z"
```

### Constraints:

- `1 <= paths.length <= 100`
- `paths[i].length == 2`
- `1 <= cityAi.length, cityBi.length <= 10`
- `cityAi != cityBi`
- All strings consist of lowercase and uppercase English letters and the space character.

## Solution

The constraints provide very important information about the problem. In this problem it states that `paths` can be upto 100 pairs. `paths` is never `null` or empty as first constraint states.

### Brute Force Approach

```java
class Solution {
    public String destCityBrute(List<List<String>> paths) {
        for (List<String> path: paths) {
            boolean isDestination = true;
            for (List<String> path2: paths) {
                if (path.get(1).equals(path2.get(0))) {
                    isDestination = false;
                    break;
                }
            }
            if (isDestination)
                return path.get(1);
        }
        return null;
    }
}
```

- Time Complexity: `O(n^2)`
- Space Complexity: `O(1)`

### Using HashMap

We can use `HashMap` to store origin - destination relationship. For each of the values there will be corresponding key present in this HashMap except the last destination. The last destination will not point to any destination, so it will not be present in the HashMap as a key. Now, the input `paths` are not sorted, so we first have to build the `HashMap` and have to make another pass to see which one is not present as a key.

```java
class Solution {
    public String destCity(List<List<String>> paths) {
        Map<String, String> originDestinationMap = new HashMap<>();
        for (List<String> path: paths) {
            originDestinationMap.put(path.get(0), path.get(1));
        }

        for (List<String> path: paths) {
            if (!originDestinationMap.containsKey(path.get(1)))
                return path.get(1);
        }
        return null;
    }
}
```

Another approach to solve this problem is to store all `origin` values in a `HashSet`. Next, we can iterate through `paths` list checking if `paths[i][1]` is present in this `HashSet`. If not, that will be the final destination. Both these approaches are exactly similar in time and space complexities.

```java
class Solution {
    public String destCity2(List<List<String>> paths) {
        Set<String> origins = new HashSet<>();
        for (List<String> path: paths) {
            origins.add(path.get(0));
        }

        for (List<String> path: paths) {
            if (!origins.contains(path.get(1)))
                return path.get(1);
        }
        return null;
    }
}
```

- Time Complexity: `O(n)`
- Space Complexity: `O(n)`
