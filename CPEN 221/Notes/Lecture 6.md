# **CPEN 221 Lecture 5: Testing**
### September 24 2024

## A Case Study

What should we test in this code?

``` java
public boolean pay(int cost) {
    if (cost <= this.money) {
        this.money -= cost;
        return true;
    }
    return false;
}
```

- We can test scenarios when we have enough money and when we don't have enough money.
- We can test for negative costs

Okay, let's try a more complicated method:

``` java
public boolean pay(int cost, boolean useCredit) {
    if (useCredit) {
        if (this.credit + cost <= this.maxCredit) {
            this.credit += cost;
            return true
        }
    }

    if (cost <= this.money) {
        this.money -= cost;
        return true;
    }
    return false;

}
```

### **Coverage**

We have tested every statement, is that it? That depends on our desired coverage:

- Provide at least one test for every distinct type of behaviour
- Typically on control flow paths through the program
- Statement, branch, basis paths, MC/Dc, etc.
