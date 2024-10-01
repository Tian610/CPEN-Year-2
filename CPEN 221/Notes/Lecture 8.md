# **CPEN 221 Lecture 8: Immutability and Mutability**
### October 1 2024

## Example: The Transaction Class:

Let's take a look at the following example of code.
```java
package transactions;

import java.util.Calendar;

public class Transaction {

    static private int recentTransactionId = 0;
```
Making recentTransactionId a global variable for all objects is pretty clever, allowing us to store a commonly updated value across all instances. Also note that the only method to access recentTransactionId is through a getter, ensuring that the variable is protected and immutable to other stuff.

``` java
    private final int amount;
    private final Calendar date;
    private final int transactionId;

    public Transaction(int amount, Calendar date) {
        this.amount = amount;
        this.date = date;
        this.transactionId = recentTransactionId++;

        // This is only to demonstrate how static fields work.
        // Normally constructors should not have print statements.
        System.out.println("Created Transaction #" + transactionId);
    }

    public static int getRecentTransactionId() {
        return Transaction.recentTransactionId;
    }

    public static Transaction getNextMonthTransaction(Transaction t) {
        Calendar d = t.getDate();
        d.add(Calendar.MONTH, 1);
        return new Transaction(t.getAmount(), d);
    }

    public int getAmount() {
        return amount;
    }

    public Calendar getDate() {
        return date;
    }
}
```

Let's also take a look at `Main`:
```java
public class Main {

    public static void main(String[] args) {
        Calendar d = new GregorianCalendar();
        int amount = 100;

        Transaction t1 = new Transaction(amount, d);
        System.out.printf("Month of Transaction t1 is %s\n", t1.getDate().get(Calendar.MONTH));

        Transaction t2 = Transaction.getNextMonthTransaction(t1);
        System.out.printf("Month of Transaction t1 is %s\n", t1.getDate().get(Calendar.MONTH));
        System.out.printf("Month of Transaction t2 is %s\n", t2.getDate().get(Calendar.MONTH));
    }
}
```

If we run main, we get:
```
Created Transaction #0
Month of Transaction t1 is 9
Created Transaction #1
Month of Transaction t1 is 10
Month of Transaction t2 is 10
```

Hm... `t1` gets mutated somehow. This problem arises from the use of `Date`. The code is transaction that gets us the date is:

``` java
public Calendar getDate() {
    return date;
}
```

This code returns the reference to the object and not the object itself! As such, `t2` actually ends up *mutating* the `Date` object in`t1`.

### **How do we fix this?**
- One idea some rando in class threw out is to create a new instance of the `calendar`, which makes sure every instance has its own instance.
- We could also make a new `Date` every time we change `Date` itself
- Perhaps we could implement these in the `getNextMonthTransaction` method
- Or, let's just fix it when we make the `Date` itself:
```java
public Transaction(int amount, Calendar date) {
        this.amount = amount;
        this.date = (GregorianCalendar) date.clone();
        this.transactionId = recentTransactionId++;
    }
```

Since clone is implemented only for `Date's` superclass (`GregorianCalendar`), we need to type cast the `clone()` to a `GregorianCalendar` type to ensure proper duplication.

Alright! Let's rerun our code and:
```
Created Transaction #0
Month of Transaction t1 is 9
Created Transaction #1
Month of Transaction t1 is 10
Month of Transaction t2 is 10
```
Fuck. This thing is still broken. Turns out, we're dumb because although every instance of `Transaction` now has its own instance of `Date` (which is a good thing), our getter method still returns a reference and not a value. Okay, let's fix this properly:

### **Attempt 2:**
``` java
public Calendar getDate() {
    return (GregorianCalendar) date.clone();
}
```
And now...
```
Created Transaction #0
Month of Transaction t1 is 9
Created Transaction #1
Month of Transaction t1 is 9
Month of Transaction t2 is 10
```
Looks like we fixed it! Why all this mess? Because `Date` is a mutable type. Had `Date` been something immutable like `String` or `int`, Java would have simply made a new instance of every time we attempted to mutate/modify it.

### Let's try another example:

``` java
public class MyIterator {
    private final ArrayList<String> l;
    private int i;

    public MyIterator(ArrayList<String> l) {
        this.l = l;
        this.i = 0;
    }

    public boolean hasNext() {
        return i < l.size();
    }
    
    public String next() {
        final String s = l.get(i);
        ++i;
        return s;
    }
}
```

Okay, this too has an issue. But what? `ArrayList` is final, but that doesn't mean the list is immutable. `final` locks in the reference and memory position of the ArrayList, but individual elements of that List can still be mutated! 

Let's touch on another concept for a sec:

## State Machines: Another way to think about mutability
State Machines show a set of states and rules. Following the rules allows you to show how you move from one state to another. We saw this in **CPEN 211**, actually!

In a state machine for a program, the state is represented by instance variables.
- A change in state corresponds to a change in instance variables.
- Events are operations that can be performed on the object.
  - Its methods
- **Mutators** change state.

> We should always assume objects are mutable. AKA always assume worst case scenario so you can make sure things never go wrong. Never, ever, return mutable objects unless it is the intended behaviour

## Summary

- **Mutable Objects** are useful, but introduce difficulties in modeling and testing
- **State Machine** is a simple model suitable for mutable objects
- **Testing Strategies** for state machines can give credible tests for mutable objects

## End of Class Q&A

### **What exactly is an exception? Unchecked vs. Checked?**

Let's take some function: 
``` java
// Requires x > 0 (This is a precondition) 
int f(double x) {
    ...
}
```

Now, this precondition *says* `x > 0`, but we all know programmers break rules, so we need a way to make sure nobody can break our function.
- Perhaps we could use assertions? Sure, it'll work, but assertions aren't in the program itself (not really) and that means an end user can simply disable assertions.

Instead, we'll throw an exception (we'll also add some more details to our method):
``` java
// Requires x > 0 (This is a precondition) 
int sqrt(double x) {
    if (x <= 0) {
        throw new IllegalArgumentException();
    }
    ...
}
```

`IllegalArgumentException()` is an Unchecked exception, meaning the client does not have to use a try catch. We shouldn't force the user to create a try catch because:
- Nobody wants to wrap their method call in a try-catch
- It's not in our specification

Since we've properly specified the preconditions, it is up to the end user to properly implement the method. Okay, so that's a good bit on Unchecked Exceptions. What about our mortal enemy the Checked Exception? 

We use the Checked Exception when there is a **reasonable** outcome leading to the exception. Okay, what the fuck is a reasonable outcome thought? For example, an access control system with a keycard and a reader has a perfectly reasonable use case to throw and catch an `AccessDeniedException()`.

So for the most part, the difference between Unchecked and Checked Exceptions is:
- Checked Exceptions need a try catch block
- Only Checked Exceptions should be properly listed in the specification
- Checked Exceptions should be used in the case of **reasonable** outcomes

### **What is a Stack?**

Functions are executed Last in First out (FILO). 