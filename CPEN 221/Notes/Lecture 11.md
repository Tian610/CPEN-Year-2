# **CPEN 221 Lecture 13: Subtyping**
### October 22 2024

## Recursive Types 

### **Example: Collecting Items**

Your bag can hold `W` weight and there are `n` items. Each item is worth some value `v` and some weight `w`. You can divide items for their corresponding value. How can we maximize value in our bag?

First, we can figure out some value density:

$$
\begin{equation*}
 P_i = \frac{v_i}{w_i}
\end{equation*}
$$

We can use this to sort items by their value density. This way, we can always just pick the items of highest value density and just take a fraction of whatever remains.

Okay, what if we were now to only allow a full item? No subdivisions. This problem becomes much harder, and realistically one must test for every case... Unless we use recursion.

### **Trees**

Trees are extremely useful data types.
- A Binary tree is a node containing a value and two children that too, are trees.
- We can interpret a tree like:

``` Java
IntTree = EmptyTree + TreeNode(value: int, leftTree: intTree, rightTree: IntTree)
```

When we use TreeSets or TreeMaps, they're using Trees to represent the data.
j