module tb();
    reg clk, reset;
    reg [1:0] in;
    reg [2:0] out;

    module_name dut(clk, reset, in, out);
    
    initial begin
        in [1:0] = 2'b00;
        clk = 1`b1 #5;
        $stop;
    end
endmodule: tb

// radix define MyStates { 2’b00 "Foo", 2’b01 "Bar", 2’b10 "Baz", -default bin }