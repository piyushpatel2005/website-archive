---
title: "Interfaces in Golang"
date: 2023-08-13T04:10:07Z
draft: false
---

In Golang, there are primarily two ways to handle encapsulation. These are structures and interfaces. Interfaces define method sets available for a struct. This helps with features like Polymorphism in object oriented programming languages.
<!--more-->

- Interfaces specify method sets and is used to create modularity in Go programming language. 
- It is like a blueprint for a method set. This is defined so that it can be implemented by other types like Structures. 
- Interfaces only provide method signatures for each method of a method set. They do not implement these methods. These methods are then implemented by other types. 
- It cannot have any variable declarations. They can only have method signatures.

## Defining Interfaces

Interface is defined in Golang using below syntax.

```go
type <interface_name> interface {
    // method signatures
}
```

**Example:

```go
type Account interface {
    withdrawMoney(int amount) bool
    depositMoney(int amount) bool
    getBalance() float64
}
```

## Interface Example using Shape

Interfaces are defined so that other types can implement them. In order to implement an interface, a type has to implement all of interface's methods. There is no `implements` keyword like Java or C#. These are implemented implicitly and does not use specific keyword to implement an interface. This is how we can implement features like polymorphism from other object oriented programming languages.

**Example:**

```go
package main

import "fmt"

const PI float64 = 3.14

type Shape interface {
	area() float64
	perimeter() float64
}

type Square struct {
	side float64
}

func (s Square) area() float64 {
	return s.side * s.side
}

func (s Square) perimeter() float64 {
	return 4 * s.side
}

type Circle struct {
	radius float64
}

func (c Circle) area() float64 {
	return PI * c.radius * c.radius
}

func (c Circle) perimeter() float64 {
	return 2 * PI * c.radius
}

func main() {
	square := Square{side: 2}
	circle := Circle{radius: 2}
	printDetails(circle)
	printDetails(square)
    var shape Shape
    shape = &square
    fmt.Println(shape.area())

    shape = &circle
    fmt.Println(shape.area())
}

func printDetails(s Shape) {
	fmt.Printf("Area = %.2f, Perimeter = %.2f\n", s.area(), s.perimeter())
}
```

In this case, we define `interface` of type `Shape`. Further, we define two structs of type `Circle` and `Square`. Both of them have methods defined `area` and `perimeter`. These methods calculate correct values based on type of the shape. Here `Square` and `Circle` implicitly implements `Shape` interface. We do not use any explicit keyword for this implementing this. Something else to note here is that we can have method with same name as long as the receiver is different. This is similar to concept of method overloading in OOP languages.

**Output:**

```output{ lineNos=false }
Area = 12.56, Perimeter = 12.56
Area = 4.00, Perimeter = 8.00
4
12.56
```

## Interface types: Static vs Dynamic

Another important point to note with interfaces is that, we can define a variable of type `Shape`. Once the variable is created, the variable can have any type that implements methods defined in this interface. For example, in above code, we used `area()` methods of `Circle` and `Square` both from `shape` variable we created.

In Go, there are two types of interfaces: static and dynamic. Static interface is the type of the interface itself. In above example, static type if interface `Shape` is `Shape`. The dynamic type, on the other hand, is the type that implements the interface which were `Square` and `Circle`. Internally, an interface is represented by a tuple which represents the dynamic type of the interface and the value of the dynamic type.

```go
package main

import "fmt"

const PI float64 = 3.14

type Shape interface {
	area() float64
	perimeter() float64
}

type Square struct {
	side float64
}

func (s Square) area() float64 {
	return s.side * s.side
}

func (s Square) perimeter() float64 {
	return 4 * s.side
}

type Circle struct {
	radius float64
}

func (c Circle) area() float64 {
	return PI * c.radius * c.radius
}

func (c Circle) perimeter() float64 {
	return 2 * PI * c.radius
}

func main() {
	square := Square{side: 2}
	circle := Circle{radius: 2}
	var shape Shape
	shape = &square
	fmt.Printf("shape type: %T and value: %+v\n", shape, shape)

	shape = &circle
	fmt.Printf("shape type: %T and value: %+v\n", shape, shape)
}
```

Above code shows the internal type and value of `shape` variable. Initially it was pointer to `Square` and then it changed to pointer of `Circle`.

```output{lineNos=false}
shape type: *main.Square and value: &{side:2}
shape type: *main.Circle and value: &{radius:2}
```

