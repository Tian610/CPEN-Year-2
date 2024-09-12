# **CPEN 221 Lecture 3: Requirements and Specifications**
### September 12 2024

## **The Lore:**

You're a brand new programmer given shitty undocumented code from the last idiot who worked here:

```java
int f(int a, int b) {
    int r = 1;
    while(b > 1) {
        if(b % 2 == 1) {
            r = a * r
        }
        a = a * a;
        b = b / 2;
    }
    return r * a
}
```

So... No useful function or variable names, no documentation, I have utterly zero clue what this function does...

### **So how do we fix this?**  

It's debugging time! We can:
- Run experiments
- Develop a hypothesis
- Discover the bug
- Fix it!

Okay, so let's start with some inputs. We can try `a = 0` and `b = 0`. That, well, doesn't do much. Let's try some more:

- `(0,0) returns 0`
- `(1,2) returns 1`
- `(2,2) returns 4`
- `(3,2) returns 9`
- `(5,2) returns 25`

Okay, so it looks like this program is attempting to compute `a`<sup>`b`</sup> (*in perhaps the most roundabout way possible using binary*) and it seems to work fine, but what about negative numbers?

- `(-3,2) returns 9`
- `(-2,3) returns -8`

Okay, so that worked...  

- `(-2,0) returns 0`
- `(2,-2) returns 2`

Hm... Okay now we have an error, it looks like exponents of `x <= 0` seem to fail for this function.

Usually, we describe exponents as:
$x^y = x*x*x*x...$

More formally:
- if $y = 0 : x^y = 1$
- if $y > 0 : x^y = x^{y-1}*x$

Our formal definition above, however, does not account for the negative space. Unfortunately, our Power function above is `int f(int a, int b) {}`. This is an `Int` type function! Necessarily, basically every case of negative powers results in a fraction, even if we could compute the negative powers we could never get the proper return value.

Now, in mathematics, we would care about this. This is a bastardization of the beautiful world of pure mathematics. In programming however, we don't care about the beauty of math, we just want a functioning program! So we don't need to fix the error, rather, we just have to ensure:

> Any implementation of the Power Function with a range of integers **must disallow negative inputs or produce an error.**

We need specifications because code is far too abstract. Without them, we'd get too easily lost.

### Next Case:
``` java
long g(long x, long y) {
    int s = 53;
    long r = x;
    while (((y >> s--) & 1) == 0) {
        ;
    }
    while(s >= 0) {
        ...
    }
}
```

Hey, what was that `y >> s--` bullshit? That was what we call a `Bitshift`, which simply shifts the binary representation of `y` an `s` number of bits to the right, which is effectively just `y` divided by 2 `s` number of times.

## **Behavioral Equivalence**

### **Rice's Theorem**
> All non-trivial, semantic properties of programs are undecidable.

Basically, it's *very, very* hard to check if two programs are the same thing.

How then, do we check if two functions, programs, etc. run the same or at least produce the same result?

Specifications increase, well, specificity and thus help us determine the specific parameters and return values of a function in an unambiguous way. This alone goes a long way in identifying a function.

### **Example Time!**

Let's say we have a program that returns the first occurrence of a value in an `Array`.

``` java
requires: int a > 4
returns: the first occurrence of a in array b[]
```

Compare this to:

``` java
requires: int a > 4
returns: An occurrence of a in array b[]
```

Although similar, we can now easily determine that these two functions actually have different behavior. Ideally, we'd like to use the first specification. Why? It's simply less ambiguous and thus less likely for a programmer to use incorrectly.

More formally, we can define these as:

- **Preconditions:**
  - Requirements
  - Conditions on state that must be true for the implementation to work
  - Assumptions made by the implementer
  - If not true, results in undefined behavior

- **Postconditions:**
  - Effects
  - What the implementer of the method promises to do
  - Often what the method returns

### **JavaDocs**

So like, we totally already know this but:

- Preconditions $\rightarrow$ `@param`
- Postconditions $\rightarrow$ `@return`
- If shit goes terribly wrong $\rightarrow$ `@throws`

JavaDocs can be formatted as the following to produce documentation:

``` java
/**
 * Finds a value in a given array
 * 
 * @param a - Value that is being searched for
 * @param b - Array to be searched
 * 
 * @return - Returns the index of the first occurrence of a in b.
 * @throws - IndexOutOfBoundsException
 */
```

## **Requirements**

Although most stuff discussing client requirements are basically what we learned in APSC 100/101, we can apply some extra rules to CPEN:

In CPEN, we will take a look at moving from a *Problem Space* to a *Solution Space*, more colloquially, how do we go from talking about user requirements to classes and functions?
