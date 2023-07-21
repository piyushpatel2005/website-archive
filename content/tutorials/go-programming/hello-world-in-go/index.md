---
title: "Hello World in Go"
date: 2023-07-20T22:28:51-04:00
draft: false
---


In this tutorial, we will take a look at very basic syntax of Go programming language by writing very simple "Hello World" code in Go.
<!--more-->

## Simple Go Program

Go is relatively very simple in reading compared to C, C++ code. It feels more like Python. Let's take an example code. Create a new file in your computer with file name, `main.go` and add below content into it.

```go
package main

import "fmt"

func main() {
  fmt.Println("Hello World")
}
```

Let's dissect this code a bit.
The first line of the code is `package` statement. We will learn about packages more, however, keep in mind that the executable code should always reside in package called `main`. This file also contains a function called `main()` on line 5. As you can see the functions are declared using `func` keyword in Go. We will learn more about functions and all of these content throughout the tutorial.

Next, on line 3, we have `import` statement. Go has module system with which we can bring in code written by other developers. This helps with code-reusability as we do not have to write the same code repeatedly. We can simply re-use existing module. Here, we import `fmt` module which is used for text formatting. On line 5, after `main()` function we have set of curly brances `{...}`. This denotes the start and end of the code block. In this case, it means that `main` function starts on line 5 and ends on line 7. The statements written between these two lines will get executed one after another.

On line 6, we have single statement `fmt.Println("Hello World")`. This uses our imported `fmt` package and uses a function called `Println` from that package. This function takes a parameter `"Hello World"` which is what it prints. Note that this function prints the data and moves to the next line. Let's test out the execution.

```bash
$ go run main.go
Hello World
$ 
```

{{< admonition note >}}
In above execution, `$` symbol is used as a prompt representation. You do not need to actually write that. Actual command is `go run main.go` but `$` is there only for representation.
{{< /admonition >}}

There is also another function in `fmt` package called `Printf`. Let's replace `Println` function with `Printf` and see the output after execution.

```go
package main

import "fmt"

func main() {
  fmt.Printf("Hello World")
}
```

```bash
$ go run main.go
Hello World$
```

As you can see, the last change didn't create a new line after printing the output. You can also try replacing `Hello World` with `Hello [Your Name]`. Replace `[Your Name]` with your actual name and run it again.