# Module 4 Notes

# Intro to Concurrency

Defining some Distinctions:

Parallel Programming is about using additional resources to produce answers faster

Concurrent Programming is about correctly and efficiently controlling access to shared resources

**Let's begin with threads!**

The model we will assume is *explicit hreads with shared memory*. Each is it's own sequential program, but it can communicate by writing and reading to and from fields in shared memory.

If there are more threads than processors, we rely on Java to *schedule* everything to run properly. Threads may also be forced to wait for other things to happen before it continues

Threads have their own call stack and program counter, but they all share one collection of static fields and objects in the heap.

**In Java**, we create a runnable thread by creating an implementation of the interface `Runnable`. This class must have a method called `run`. When you instantiate an instance of this class, you can pass it to a a Thread in the constructor and use the `start();` method to run it. 

Importantly, the order in which threads run is non-deterministic, making using threads for calculations where one part relies on info from other parts difficult, since you cannot guarantee the order of the calculation. What we can say is that everything still has to be sequential. If a run class prints "Hello" first and "Bye" after, we should never its Bye before its Hello.

## Other Implementations:

Other implementations for parrallelism include:

**Message Passing**
- Where threads pass messages to communicate. This is good when threads are far apart from one another or shared memory is hard to come by

**Dataflow**
- Different threads are nodes that rely on one another. They can only start when their prerequisite nodes complete computation for data they need.

**Data Parallelism**
- Not actual parallelism, but effectively imagine all primitives and datatypes written to work in parallel rather than sequential. So all parallelism has been done for you already. You just work as you normally do.

# Network Programming

Network Communication is inherently concurrent, so in order to build them we must think about concurrency.

## The Client-Server Design Pattern

In this system, there are clients and servers. Clients initialize by connecting to the server, it sends requests and the server sends replies back.

## Network Sockets

We use IP addresses, which are 32-bit numbers that uniquely define a computer on a system. IP addresses change as you connect to different networks. Hostnames can be assigned to IPs, giving them a more easily understandable name

Computers also have multiple ports. Each port represents a different part that the computer is listening on.

A **listening socket** is used by a server to wait for connections.

A **connected socket** is a two way socket that allows a server and a client to talk back and forth

Since data sent back and forth is cut into packets and aren't all received at once, we need a **buffer** that can store data until we read it.

**Streams**, although we've used them in a different way, they really are a stream of bytes going in or out of a socket. In Java, `InputStream` is used for reading from files, the command line, etc.

**Blocking** is used to make a thread wait until an event occurs. A Blocking method, then, is one that may force its callee to wait.

Blocking is nice, because it means we can write programs assuming read write operations always work, and we don't have to worry about data not arriving or sending in time.

When we actually run parallelism, there is a chance that we may execute code before threads are done—threads that we needed to finish for. In this case, we can run the `join()` method on a thread, which waits for thread to finish before returning.

## Using many Threads

When the work is large enough, using thousands of threads is ideal. Why?

- More threads means processors are always busy.
- If a processor is on a hard thread, other processors can compute smaller threads. 

This does, however, mean more outputs from threads we have to combine to solve the problem. Worse, Java isn't defined for this, so with this much overhead of extra threads we may actually be slower


## Divide and Conquer Parallelism

This is an algorithm where threads create their own smaller threads. For summing an array. We can split the lower and upper half into threads. Then, each half splits their own half into quarter threads. So on and so forth. It's a recursive method!

The main benefit and speedup from the method comes from the fact that we're combining results in parallel, and not sequentially. Each thread figures out its own sum and its parents figure out thei own sums.

What's also useful to remember is that parallelism isn't always faster. One chef is far faster at cutting a single potato than fifty chefs working on one potato. So, parallel methods like the array summer we described above should have a cutoff—a size of the array smaller than some cutoff means we start using sequential methods rather than parallel ones.

Still, despite our efforts, Java's thread framework is just too slow with too much overhead. So, we switch over to:

## The Java ForkJoin Framework

Like threads, but better!

- Instead of extending `Thread`, we extend `java.util.concurrent.RecursiveAction`
- Instead of `start()`, use `fork`!
- Instead of `run`, call the method `compute`!
- `join()` is still called `join()`!

Importantly, there are a few key differences. Outside a thread (in `main`), we use `ForkJoinPooo.commonPoo.().invoke(OBJECT);` to start running the thread. **Inside** a thread, we can use `compute()`, `fork()`, and `join()`. Conversely, do not use `invoke()` inside a thread.

# Shared Memory

We already know why allowing multiple threads to access shared memory is a dangerous thing. It leads to data races that can inevitably ruin data and rep invariants. To stop this, we use **mutual exclusion**, the act of only allowing one thread to access shared memory at a time. When an act is done all at once, meaning its process begins and ends with no interruptions, its called an **atomic operation**.

## Mutual Exclusion Locks (Mutex)

A lock is composed of three ideas:
- `new` creates a new lock
- `acquire` takes a lock and blocks other threads
- `release` lets go of the lock and allows other threads to access it

We can lock methods, but there is a problem. What if we try to call another method that uses the same lock? Well, we can't use it cause its locked. But we're the ones holding the lock! So we get stuck. We can fix this by redefining locks to be **re-entrant**, meaning a thread can hold multiple copies of a lock. The lock is only released when all copies they hold are released.

## Synchronized

Java has a built in lock called `synchronized() {}`. It allows us to pass an object to it that is the lock. So if we pass an array to it, it means that array is locked. For most purposes, we can just pass the object itself! So we get `synchronized(this) {}`