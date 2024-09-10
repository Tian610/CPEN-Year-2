# **CPEN 221 Lecture 2: Data Abstractions**
## September 10 2024

### If we want to keep track of unique words in a document...
We could use an array, or List, but a *set* would allow us to keep only unique words:

``` java
Set<String> uniqueWords = new HashSet<Strings> ();
uniqueWords.add("Hello World");
```

Looking back maybe this could've been useful for the `TimeSeries` project we were working on...

### What about a system that can keep track of student IDs and their grades?

A *map* would give us the ability to keep everythign in check together...

``` java
static Map<String, Float> gradebook = new HashMap<String, Float>();
gradebook.put("98253289", 60.00);
```
Every entry of `Maps` and `HashMaps` use a Key `k` and value `v`.

### Problem: Checking for Valid Brackets

Can we make a program that can check if all brackets in a statement line up with another opposite bracket of the same type?
- 12[19}, for example would be invalid.
- {55}[91{11}] would be valid

Turns out, all we really need to do is—assuming we remove all the numbers—just check starting from the inside and see if two matching brackets are next to each other. We can easily do this with a `Stack`. Why `Stacks`? Because they work on a First-in Last-Out (LIFO) methodology. Since for the specific case of brackets we only care about *the most recent entry*, `Stacks` work perfectly for us. 

eh why not let's just try fucking coding it:

``` java
Stack<char> bracketStack = new Stack<char>();
String test = "(55)[91{11}]";

for(int i = 0; i <String.length(); i++) {
    if(String.charAt(i) == '['  String.charAt(i) == '{') {
        bracketStack.push(String.charAt(i));
    } else if(String.charAt(i) == ']' && bracketStack.peek() == '[') {
        bracketStack.pop();
    } else if(String.charAt(i) == '}' && bracketStack.peek() == '{') {
        bracketStack.pop();
}

if(bracketStack.empty() == true) {
    return true;
} else {
    return false;
}
```

### Next Problem: Finding the K-th largest element in an Array
- Input: [5,2,1,3,6,4], k =2
  - Output: 5

Now, the shitty programmer in me just wants to write a sorting algorithm, but apparently I'm not allowed to sort for this program so fuck. One other solution is that we can make a new Array, where we list the largest elements we find in a sorted order. Admittedly we are kinda still sorting but idk the prof said it was okay.

Now, one better way to solve this problem is using a `Priority Queue`. This datatype *basically* creates an array of size `k` that collects values and gets rid of the smallest element(s) when you add more elements than `k`.

``` java
int[] a;
int k;

PriorityQueue<Integer> minHeap = new PriorityQueue<>(k);

for(int num : a) {
    minHeap.add(num)
    if(minHeap.size() > k) {
        minHeap.poll()); // Removes the smallest element if we go above k
    }
 }
 
 return minHeap.peek(); // returns the smallest element
```

### Why didn't we just use easier datatypes for all these problems?

Every question so far could have been solved with a `List`, instead of a `Set`, or `Map`, or `Stack`, or `PriorityQueue`? So why didn't we just use that?

Well, by limiting our abilities with these more restricted datatypes, we can actually start thinking of more interesting solutions. Limitation breeds creativity. Certain Datatypes also just make things easier. Rather than writing a sorting algorithm, `PriorityQueue` makes our code shorter, more efficient, and easier to debug. Less lines of code is less lines to debug.