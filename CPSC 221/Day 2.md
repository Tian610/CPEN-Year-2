# Asymptotic Analysis

$T(n) \in O(f(n))$ if there are constants $c$ and $n_0$ such that $T(n) \leq c \times f(n) $ for all $n \geq n_0$

$T(n) \in \Omega(f(n))$ if there are constants $c$ and $n_0$ such that $T(n) \geq c \times f(n) $ for all $n \geq n_0$


## Asymptotic Analysis Hacks
Since our definition of the functions have a scaling factor, we can use that scaling factor to "ignore" low order terms in our $f(n)

> *So if our function is $2^n + n^3 + 3n$, we reduce this to $2^n$.*\
> *Similarly, we have $4n+5 \Rightarrow 4n$*.
> 

We can also eliminate constant coefficients, as in:

> *$4n \Rightarrow n$*\
> *$0.5n\log{n^2} \Rightarrow n\log{n}$*

There are some common functions we ought to list:

- Constant: 𝑂(1)
- Logarithmic: 𝑂(log 𝑛)
- Poly-log: 𝑂((log 𝑛)^𝑘)
- Sublinear: 𝑂 𝑛𝑐 (𝑐 is a constant, 0 < 𝑐 < 1)
- Linear: 𝑂(𝑛)
- Log-linear: 𝑂(𝑛log(𝑛))
- Superlinear: 𝑂 𝑛1+𝑐 (𝑐 is a constant, 0 < 𝑐 < 1)
- Quadratic: 𝑂 𝑛2
- Cubic: 𝑂 𝑛3
- Polynomial 𝑂 𝑛𝑘 (𝑘 is a constant) "tractable"
- Exponential 𝑂 𝑐𝑛 (𝑐 is a constant > 0) "intractable"

We should note though, that there are cases where our simplifications may not be as true as we want it to be. Sometimes, lower order terms do have impacts.

## To code inspection now

So how do we find out the Big-O for a piece of code, let's look at an example:

``` C++
int mystery(vector<int>& arr, int q) {
    for (int i = 0; i < arr.size(); i++)
        if (arr[i] == q)
            return i;
    return -1;
}
```

Here, since we have one loop, we can simplify it to $\log{(n)}$.

Generally, we can count the number of times an inner loop is repeated for each outer loop that is executed:

``` C++
bool hasDuplicate(int arr[], int size) {
    for (int i = 0; i < size-1; i++) {
        for (int j = i+1; j < size; j++) {
            if (arr[i] == arr[j])
                return true;
        }
    }
    return false;
}
```

Our outer loop repeats $n-1$ times, and our inner loop repeats between $1 — n-1$ times. Could this maybe be $O(n^2)$?