## Empty Interface 
In Go, empty interface is an interface without any method signature. By default, all types in Go implement the empty interface known as `interface {}`. This also includes types like `nil` and every other built-in types.

```go
import "fmt"

func main() {

	var i interface{}
	fmt.Println(i)
	fmt.Printf("i type: %T and value %+v\n", i, i)
}
```

```output{ lineNos=false }
<nil>
i type: <nil> and value <nil>
```

## Implementing Multiple Interfaces

In Go, a type can implement multiple interfaces. Again, we don't have to explicitly say this type implements these interfaces. We simply define methods defined in the interfaces that we want to implement.

```go
package main

import (
	"fmt"
)

const PI float64 = 3.14

type PrintDetails interface {
	describe()
}

type Shape interface {
	area() float64
	perimeter() float64
}

type Square struct {
	side float64
}

func (s *Square) area() float64 {
	return s.side * s.side
}

func (s *Square) perimeter() float64 {
	return 4 * s.side
}

func (s *Square) describe() {
	fmt.Printf("The square with side: %.2f has area: %.2f and perimeter: %.2f\n", s.side, s.area(), s.perimeter())
}

func main() {
	s := Square{side: 5}
	var details PrintDetails
	details = &s
	details.describe()

	var shape Shape
	shape = &s
	fmt.Println("Area: ", shape.area())
}
```

In this code, we have two interfaces `PrintDetails` and `Shape`. The `Shape` interface is similar to earlier. However, in this code, we have additional method defined for `describe()` with receiver of `Square` type. That means `Square` implements `PrintDetails` interface. Now, we can create variable of `PrintDetails` type and call `describe()` method on it. We can also call `area()` method on `Shape` type variable.

## Conditionals on Interface Types

In Go, `switch` statement supports checking against various data types. We can use it to check the underlying interface type. This is illustrated in below code example.

```go
package main

import (
	"fmt"
)

type Animal interface {
	move()
}

type Human struct {
}

type Bird struct {
}

func (b *Bird) move() {
	fmt.Println("Bird is flying...")
}

func (h *Human) move() {
	fmt.Println("Human is walking...")
}

func TypeCheck(i interface{}) {
	switch i.(type) {
	case *Human:
		fmt.Println("This is a human")
	case *Bird:
		fmt.Println("This is a bird")
	default:
		fmt.Println("Unknown type")
	}
}

func main() {
	h := Human{}
	var animal Animal
	TypeCheck(animal)
	h.move()

	animal = &h
	TypeCheck(animal)
	animal.move()

	b := Bird{}
	animal = &b
	TypeCheck(animal)
	animal.move()
}
```

As you can see in above code, we can pass an `interface {}` which is implemented by all types to make compiler happy. In code, we can pass any type into this `TypeCheck()` function. The output looks like below.

```output{ lineNos=false }
Unknown type
Human is walking...
This is a human
Human is walking...
This is a bird
Bird is flying...
```

## Embedded Interfaces: Inheritance

In OOP languages, we could have multi-layer inheritance where it has chain of inheritance hierarchy. Go supports a similar idea using embedded interfaces. You define an interface using the definition of other existing interfaces. This promotes code reuse.

```go
package main

import (
	"fmt"
)

type WalkingAnimal interface {
	walk()
}

type FlyingAnimal interface {
	fly()
}

type SwimmingAnimal interface {
	swim()
}

type WalkingAndSwimmingAnimal interface {
	WalkingAnimal
	SwimmingAnimal
}

type Crocodile struct {
	name  string
	tails int
	eyes  int
}

func (c *Crocodile) walk() {
	fmt.Println("Crocodile is walking")
}

func (c *Crocodile) swim() {
	fmt.Println("Crocodile is swimming")
}

func main() {
	crocodile := Crocodile{name: "Hungry Crocodile", eyes: 2, tails: 1}
	var walkAndSwim WalkingAndSwimmingAnimal
	walkAndSwim = &crocodile
	walkAndSwim.swim()
	walkAndSwim.walk()
}
```

In this case, we have two interfaces `WalkingAnimal` and `SwimmingAnimal`. Now, mostly animal can either walk or swim, but few animals can do both. In those cases, we can use existing interfaces to derive a new interface. In this case, we created `WalkingAndSwimmingAnimal` interface using above two interfaces. This way this interface has methods which were defined in the first two. This is similar to inheritance in object-oriented programming languages.