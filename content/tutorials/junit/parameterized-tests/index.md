---
title: "Parameterized Tests"
date: 2023-10-29T22:01:07-04:00
draft: false
---

Parameterized tests allow developers to run the same test over and over again using different values. They are beneficial since they eliminate the need for duplicating code when executing the same test with varying inputs.
<!--more-->

In JUnit 5, designing parameterized tests has become more straightforward and flexible than before due to new annotations and features.

Let's have a look at how we can write parameterized tests in JUnit 5 specifically using various methods.

## 1. Using `@MethodSource`

The `@MethodSource` annotation allows for complex parameters to be injected into your test case, making it ideal for more complicated testing scenarios beyond primitives and strings. This method doesn't require you to initialise anything beforehand;. It will use a factory method to generate data directly. It offers an unparalleled level of flexibility compared to other types of sources.

Let's implement a simple method for validation. In this example, I have created a new application class `Numbers`. This has three methods which we will test in this tutorial one by one.

```java
public class Numbers {
    public boolean isDivisibleByFive(int number) {
        return number % 5 == 0;
    }

    public boolean isEven(int number) {
        return number % 2 == 0;
    }

    public boolean isOdd(int number) {
        return !isEven(number);
    }
}
```

Now, in order to write the test code for this one, I have created at test class for it which also initializes `Numbers` instance at the top.

```java
class NumbersTest {
    Numbers numbers = new Numbers();
    // other code
}
```

Using `@MethodSource`, we want to test `isEven()` method in this case. The first thing is to write normal test method for it and replace `@Test` annotation with `@ParameterizedTest` annotation. This marks that this test will be running as parameterized tests and this test method will get parameters passed from a factory method. The factory method name is denoted in the `@MethodSource` annotation. If there is no static method defined with this name, we will get `PreconditionViolationException`. 

```java
    @ParameterizedTest
    @MethodSource("provideNumbersForIsEven")
    @DisplayName("Parameterized test for is Even")
    void testIsEven(int number, boolean expected) {
        assertEquals(expected, numbers.isEven(number));
    }
```

In this snippet, we have mentioned that we will have factory method `provideNumbersForIsEven` which will provide parameters for this test. In this test method, we have to pass two parameters `number` and `expected` result. Below is the factory method definition in the same test file.

```java
    static Stream<Arguments> provideNumbersForIsEven() {
        return Stream.of(
                Arguments.of(2, true),
                Arguments.of(10, true),
                Arguments.of(0, true),
                Arguments.of(5, false)
        );
    }
```

The factory method needs no input parameters but must return `Stream`, `Iterable`, `Iterator`, or an array (`Object[]`). We are returning argument pairs using `Arguments.of()` methods. When we execute the test case, it will run four times with the arguments 2, 10, 0, 5. If we modify the expected value of one of those arguments, the test case will fail.

## 2. `@ValueSource`

Another way to write two different sets of test cases for same method is using `@ValueSource`. In this case, we do not pass expected result. So, we have to write two test cases for it. One which returns the positive result and another which returns negative results. The parameters are passed as values in the annotation itself.

```java
    @ParameterizedTest
    @ValueSource(ints = {1, 3, -11, 507})
    @DisplayName("Test is Odd with True results")
    void testIsOdd_returnsTrueForOddNumbers(int number) {
        assertTrue(numbers.isOdd(number));
    }

    @ParameterizedTest
    @ValueSource(ints = {0, 100, -20, 2222})
    @DisplayName("Test is Odd with True results")
    void testIsOdd_returnsFalseForEvenNumbers(int number) {
        assertFalse(numbers.isOdd(number));
    }
```

In this case, we wrote two test methods for testing `isOdd()` method from `Numbers` class. The `testIsOdd_returnsTrueForOddNumbers` method tests for positive cases and `testIsOdd_returnsFalseForEvenNumbers` method tests for negative cases.

## 3. `@CsvSource`

Using this annotation, we can provide the parameters as comma-separated strings. In our example, we will be testing `isDivisibleByFive()` method using positive and negative cases. The method takes two parameters: the number to test and the expected result with the given number.

```java
    @ParameterizedTest
    @CsvSource({
            "20, true",
            "4, false",
            "-1, false",
            "105, true",
            "0, true"
    })
    @DisplayName("Test Is Divisible By Five")
    void testIsDivisibleByFive(int number, boolean expected) {
        assertEquals(expected, numbers.isDivisibleByFive(number));
    }
```

In this case, we have tested with five different parameters which includes both boolean `true` and `false` outcomes.

## 4. `@CsvFileSource`

Yet another way to test is using files. In the file, we can provide list of parameters for the test. This can be very useful when we want to test several cases and probably writing those parameters in the annotation might unnecessarily pollute our test class.

For this, I have created a file with name `divisible_by_five.csv` in `src/test/resources` directory with the below content in CSV format.

```csv{lineNos=false}
5, true
6, false
-500, true
0, true
```

The test method for this looks like below.

```java
    @ParameterizedTest
    @CsvFileSource(resources = "/divisible_by_five.csv")
    @DisplayName("Test Divisible by Five using CsvFileSource")
    void testIsDivisibleByFiveUsingFile(int number, boolean expected) {
        assertEquals(expected, numbers.isDivisibleByFive(number));
    }
```

We can also provide additional values in the `@CsvFileSource` annotation to customize the parameter passing into the test method.

This was a quick tour of how to write Parameterized tests using JUnit 5. These are very useful when we want to write multiple test cases to verify the functionality.