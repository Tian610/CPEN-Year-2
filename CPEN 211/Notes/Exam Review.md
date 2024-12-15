# CPEN 211 Exam Review

### December 14 2024

# Slide Set 10: Adders

## Half and Full Adders
Addition is performed, like everything else, via circuits and the basic gates we've been introduced to.

**Half Adders**
- Two binary inputs, one binary output of 0, 1, or 2
  
**Full Adders**
- Three binary inputs, one binary output of 0, 1, 2, or 3

One thing we need, however, is a carry over. For 1+1 for example, we need two bits to represent it, so we must "carry over" a bit just like we would with regular addition. This is represented in the following diagram:

![alt text](image-14.png)

And in the following verilog code for a half adder:

``` Verilog
// half adder
module HalfAdder(a,b,c,s); 
    input a,b ;
    output c,s ; // carry and sum
    wire s = a ^ b ; 
    wire c = a & b ; 
endmodule
```

A full adder can be mplemented as:

``` Verilog
// full adder - logical 
module FullAdder2(a,b,cin,cout,s) ; 
    input a,b,cin ; output cout,s ; // carry and sum
    wire s = a ^ b ^ cin ; 
    wire cout = (a & b)|(a & cin)|(b & cin) ; // majority endmodule
```

Or alternatively, made out of half adders:

``` Verilog
module FullAdder1(a,b,cin,cout,s) ; 
    input a,b,cin ; 
    output cout,s ; // carry and sum
    wire g,p ; // generate and propagate 
    wire cp ; HalfAdder ha1(a,b,g,p) ; 
    HalfAdder ha2(cin,p,cp,s) ;
    assign cout = g | cp; 
endmodule
```
We can make multi-bit adders by chaining together full adders:

![alt text](image-15.png)

Here, we begin at the bottom. We add the LSB of `a` and `b`, take their value, and send the carry over to the next full adder. In this way, we can compute addition for an arbitrary number of bits!

> Note, I think it's quite interesting how this adding procedure is practically identical to how we were taught to add as kids!

What we just described above is a ***Ripple Carry Adder***, which in verilog looks something like:

``` Verilog
module Adder2(a,b,cin,cout,s) ; 
    parameter n = 8 ; 
    input [n-1:0] a, b ;
    input cin ; output [n-1:0] s ; 
    output cout ;

    wire [n-1:0] p = a ^ b ;
    wire [n-1:0] g = a & b ; 
    wire [n:0] c = {g | (p & c[n-1:0]), cin} ; 
    wire [n-1:0] s = p ^ c[n-1:0] ; 
    wire cout = c[n] ; 
 endmodule
```

## Negative Numbers

How do we represent negative numbers in binary? It's not like we can just append a little dash to the beginning (or maybe you can idk put unicode in ur binary, not my problem)

There are three ways to do this:

**Sign Magnitude**
- Append a `0` to the MSB for positive and a `1` for negative.
  
**One's Complement**
- Flip all bits in the number.

**Two's Complement**
- Flip all bits in the number and then add `1`.

To convert back from negative to positive, just do the operation again! Imagine it like mulitplying by `-1`.

## Two's Complement

For this part of the course, at least, we'll be using *Two's Complement.* Why? It make **subtraction** really easy. Essentially, we represent any number $x$ as $2^x-x$. Then, instead of subtracting, we can just add to do arithmetic! Take the example below of 1 - 2:

$$
\begin{align*}
    1 = 0001 \\
    -2 = 1110 \\
    0001 + 1110 = 1111 \\
    1111 = -1
\end{align*}
$$

So now, we don't need to implement a subtraction circuit in a CPU! That's pretty cool!

However, we have one slight issue...

### Overflow my bitch

If we use two bits, and we want to add 1+1, we run into an issue. THe binary representation of this is `10`, which, if we allowed signed numbers, means that `2` gets interpreted as `-2`! So how do we solve this?

Well, unfortunately, there's not a great way. But, we can at least identify if its happened or not! Here's the formula for it:

<center>If inputs share the <i>same</i> sign...</center>
<center>But the result is a <i>different</i> sign...</center>
<center>Then you've got overflow!</center><br>

