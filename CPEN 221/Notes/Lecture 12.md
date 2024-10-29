# **CPEN 221 Lecture 15: Lambdas and Streams**
### October 29 2024

## Lambdas
Effectively a method without a declaration.
``` Java
(int x, int y) -> x > y;
```
We can use lambdas and streams for many interesting things. For example, filtering:
``` Java
students.removeIf(student -> student.getCampus() != "Vancouver");
```
Sorting too!
``` Java
students.sort((a,b) -> a.getFullName().compareTo(b.getFullName()));
```

Notice how we can just use random variable names like `a`, `b`, and `student` to describe objects in the list of students. These names can be completely arbitrary! To lambdas, they just represent objects within a collection. Of course, we can also just specify the type:

``` Java
intSeq.forEach((Integer x) -> {
    x += 2;
    System.out.print(x);
    }
);
```

One big use of lambdas is to quickly and easily make custom comparators. For example:

``` Java
Set<Integer> tree1 = new TreeSet<Integer>(customComparator);
```

Let's take a look at functional interfaces:

``` Java
public class LambdaExample {
    
    public static int applyOperation(int number, Operation operation) {
        return operation.perform(number);
    }

    @FunctionalInterface
    interface Operation {
        int perform(int number);
    }

    public static void main(String[] args) {
        int result1 = applyOperation(5, n -> n * 2);
        System.out.println("Doubling 5: " + result1);
    }
}
```

We also have streams! Here's an example

``` Java
int sum(int[] arr) {
    IntStream s = Arrays.stream(arr);
    return s.reduce(0, (x, y) -> x + y);
}
```
The 0 here means its the initial value of the `reduce()`.
