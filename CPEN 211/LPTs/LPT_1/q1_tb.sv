module tb();
    reg clk, reset;
    reg [1:0] in;
    reg [1:0] out;
    reg [2:0] present_state;

    assign present_state = tb.dut.state;

    top_module dut(clk, reset, in, out);
    
    initial begin
        reset = 1'b1;
        in [1:0] = 2'b00;
        clk = 1'b0; #5;
        
        clk = 1'b1; #5;
        reset = 1'b0;
        
        in = 2'b01; // go to e
        clk = 1'b0; #5;

        clk = 1'b1; #5;

        in = 2'b00;
        clk = 1'b0; #5;

        in = 2'b01; // go to c
        clk = 1'b1; #5;

        clk = 1'b0; #5;

        in = 2'b11; // go to b
        clk = 1'b1; #5;

        clk = 1'b0; #5;
        in = 2'b11; // go to a

        clk = 1'b1; #5;
        in = 2'b10; // go to b

        clk = 1'b1; #5;

        reset = 1'b1;
        clk = 1'b0; #5;
        clk = 1'b1; #5

        $stop;
    end
endmodule: tb

// radix define MyStates { 3'b000 "A", 3'b001 "B", 3'b010 "C", 3'b011 "D", 3'b100 "E", -default bin }