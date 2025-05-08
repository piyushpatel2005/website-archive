---
title: "Hello World in Go"
date: 2023-07-20T22:28:51-04:00
draft: false
---


In this tutorial, we will take a look at very basic syntax of Go programming language by writing very simple "Hello World" code in Go.
<!--more-->

## Simple Go Program

Go is relatively very simple in reading compared to C, C++ code. It feels more like Python. Let's take an example code. Create a new directory `go-learning` and navigate or open that directory using your text editor. Create a new file in your computer with file name, `main.go` and add below content into it.

```go
package main

import "fmt"

func main() {
  fmt.Println("Hello World")
}
```

Let's dissect this code a bit.
The first line of the code is `package` statement. We will learn about packages more, however, keep in mind that the executable code should always reside in package called `main`. This file also contains a function called `main()` on line 5. This is the entry point of this code. So, when we run this code file, it will execute all lines of this `main` function. As you can see the functions are declared using `func` keyword in Go. We will learn more about functions and all of these content throughout the tutorial.

Next, on line 3, we have `import` statement. Go has module system with which we can bring in code written by other developers. This helps with code-reusability as we do not have to write the same code repeatedly. We can simply re-use existing module. Here, we import `fmt` module which is used for text formatting. On line 5, after `main()` function we have set of curly brances `{...}`. This denotes the start and end of the code block. In this case, it means that `main` function starts on line 5 and ends on line 7. The statements written between these two lines will get executed one after another.

On line 6, we have single statement `fmt.Println("Hello World")`. This uses our imported `fmt` package and uses a function called `Println` from that package. This function takes a parameter `"Hello World"` which is what it prints. Note that this function prints the data and moves to the next line. Let's test out the execution.

### Execute Our Program

#### 1. Compile and Run

There are couple of ways I am going to show how you can execute Go code.
1. Open your terminal and navigate to this `go-learning` directory. You should have `main.go` file created with above code.
2. Enter `go build main.go` command. This will compile your go code and build a executable binary file.
3. Next this binary file can be shipped to another person or system to execute on their system. To run this, type `./main` on UNIX based systems or `main.exe` on Windows.

#### 2. Another Run option

While learning, building and running Go code can be little bit of a hassle, so we can use `go run` to execute the code interactively.
```bash{ .show-prompt lineNos=false }
go run main.go
```
```output{ lineNos=false }
Hello World
```

> In above execution, `$` symbol is used as a prompt representation. You do not need to actually write that. Actual command is `go run main.go` but `$` is there only for representation.

## Experiment with Code

There is also another function in `fmt` package called `Printf`. Let's replace `Println` function with `Printf` and see the output after execution.

### Comments

Comments are used for documenting code by developers. In below code, we also added **comments**. Comments are used in code to write meaningful information about program logic. We have two kinds of comments *single line comment* which can be on only one line and starts with `//` in Go. We also have *multi-line comment* which can span multiple lines and starts with `/*` and ends with `*/` as shown in this code. Whatever we write in comment, gets ignored by the compiler.

```go
package main

import "fmt"

/*
This is multi-line
comment 
which spans multiple lines
*/
func main() {
  // This is single-line comment
  fmt.Printf("Hello World") 
}
```

```bash{ .show-prompt lineNos=false }
go run main.go
```
```{ lineNos=false }
Hello World$
```
As you can see, the last code modification didn't create a new line after printing the output. 

## Try It Yourself

In this part, I want you to try with existing code to learn a bit more.

1. Replace `Hello World` with `Hello [Your Name]`. Replace `[Your Name]` with your actual name.
2. Execute the program again.

Once you've tried, you can verify with below hidden solution code. Just click on **Solution** below.

### Solution

```go{ filename=main.go }
package main

import "fmt"

func main() {
  fmt.Printf("Hello John")
}
```

```bash{ .show-prompt lineNos=false }
go run main.go
```
```{ lineNos=false }
Hello John$
```

## Formatting Go Code

A point to note about Go source files is that, we do not need these indentations, we can write everything in single line and run the code, it will still work fine. However, this will be very hard to read for any humans. Computers won't find any difficulty understanding the Golang syntax.

If you're working on a text editor that does not automatically format your code, you can use go utility to format the code. For example, if I had a code which is not indented properly, I can simply use `go fmt` command to reformat my code.

```go
package main
import "fmt"
func main() {
fmt.Println("Hello World")
}
```

Just type above code which is not properly indented and enter `go fmt main.go` command. This will auto-format your Go code and save the file.

Go is also case-sensitive. That means if by mistake we type `fmt.println` instead of `fmt.Println`, the Go code will not compile and will give us error. So, we have to be careful with the case here.
