---
title: "Junit Lifecycle Methods"
date: 2023-10-27T18:37:40-04:00
draft: false
---

JUnit provides a lifecycle hooks for running tests. Each test goes through several phases or stages during its execution. After learning these lifecycle methods, you will have better control and flexibility on the unit tests you write.
<!--more-->

The JUnit lifecycle can be divided into three main phases: the setup phase, the test execution phase, and the teardown phase.

## 1. Setup Phase:
The setup phase is responsible for preparing the environment required for running a test. It includes initializing variables, setting up mock objects or test doubles, and any necessary configuration.

To handle the setup phase, JUnit offers two annotations: `@BeforeAll` and `@BeforeEach`. The `@BeforeAll` annotation is used at the class level to define methods that will be executed before each test case in that class. On the other hand, the `@BeforeEach` annotation is used at the method level to define methods that will be executed before each individual test methods.

Let's see an example of using `@BeforeEach` annotation:

```java
import org.junit.jupiter.api.BeforeEach;

public class DemoTestClass {

    @BeforeEach
    public void setup() {
        // Perform setup actions here
    }
    
    // Test methods go here...
}
```

- **`@BeforeAll`:** This method is annotated with `@BeforeAll` and is executed once for the entire test class before any test methods are run. It's typically used for one-time setup tasks such as initializing resources that will be shared across multiple tests.

- **`@BeforeEach`:** This method is annotated with `@BeforeEach` and is executed before each individual test method. It's used to set up the preconditions required for a particular test case, such as creating objects or initializing variables.

## 2. Test Execution Phase:
The test execution phase is where the actual testing takes place. This is where you write your assertions and validate expected outcomes against actual results.

By default, all public methods annotated with `@Test` are considered as test cases by JUnit and will be executed during this phase.

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculatorTest {
    
    @Test
    public void testAdd() {
        int result = Calculator.add(2, 3);
        assertEquals(5, result);
    }
    
    // Additional test methods go here...
}
```

## 3. Teardown Phase:
The teardown phase is responsible for cleaning up resources and releasing any objects created during the test execution. This phase ensures that each test starts with a clean state, making tests independent of each other.

JUnit provides two annotations to handle the teardown phase: `@After` and `@AfterEach`. The `@After` annotation is used at the class level, similar to `@Before`, to define methods that will be executed after all test cases in that class. The `@AfterEach` annotation, at the method level, defines methods that will be executed after each individual test method.

Here's an example using `@AfterEach` annotation:

```java
import org.junit.jupiter.api.AfterEach;

public class MyTestClass {

    @AfterEach
    public void tearDown() {
        // Clean up resources here
    }
    
    // Test methods go here...
}
```

- **`@AfterEach`**: This method is annotated with `@AfterEach`, and it's executed after each individual test method completes execution. It's used for cleanup tasks, such as releasing resources or resetting state, after a specific test case.

- **`@AfterAll`**: This method is annotated with `@AfterAll` and is executed once for the entire test class after all the test methods have been run. It's typically used for tear-down tasks like closing connections, cleaning up resources, or performing any post-testing activities.

## Lifecycle Methods Example

Below code has two test methods defined with all lifecycle methods. Please note that `@BeforeAll` and `@AfterAll` methods have to be static methods. They are defined at class level and are executed only once when we execute this test class.

```java
import org.junit.jupiter.api.*;

public class LifeCycleTests {
    @BeforeAll
    static void setUp() {
        System.out.println("BeforeAll Method");
    }

    @BeforeEach
    void beforeEach() {
        System.out.println("BeforeEach Method");
    }

    @Test
    void testA() {
        System.out.println("Testing A");
    }

    @Test
    void testB() {
        System.out.println("Testing B");
    }

    @AfterEach
    void afterEach() {
        System.out.println("AfterEach Method");
    }

