# **CPEN 221 Lecture 3: Requirements and Specifications**
### September 12 2024

### **The Lore:**

You're a brand new programmer given shitty undocumented non-functioning code from the last idiot who worked here:

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

### So how do we fix this?

It's debugging time! We can:
- Run experiments
- Develop a hypothesis
- Discover the bug
- Fix it!