It's not too difficult to detect this onboard the circuit. Simply check the most significant bits of the inputs against the most significant bits of the output!

# Slide Set 11: CaseX, Read Write Memory, and Datapath State Machines

## Casex

Let's introduce a brand new verilog function! The `casex` function! So what does it do? Well, `casex`, like a `case`, takes in an input but allows `x` in the corresponding cases. What does that look like?

``` Verilog
casex(in)
    4'b0xx1: value = true;
    default: value = false;
endcase
```
Here, `in` can take on the values:
- `4'b0001`
- `4'b0011`
- `4'b0101`
- `4'b0111`

And these would all be considered one case! As per usual, `x` just means don't care, so we simply ignore those bits and check `in[3]` and `in[1]` in this case. This can be very useful for implementing KMAPS (god i hate those things) in Verilog! For example, if we had a cover like `0xx1`, then instead of making individual cases, we can now take the entire cover as a single term in our case statement.

> Note: If the select input (`in`) contains unknown signals like `x`, Verilog will match it with `0`,`1`, and `x` in case labels. So `in = 4'b011x` would match with `4'b0xxx`. This behaviour could be dangerous!

## Datapath State Machines

Recall that a finite state machine is just a register that stores the current state, a function that computes the next state, and a function that computes the output, as illustrated:

![alt text](image-16.png)

A Finite state machine relies on, well, *finite* logic. We need to specify every possible state and how to get to each of them. But this is kinda bad when we need a state machine to compute an arbitrary number of states. Take a counter, for example, counting to 100, 1000, 10000? They all take vastly different numbers of states. Instead of making *finite* states, we use a *datapath* to control the states. So in the case of our counter, we have:

``` Verilog
    if (clk) counter = counter + 1;
```

A great upgrade from:

``` Verilog
    case(count)
        1: count = 2;
        2: count = 3;
        3: count = 4;
        ...
    endcase
```
Now, this example is obviously oversimplified, but it gets the message across. Also be on the lookout for *Symbolic State Tables*, like this example for the counter again:

state | next_state
|-|-|
1|2
2|3
3|4
...

Which we now replace with:
state | next_state
|-|-|
count|count+1

Isn't that so much easier on the eyes?

## Read Write Memory

So, it suddenly hit CPU manufacturers one day that, maybe it'd be a good idea to *save* some of that information we just computed, so now we have **RAM!** (my beloved ddr5). Let's start with some definitions:

- **Address**: A location in memory
- **Address Space**: Total number of addresses
- **Addressability**: The number of bits in each address

Let's recall my boy the **Level-Sensitive D-Latch**, this basic address system is how we'll store data. By chaining hundreds of d-latches together and incorporating selectors, decoders, and multiplexers, we can create something like:

![alt text](image-17.png)

A Memory module! Which allows us to select memory locations (rows) and write or read from them.

# Slide Set 12: Arbitrary Digial Systems:

Sometimes, we don't want to create specific systems that can only solve one task. We want systems that can do everything! So how do we do that? Well, we can create on by combining a Control Finite State Machine and a Datapath.

## We can start with a quick example:

**Multiplier:**

Let's imagine a circuit that multiplies two numbers and outputs their result, pretty simple right?

Now, let's buff this up and try to create a design that can calculate an arbitrary exponent of two numbers $x^a$. Logically, we could use the multiplier to multiply x by itself, but we would need a lot of multipliers chained together, and if $a$ is arbitrary then we're kinda stuck.

But now, we know what datapaths are! So let's just define one that does the job for us! Something like:

![alt text](image-18.png)

Now, this example isn't exactly complete, but it gives us a good enough starting point.

So, what's the procedure for this process to design a FSM Controller?

- Manually, work out a timeline of what needs to
happen on each rising edge of clock for sample
inputs.
- Use timeline to add states and determine
outputs. Things to keep in mind while doing this:
  - Each clock cycle corresponds to being in a given state
in the FSM controller (might stay in a given state more
than one cycle).
  - The datapath update specified by the FSM control
inputs occurs on the next rising edge (e.g., as you
leave the state).

## Tri-State Driver stuff

Recall my boy the Tri-State Driver:

![alt text](image-19.png)

