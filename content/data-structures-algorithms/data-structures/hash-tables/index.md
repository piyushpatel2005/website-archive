---
title: "Hash Tables"
date: 2023-12-29T15:41:43-05:00
draft: false
categories: ["Coding Interview"]
tags: ["Leetcode", "Easy"]
difficulty: ["Easy"]
topics: ["Programming"]
ideas: ["Binary Search"]
languages: ["SQL", "Java"]
---

I. **What is a Hash Table? **
  
A hash table, also known as a hash map, is a data structure that implements an associative array abstract data type. It uses a unique key to calculate the index of where the associated value should be stored. 

II. **Hashing and Operations**
   
In Java, Hash tables store information by using something called 'hashing'. Let’s examine how they process some key actions: 

1) *Insertion* - The put(Key, Value) method is used to insert elements into the HashMap. The Key and Value pair is termed an Entry. If we try to insert the duplicate key, it will retain the new value by replacing the existing one.

2) *Retrieval* - Retrieving a value is simple in hash tables. You use the get(Object Key) method and pass the Key as a parameter to fetch its corresponding Value. This operation has O(1) time complexity due to the direct indexing.

3) *Deletion* - The remove(Object Key) method when invoked, removes the entry for the specified key.

III. **Handling Collisions**

In a perfect world, developing a hashing mechanism that provides a unique index for each key would be ideal. However, it's quite possible for two keys to generate identical hashes--a scenario referred to as 'collision'. 

Java uses Linked Lists for deal with collisions where each entry (key-value pair) forming a LinkedList at every slot of array formed by hashCode() function.

IV. **Time Complexities**

Most operations including insertion, deletion and retrieval offer constant time complexity O(1). Exceptions do arise during collisions where time complexity may degrade to O(n), where n denotes elements inserted at specific index(because of same hashcode).

V. Example Code Snippet:

```java
import java.util.*;
public class HashtableExample {
   public static void main(String args[]) { 
   
        // Creating Hashtable
        Hashtable<Integer,String> ht=new Hashtable<Integer,String>();

        // Adding Elements
        ht.put(101," Tom");
        ht.put(102," Bell");
        ht.put(103," Sam");

        System.out.println("Initial table is: "+ht);

    // Removing element
    ht.remove(102);
    
    System.out.println("After removing 102: "+ht);

     // Fetching value  
     String val=ht.get(103);  

     System.out.println("Value for key 103 is: "+val);
   }
}
```
This basic understanding of hash tables can offer you an assured way to manipulate data with speed, precision, and efficiency.
   
Remember, while hash tables open up swift processing possibilities, they can still pose challenges such as collisions and poor time complexities in specific instances. However, the more adept you become at using them, the easier these hurdles will be to overcome.

