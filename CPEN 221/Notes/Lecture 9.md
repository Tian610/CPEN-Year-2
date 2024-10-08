# **CPEN 221 Tutorial 5: Recursion**
### October 7 2024

## Let's try doing some Basic Arithmetic Expressions:

We're trying to represent every natural number with as little 1's
as possible. Here's what we know:

- 3 = 1 + 1
- 2 = 1 + 1
- 4 = 1 + 1 + 1 + 1 = (1 + 1) * (1 + 1)
- 5 = 1 + 1 + 1 + 1 + 1 = (1 + 1) * (1 + 1) + 1
- 6 = (1 + 1 + 1) * (1 + 1)

Okay, so looks like we're trying to use prime factorizations? But finding prime factorizations is difficult in it of itself, so that seems like a difficult approach.

Let $f(n)$ be the minimum number of 1's we need to represent $n$.
> $n = a + b$ or $n = p \times q$

$$
\begin{equation*}
 f(n) = \text{min}
   \left\{\begin{array}{lr}
        1 \text{ if $n$ = 1}\\
       \text{min}\{f(a)+f(b)\} \\
       \text{min}\{f(p) \times f(q)\}
    \end{array}\right.
\end{equation*}
$$
This representation checks both interpretations of $n$ and returns the minimum possible value that can represent it. Now let's try a code interpretation:

``` java
private static int min1s(int n) {
    if (n == 1) {
        return 1;
    }

    min1 = n; // We know number of 1s cannot exceed n

    for (int a  = 1; a <= n / 2; a++) {
        int temp = min1s(a) + min1s(n - a);

        if (tmp < min1) {
            min1 = tmp;
        }
    }

    for (int p = 2; p <= n / 2; p++) {
        if (n % p == 0) {
            int tmp = min1s(p) + min1s(n - p);

            if (tmp < min1) {
            min1 = tmp;
            }
        }
    }

    return min1;
}
```

Now, this method works just *fine*,  but it's using a recursive method that makes a *lot* of function calls. Any large number will take a long time to compute. So maybe we should try a different approach. This time, let's store computed values in an array so the method doesn't need to constantly recompute values:

``` java
public static int min1sI(int n) {
    int[] min1 = new int[n + 1];
    min[1] = 1;

    for (int i = 2; i <= n; i ++) {
        min1[i] = min1[a] + min1[n - a];
    }
    
    for (int p = 2; p <= Math.sqrt(n); p++) {
        if (n % p == 0) {
            int tmp = min1[p] + min1[n - p];
            if (tmp < min1) {
            min1 = tmp;
            }
        }
    }

}
```

# **CPEN 221 Lecture 9: Abstract Data Types**
### October 8 2024

## Abstraction

Abstraction is a software design principle that spans many ideas and different ways of looking at the why or what. Below are some common names for Abstraction:

- **Abstraction:**
  - Omit or hide lower-level details with a simple higher level idea
- **Encapsulation:**
  - Building components in a way that shields them from bugs in other parts of the program
- **Information Hiding**
  - Hiding implementation details of each component from the rest of the system so implementations can be modified easily.

So what characterizes an Abstract Data Type?

- The operations that can be performed on it
  - i.e. Strings can be concatenated
- The key idea is that instead of thinking about how a type stores values, programmers need to think about operations on the type.

## Classification of Types

### Mutable
Includes operations that alter the object such that other subsequent operations on the same object give different results
- i.e. `StringBuilder`
### Immutable
Object is not designed to change once created. Often, *changing* the object involves a new object being created and not modification of the existing one.
- i.e. `String`

`ImageTransformer` from MP1, for example, is immutable since all outputs are *new* images unconnected to the main data held, that being the `image` defined in the constructor. On the other hand, `Image` itself is mutable.

## Classification of Operations

### Creators/Constructor
Create new objects of a type, may take arguments but not of the same type being created.

### Producers
Create new objects from old objects of the same type
- i.e `concat()` creates a new `String` object from two existing ones.

### Mutators (Setters fall under this)
Alter the object
- i.e. Java `List` objects have an `add()` operation.

### Observers (Getters fall under this)
Take as input an object of the abstract type are return a different kind of object
- i.e. The `size()` method of Java's List.

## Let's look at an example: Java's primitive `double`

| Operation Types         | Operations                        |
| ----------------------- | --------------------------------- |
| Creators / Constructors | Literals: 1.0, 2.0, 3.0, ...      |
| Producers               | Arithmetic Operations: +,-,*, ... |
| Mutators                | None (Why?)                       |
| Observers               | Comparison Operations: ==, >, ... |

Interestingly, when we say, set `double x = 2.0`, we don't need a constructor, whereas for something like `DNA` we need to write `DNA dnaX = new DNA()`. This is because Java has built in support for `double`, and thus supports this type of special constructor.

Now, since `double` has no mutators, we assume it's immutable, right? How then can we change the value of `x`? Well, when we use an operation like `x += 0.1`, what Java actually does is create a brand new `double` and store it in the memory location of `x`. Whereas for `DNA`, the method `mutateCodon()` would actually modify the data that `dnaX` itself holds.

## Designing Abstract Data Types
- Better to have simple operations that can be combined in complex ways

## Choosing a Representation
For the client of a type, operations are the most important thing, but as for designing, we must think about the representation:

- Actual data structures used internally to support operations on an abstract data type
- In practice, the collection of fields of the java object, where each field is a java type (including of the same type as the ADT objects)

### Let's use Complex Numbers as an example:
What do we need to represent it in a useful way to a client?
- Add
- Subtract
- Divide
- Conjugate
- Magnitude
- toString
- Real
- Imaginary
- $\dots$

Okay, that's a lot, but we'll try to come up with a implementation:

``` java
class ComplexNumber {
    private double realPart;
    private double imaginaryPart;
    // Or maybe...
    private double r;
    private double θ; // Theta

    public ComplexNumber() {

    }

    ComplexNumber add(ComplexNumber other) {
        ...
    }
}
```

As we can see, there are lots of different representations, we can use real and imaginary, magnitude (r) and $\theta$ (theta), lots of choices. We could even use both! But it's important for us to define these representations so we know what types and ease of operations we can perform on them. It's a lot easier to add complex numbers using real and imaginary, for example.

The important thing, however, is that our representations *don't matter* to a user of our datatype. Internal implementation isn't what's important here, so our choice of representation doesn't matter to a client. Like before, as long as our representation and implementation match the functionality defined by the Specification, we're good to choose anything.

## Reasoning about the Correctness of Software

### Static Analysis
What do we know about the program before we run it?
A compiler can carry out some basic analysis, for example, when we do `x = y`, the compiler checks to see the types match.

Compiler analysis, however, can be incorrect. For example:

``` C

while (1) {
    if (a^3 = b^3 + c^3) {
        return 1;
    }
}

return 0

```

This method is supposed to return 0, but it returns 1. Why? Because the compiler sees that the while loop only has one exit condition, which is to return 1. As such, it assumes that the while loop will always return 1 and simply does just that.

