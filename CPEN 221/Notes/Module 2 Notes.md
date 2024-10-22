# Module 2 Notes
### October 19 2024

## Mutability

Primitive Types are immutable by nature, like int and String. This means the *value* of any variable `x` is immutable. The variable itself, however, can never change to anything else. In other words, the memory address `x` points to cannot be changed. However, what `x`'s pointer can be changed to a new memory address, hence how we can update ints and Strings with new values.

Mutations, for the most part, is behaviour we want to control. Users and methods should not be able to inadvertently modify Objects without our express understanding and knowledge of it.

Since Objects in Java are passed by reference and not value. **ANY** object that is passed has the risk of Mutability associated with it. to prevent this, we use defensive cloning, but that is easy to forget.

### **Frame Condition**
- A *modifies* clause. Lets us know in the spec that the method changes something.

## Abstraction

An Abstract Data Type (ADT) allows us to separate how we use a data structure from the particular form of it. This allows us to use data types in a broad sense without worrying about its details or implementation.

In essence, Abstraction is the art of hiding details with a simpler, high level idea.

| Operation Types         | 
| ----------------------- | 
| Creators / Constructors | 
| Producers               | 
| Mutators                | 
| Observers               | 


## Designing an Abstract Data Type

Here are a few rules of thumb:

It is better to have few, simple operations that can be combined in powerful ways.

Each operation should have coherent behaviour rather than special cases. For example, List shouldn't have a "sum all elements" since users might not be working with numbers.

The type could be generic or specific, but those elements should never mix.

**Representation Independence**

Importantly, a good ADT should be representation independent. That means the use of the type is independent of its implementation. The implementation should be able to be changed near entirely without modifying functionality whatsoever.


**Interfaces**

Java's interface allows for a programmer to create a class with method signatures but no method implementations. As such, all classes that implement an interface must also implement all methods explicitly required by the interface. This helps in two major ways:

- Implementation and Specification/Contract are completely separated. A client needs only to obey the interface to ensure they're using a datatype properly
- Different representations of the same abstract data type can be used in the same program and can even be compared or interact with one another.

**Invariants**

Invariants are properties of a program that is always true for every possible runtime. For example, Integers should always be whole numbers. It is very important that a data type preserves its own invariants.

**Representation Exposure**

Code outside the class should never be able to modify the representation in the class directly. This threatens not just invariants but also representation independence.

To prevent Rep Exposure, we should use encapsulation, defensive copying, and above all ensure immutability of our data types, at least from unwanted outsiders. In other words, Creators and Producers must establish the invariant and all mutators and observers must preserve that invariant.

## Representation Invariants

The simple idea behind a Representation Invariant is that we should choose representations that can represent all possible abstract values the class can hold. Different RIs can result in varying degrees of efficiency and ease of programming. RIs also give us the ability to check if the RI holds using methods like `checkRep().`

## Equality

Java, on its own, provides us two methods for checking equality

`==`
- Tests for *referential* equality. Two references are equal if they point to the same memory address. 
`equals()`
- Tests for object equality. Compares objects contents to check if they are equal.

By default, `equals()` checks only for referential equality. We need to override it to change that.

Here, we need to be very specific on what equivalence really is. It must define a relation that is reflexive, symmetric, and transitive. It must be consistent, and hashCodes must be identical.

By default, Java gives Objects hashCodes based on their memory address. As such, two objects that we may consider equal could be considered not because they're stored at different memory addresses. This could have drastic consequences. Hence, we should always define hash codes for data types we create.

## Mutable Equality 

Mutation makes equality hard to determine. Observational Equality is no longer enough and we must turn to Behavioral Equality, where we test if the objects behave the same way, and not just appear the same.

**For immutable types:**

- equals() should compare abstract values. This is the same as saying equals() should provide behavioral equality.
- hashCode() should map the abstract value to an integer.
- 
So immutable types must override both equals() and hashCode().

**For mutable types:**

- equals() should compare references, just like ==. Again, this is the same as saying equals() should provide behavioral equality.
- hashCode should map the reference into an integer.

## Subtyping

## Functional Interfaces

Functional Interfaces are interfaces with exactly one method. We also introduce something new: Lambda expressions

``` Java
final Comparator NON_DESCENDING = (i, j) -> i < j;
```

Lambda expressions are anonymous functions that can be passed as parameters to other functions.

We also introduce **Delegation**, the act of passing functionality (not data) to another object.

## Subclassing

We can create a subclass of a class by using the `extends` keyword in the class declaration. This subclass will now have all methods from the superclass and can call them using the `super` keyword. Still, it can override or overload any super methods.

## The Liskov Substitution Principle

In essence, the LSP states that nay subtype must be substitutable for their supertype. Or in other words, a subtype must fulfill the same contract as the supertype. This is *not* the same thing as a subclass.

For example, a superclass of a List Object allows any Object in its add() method. Its subclass, (StringList) overloads it and allows only Strings. However, the original add() still exists. Thus, the superclass broke the subclass' rep invariant.

Another issue with subclassing is the contract itself. The superclass can never change its implementation since any modification could break the implementation in its subclass'. Thus, either the superclass freezes forever or the subclasses must always evolve with it.

Mutability also presents a problem for subtyping. Mutable subtypes may not obey the LSP for its immutable supertype.

Also, recall that

- Overriding replaces a method with another
- Overloading creates multiple methods with the same signature

These are not the same thing.
## So how should we subtype?

Subclassing, as we've seen, is not ideal. Nor is subtyping using implements. The problem is that with both, it's far too east to violate the LSP, perhaps more broadly. We can't be sure that every subtype truly is an object of its supertype.

One recommendation is that—instead of extending or implementing—we simply use a protected instance of the class we want to extend. In our StringList example, instead of overriding or overloading List methods. We simply call List methods within StringList, thus removing the need for StringList to obey the LSP. We call this **Composition**

## Abstract Classes and Interfaces

An abstract class is a class that can only be subclassed and cannot be instantiated. It can implement some methods and not others, while interfaces cannot.

To implement an abstract class, you must be a subclass. However, any class that meets the required methods can be a subtype of an interface.

Generally, an interface is preferred because any class can implement it by adding new methods to meet its requirements.

However, retrofitting a class so it can be a subclass of an abstract class is a much harder task.

