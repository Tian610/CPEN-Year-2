# **CPEN 221 Lecture 5: Specifications**
### September 26 2024

## What makes for a good Specification?

Let's take a look at a bad one first...

``` java
/**
 * Split text into an array a = [ a_0, a_1, ..., a_k ] such that 
 * a_0 + delim + a_1 + delim + ... + delim + a_k is equal to text.
 * 
 * @param text String to be split
 * @param delta String to be split on
 * @return array of substrings of the text.
 */
```

This specification does not touch on a lot of stuff, such as what happens if delim is empty? Or what if the text is empty? What if the text doesn't contain delim? It's a decent starting point, but it is not specific enough. Not even close.

We can improve this by changing the Postconditions and Preconditions to be more specific. Effectively, we want:
- Preconditions should be more specific on *broader* sets of inputs
- Postconditions should be stronger and more specific in defining a *tighter* exact output

## Testing

Black box tests rely only on the implementation. White Box rely on specifications and implementations.