    @AfterAll
    static void tearDown() {
        System.out.println("AfterAll Method");
    }
}
```

**Output:**

```output
BeforeAll Method
BeforeEach Method
Testing A
AfterEach Method
BeforeEach Method
Testing B
AfterEach Method
AfterAll Method
```

As you can see, the method annotated with `@BeforeAll` gets executed once and at the very beginning of the test execution. Contrary to this, `@AfterAll` method gets executed at the end of the test class. The method names can be anything, but conventionally, they are called `setUp` and `tearDown` methods. Similarly, `@BeforeEach` method gets executed before each test method (the methods annotated with `@Test`) and `@AfterEach` methods will be executed after each test method.

## Practical Usage

In our previously defined `CalculatorTest` class, we were creating new `Calculator` instance in each of our test methods.

```java
class CalculatorTest {
    @Test
    @DisplayName("Test Positive Numbers Addition")
    void testAdd() {
        Calculator calculator = new Calculator();
        assertEquals(2, calculator.add(1, 1));
    }

    @Test
    @DisplayName("Test Negative Numbers Addition")
    void testAddNegativeNumbers() {
        Calculator calculator = new Calculator();
        assertEquals(-5, calculator.add(-2, -3));
    }
}
```

We can use `@BeforeEach` method to create this new `Calculator` instance before each method. This way we will not need to duplicate the same lines in each method.

```java
class CalculatorTest {
    Calculator calculator;
    
    @BeforeEach
    void setUp() {
        calculator = new Calculator();
    }
    
    @Test
    @DisplayName("Test Positive Numbers Addition")
    void testAdd() {
        assertEquals(2, calculator.add(1, 1));
    }

    @Test
    @DisplayName("Test Negative Numbers Addition")
    void testAddNegativeNumbers() {
        assertEquals(-5, calculator.add(-2, -3));
    }
}
```

After using all these knowledge we have gained, we can modify our calculator application to use these lifecycle methods. Below is the application code. I have also modified `divide()` method to throw `IllegalArgumentException` if the denominator is zero.

```java
public class Calculator {
    public int add(int num1, int num2) {
        return num1 + num2;
    }

    public int subtract(int num1, int num2) {
        return num1 - num2;
    }

    public int multiply(int num1, int num2) {
        return num1 * num2;
    }

    public int divide(int num1, int num2) {
        if (num2 == 0)
            throw new IllegalArgumentException(
                String.format("%d is not a valid denominator.", num2)
            );
        return num1 / num2;
    }
}
```

By using `@BeforeEach`, we can wire the `Calculator` instance that can be used in each of the test cases.

```java
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Calculator Test")
class CalculatorTest {
    Calculator calculator;

    @BeforeEach
    void setUp() {
        calculator = new Calculator();
    }

    @Test
    @DisplayName("Test Positive Numbers Addition")
    void testAdd() {
        assertEquals(2, calculator.add(1, 1));
    }

    @Test
    @DisplayName("Test Negative Numbers Addition")
    void testAddNegativeNumbers() {
        assertEquals(-5, calculator.add(-2, -3));
    }

    @Test
    @DisplayName("Test Subtraction")
    void testSubtraction() {
        assertEquals(1, calculator.subtract(2, 1));
        assertEquals(-5, calculator.subtract(5, 10));
        assertEquals(-5, calculator.subtract(-2, 3));
    }

    @Test
    @DisplayName("Test Multiplication")
    void testMultiply() {
        assertEquals(15, calculator.multiply(5, 3));
        assertEquals(0, calculator.multiply(0, 10));
    }

    @Test
    @DisplayName("Test Division")
    void testDivision() {
        assertEquals(1, calculator.divide(3, 2));
        assertEquals(2, calculator.divide(4, 2));
        assertEquals(2, calculator.divide(12, 5));
        assertThrows(
            IllegalArgumentException.class, 
            () -> calculator.divide(100, 0)
        );
        assertDoesNotThrow(() -> calculator.divide(0, 100));
    }
}
```