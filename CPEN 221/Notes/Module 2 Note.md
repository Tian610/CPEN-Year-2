# Module 2 Notes
### October 19 2024

## Mutability

Primitive Types are immutable by nature, like int and String. This means the *value* of any variable `x` is immutable. The variable itself, however, can never change to anything else. In other words, the memory address `x` points to cannot be changed. However, what `x`'s pointer can be changed to a new memory address, hence how we can update ints and Strings with new values.

Mutations, for the most part, is behaviour we want to control. Users and methods should not be able to inadvertently modify Objects without our express understanding and knowledge of it.

Since Objects in Java are passed by reference and not value. **ANY** object that is passed has the risk of Mutability associated with it. to prevent this, we use defensive cloning, but that is easy to forget.

### **Frame Condition**
- A *modifies* clause. Lets us know in the spec that the method changes something.

## Abstraction

