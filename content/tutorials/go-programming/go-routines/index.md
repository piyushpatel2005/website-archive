---
title: "Go Routines"
date: 2023-12-10T19:54:37-05:00
draft: false
---

Go routines is the mechanism used in Go to create concurrent programs. A goroutine is a simple function or method which runs concurrently with other functions or methods. This is considered as a lightweight thread that has its own independent execution. 

<!--more-->

Go routines can be executed concurrently with other go-routines and it is the fundamental way to execute concurrent programs in Go. Go routines are managed by Go runtime. The syntax looks like below which applies to functions or methods. `go` keyword makes it run in a separate go routine.

```go
go func_name()
```

Other programming languages use the concept of threads to achieve concurrency. In the Go programming language, instead of using threads, you utilize lightweight and more compact functions or procedures to execute concurrently. When compared to operating numerous threads concurrently, the resource cost of constructing goroutines is extremely low. Go routines only consume a small amount of memory. Threads, on the other hand, often require a fixed amount of memory which often around 100 times more than goroutines.

### Comparison of Threads and Go routine

- go routines are cheaper. Just few KBs in stack and stack can grow and shrink in size in Go. With threads, stack size has to be specified upfrtont and is fixed in size. OS threads generally start with 1MB size. Go routines are cheap so we can start hundreds of thousands of go-routines.
- Go routines are multiplexed to a fewer number of OS threads. Even a single OS thread can handle 1000s of go routines.
- Scheduling of go routines is managed by Go runtime. So, it's faster. For threads, scheduling is done by OS runtime. So, context switching time for go-routines is much faster.
- Go routines communicate using channels. Channels do not cause race condition when using shared memory. This is a powerful construct built into the language. It can be thought of bytes using with Go routines communicate with each other.

You can find an [example of go-routines](./src/27-go-routine.go) in code directory of this repo.

Main function in the main package is the **main go-routine**. All go-routines are started from [main go-routine](src/28-main-goroutine.go). it represents main program. When main go-routine exits, it assumes all go-routines have been exited. Go routines do not have parents or children. They all execute in parallel. All go routines exit when main go routine exits. To prove that there is no parent-child relationship, we can use below code. The output of this code will not be deterministic because both methods `process1` and `process2` execute in separate go routines.

```go
package main

import "fmt"
import "time"

func process1() {
	time.Sleep(1 * time.Second)
	fmt.Println("Running Process 1")
}

func process2() {
	go process1()
	time.Sleep(1 * time.Second)
	fmt.Println("Running Process 2")
}

func main() {
	go process2()
	time.Sleep(2 * time.Second)
}
```

**[Anonymous go-routine](src/29-anonymous-goroutine.go)** are anonymous functions. They don't have words. They are used only once. They can be called using go-routines. This routine behaves just like any other go-routine.

```go
go func() { }(args...)
```

```go
package main

func main() {
    go func() {
        fmt.Println("An anonymous function")
    }()
    time.Sleep(1 * time.Second)
}
```