# **CPEN 221 Lecture 12: Subtyping**
### October 17 2024

## What is Subtyping?

B is a subtype of A means...

"Every object that satisfies interface B also satisfies Interface A"

In other words, the specification of B must be at minimum as strong as the specification for A

### Subtypes are substitutable for Supertypes
- Instances of subtype shouldn't fail the supertype's specification
- Instances of subtype shouldn't have more expectations than the supertype's specification

