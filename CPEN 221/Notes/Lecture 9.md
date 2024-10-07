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

    // chat im fucking dying
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