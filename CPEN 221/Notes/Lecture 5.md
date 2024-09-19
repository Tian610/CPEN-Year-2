# **CPEN 221 Lecture 5: Exceptions, Unit Testing, and Specifications**
### September 19 2024

## **Exceptions**
- Document all exceptions thrown by methods
  - Both unchecked and checked exceptions
  - Do not declare unchecked exceptions

### Cleaning up

- After catching an exception, make sure to clean up the code and ensure nothing is broken
  - Use the `finally` method after a `try catch` to close files, for example.
  - Or, maybe open files in the `try` itself (try with resources):
  
  ```java
  try (DataInputSteam dataInput = new DataInputStream(newfileInputStream(fileName))) {
    return dataInput.readInt();
  } catch {
    //...
  }
  ```

Exceptions Summary
- Avoid corner cases with checked exceptions
- Use the Compiler to enforce error-handling when possible


## Unit Testing

### **Formal Verification**

- The best way to show you're correct in code is with respect to a formal specification.
  - Effectively, prove that literally every possible execution of an implementation will fulfill the specification.
  - This sounds nice, but it takes a lot of manual effort, some automation, recall that math is not decidable (so you don't know if it works for *every* possible case), and it requires a formal specification

### **Testing**
- Okay, formal verification is a lil too hard.
- We can use code Testing instead!

How do we test?
- Automated Testing:
  - Execute a program with specific inputs
    - check output for expected values
  - Test small pieces of the program
    - Easier than testing user interactions
  - Set up testing infrastructure
    - Test often, create test cases

- Fuzz Testing:
  - We will not use it, but its a test where we use random inputs across some range where we expect failure.


### **Unit Tests:**

For "small" units: methods, classes, subsystems:
- Unit is the smallest testable part of system
- Test the parts before assembling them
- Intended to catch local bugs

Typically, (but not always) written by developers. We use many small, fast-running, independent tests with little dependencies on other system parts or environment. Unit tests may be insufficient, but they're a good starting point.

## Specifications

