# **CPEN 211: Verilog Time! Part 3**
### October 8 2024

### For purely combinational always blocks:

Rule 1: Every input that can affect the output(s) must be in the sensitivity list or use the wildcard @(*) or use SystemVerilog "always_comb" instead of "always".

Rule 2: Every output must be assigned a value for every possible combination of the inputs. **ALWAYS REMEMBER RULE 2 OR VERILOG WILL MAKE INFERRED LATCHES.**

### Examples:

``` Verilog
always @(A or B) begin
 if (SEL == 1'b0)
 Y = A;
 else
 Y = B;
 end
```

In this case, `SEL` can affect the output but isn't declared in the sensitivity list `@(A or B)`. So this violates ***Rule 1***.

``` Verilog
always @(SEL or A)
 if (SEL == 1'b0)
 Y = A;
```

In this case, the always block does not take into account possibility that `SEL == 1'b1`, so this would violate ***Rule 2***.

## Flip Flops: The Simulator View

D-Flip Flop rules:
- At the rising edge of `clk`, `D` copied to `Q`
- `Q` retains value until next rising edge of `clk`

``` Verilog
module dff(input clk, input D, output Q);
    reg r; // Variable to retain value (reg)
    assign Q = r;

// posedge is the rising edge of clk
always_ff @(posedge clk) begin // block executed whenever posedge clk happens
    r <= D; // Non-blocking assignment for register updates
end
endmodule: dff
```

### Synthesis Rules for inferring flip-flops

- remember: reg may or may not create a register
- synthesis tools infer a register when:
    - a variable is declared as reg
    - variable is written in exactly one `always_ff @(posedge someSignal)`
block
- `someSignal` becomes the register’s clock
- and is not written or assigned elsewhere in any way
- this pattern ensures DFF behaves the same way in simulation and in real hardware

``` Verilog
module dff(input clk, input D, output reg Q);
    always_ff @(posedge clk) begin
    Q <= D;
    end
endmodule: dff
```

The above? It just works. Just assume it works. Don't question it. It'll work, don't even think about why it works. I don't know why it works. Tor doesn't know why it works. Move on already.

## Testing and Testbenches

Goal: Test if our design works before building hardware

If the design does not work, our testbench makes it easier to identify bugs *during simulation*

### The Initial Block (Used only for Testbenches)

DUT - Device Under Test

``` Verilog
initial begin
    <sequence of statements in which order matters: delays allowed>
end
```
- Initial Blocks are **not synthesizable** - Use ONLY for test bench "scripts"
- Delays are allowed:
  - Use delays with ` #<number of time units>;`
- To check the output, we use `$display`, the equivalent of printing to terminal

### Let's try a testbench for a Majority Gate:

``` Verilog
module Majority(a, b, c, out) ;
    input a, b, c ;
    output out ;
    assign out = (a & b)|(a & c)|(b & c) ;
endmodule
```

Okay, testbench time!

``` Verilog
module test_maj;
    reg [3:0] in;
    wire out;
    Majority DUT(in[0], in[1], i[2], out);
    
    initial begin;
        in = 3'b000; // Set in
        repeat(8) begin
            #100;
            $display("in = %b, out = %b", in, out);
            in = in + 3'b001;
        end
    end
endmodule
```