When `enable` is on, `out` becomes `in`. What happens to out when `enable` is off? One might think the value of `out` would be `0`, but that's not true! In actuality, its `z` (high impedance). So when writing a tri-state driver in verilog, make sure to do:
``` Verilog
assign out = enable ? in : {n{1’bz}};
```
And not:
``` Verilog
if (enable == 1'b1)
    out = in;
```
Tri State Drivers are typically used when there are multiple possible outputs on a single wire and we want to be able to select which one to use:

![alt text](image-20.png)

Here, for example, we don't want A to mix with B or C. So if we shut down B and C, we can be sure only A passes into the output. It's kinda like a multiplixer in that sense!

# Slide Set 13: Timing

Hm... What does the clock speed of a CPU actually mean? I mean, I know higher is better, but nobody ever really said *why* higher is better. Let's figure it out!

Per usual, let's start with some definitons. For any circuit, take:

![alt text](image-21.png)

We can define the following:
- **Digital Circuit**: is really just *combinational logic* in between *flip-flop registers*
- **Propagation delay**: is the time for a gate's (like an AND gate) outputto stabilize after its inputs are changed
- **Critical Path**: is the slowest path between registers. This determines the *maximum clock frequency*

Wait, why do gates delay? Isn't electricity like light speed? Well, all gates in practice are modelled as **RC Circuits**, meaning their is some resistance source and some capacitor. Guess what? This bitch ass capacitor like always behaves like a fucking logarithm so there's a charge up time! Yippee!

Unsurprisingly, gates in series accumulate delays, and delays get longer if a gate outputs to more and more gates (fanout), since all the capacitance from the extra gates add up.

**Okay, so now when we deal with Timing analysis, we need to take Gate Delay into account!**

Since we rely so heavily on flip-flops, its a good idea to take a look at those:

## Flip Flop Delays!

First off, D flip-flops work in two **feedback loops**:

![alt text](image-22.png)
![alt text](image-23.png)


From this, we have three timing constraints:

- $t_S$: **Setup Time** - D input steady before posedge `clk`
  - The time it takes to stabalize the first latch feedback loop before the clock changes
  - How early 
- $t_H$: **Hold Time** - D input steady after posedge `clk`
  - The time it takes for the clock to propagate to isolate the first latch feedback loop
- $t_{CQ}$: **clock-to-Q Time** - When output appears on `Q` after posedge `clk`
  - Time for the clock to propagate to the second latch output

Here's the important stuff to remember:
- **propagation delay (gates)**
  - how soon the output changes after an input change
- **setup time (flip-flops)**
  - how early before posedge clk the input has to become stable
- h**old time (flip-flops)**
  - how long after posedge clk the input must remain stable
- **clk-to-Q time (flip-flops)**
  - how soon after posedge clk the DFF’s contents appear on Q


**Now, let's learn how to use all this together:**

## Timing Analysis

![alt text](image-24.png)

Take this circuit. We can find:

**The minimum clock period?**
> Add all the numbers! On the left we have the $t_{CQ}$ of `A`, three counts of $t_{\text{prop}}$, and on the right we have the $t_S$ of `B`, which comes out to: 0.3+1+1+1+0.5 = 3.8 ns

**The Max Frequency?**
> 1/ 3.8 ns = 263.2 MHz

**The slack at 100 MHz?**
> 100 MHz = 10 ns: 10 - 3.8 = 6.2 ns

**Met timing at 100 MHz?**
> Slack is positive so we have room! Therefore yes!

Looking at the example above, what happens if a signal from `A` arrives to `B` too early? If we assume there are no NOT gates, then based on $t_{CQ}$ we have the signal arrive at `B` in 0.3ns after the clock. However, `B`'s hold time is 0.6 ns. Our input to `B` arrived too early! So that violates our timing. What can we do?

***The dumbest fucking thing imaginable of course***
> Aritificially increase the time it takes to get to `B` by adding some gates in the way! Two NOT gates for example would work great here!

So, in summary, we need to know:

- what propagation delay, setup time, hold time, and clk-to-Q time are
- how they arise from the transistor RC model
- finding the critical path given circuit (longe    st delay between flip-flops)
- timing analysis from constraints (max frequency, min period, slack, etc.)
- ways of fixing violations of setup time and hold time

