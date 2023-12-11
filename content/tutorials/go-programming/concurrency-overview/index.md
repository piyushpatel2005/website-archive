---
title: "Concurrency Overview"
date: 2023-12-10T18:11:30-05:00
draft: false
---

This tutorial explains the difference between concurrency and parallelism. Although these terms sound very similar and many people think of them as the same thing, but in reality, it's not.

<!--more-->

Sequential programming is simple. Commands are executed one after another in linear fashion. Then comes multi-tasking where multiple tasks are executed. This is still single-core processor with context switching to allocate few CPU seconds to each task . Concurrency is like running multiple tasks at the same time. Concurrent programming is not same as parallel programming.

**Concurrency** in Golang refers to managing multiple tasks at the same time. It doesn't necessarily mean those tasks are being run at exactly the same nanosecond. For instance, one task could be waiting for an input while another is performing computation. Gazillions of things seem to be happening simultaneously in concurrent environments but that's not entirely true; there's a bit of start-stop-start dance going on behind the scenes! This is called CPU context switching where it performs some task for few seconds before stopping its execution and moving over to another task. Concurrency shines when dealing with a lot of tasks with unknown durations such as reading or writing to a disk, where we can start another task instead of waiting for one to finish. 

**Parallelism**, however, means running multiple tasks at literally the same instant. It involves splitting a single task into discrete functions that can run concurrently on different processors or cores on your machine. Hence, parallelism is about increasing speed by doing more than one thing at an exact moment - it boosts CPU usage significantly for computation heavy tasks. Modern day computers have multiple CPUs, so they can be used to perform parallel operations.

While all parallelism is concurrent by nature (because each discrete function happens 'independently' and simultaneously), not all concurrent systesm are running in parallel because under the hood, there might be only single task being executed while another task is waiting. CPUs these days are so fast that we never realize this kind of task switching.

Sequential programming is simple. Commands are executed one after another in linear fashion. Then comes multi-tasking where multiple tasks are executed. This is still single-core processor with context switching. Concurrency is like running multiple tasks at the same time. Concurrent programming is not same as parallel programming.

To illustrate this concept practically, below code is sequential program example. In this program, we iterate through first 100 numbers and calculate their square while also waiting for 1 second each time. So, in normal sequential execution it would take around 100 seconds in total. If we execute this code, you can see this takes around 100 seconds.

Something new in this code is that we use `time` package to sleep 1 second in each iteration using `time.Sleep(1 * time.Second)`.

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	start := time.Now()
	for i := 1; i <= 100; i++ {
		printSequence(i)
	}
	elapsed := time.Since(start)
	fmt.Println("Elapsed time", elapsed)
}

func printSequence(i int) {
	time.Sleep(1 * time.Second)
	fmt.Println("Sequence", i)
}
```

This program runs sequentially that's why it takes 100 seconds. Go provides easy and convenient way to make concurrency a breeze to work with. Go routines are the technique for making code run in parallel which we will see in the next lesson.