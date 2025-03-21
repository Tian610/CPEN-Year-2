module q2_tb;
    reg clk, reset;
    reg [3:0] in;

    initial begin
        // 0
        clk = 1'b1;
        reset = 1'b0;
        in = 4'b0000;

        #5; // 5
        clk = 1'b0;
        reset = 1'b1;

        #5; // 10
        clk = 1'b1;

        #5; // 15
        clk = 1'b0;
        reset = 1'b0;
        in = 4'b0110;

        #5; // 20
        clk = 1'b1;

        #5; // 25
        clk = 1'b0;
        in = 4'b1101;

        #5; // 30
        clk = 1'b1;

        #5; // 35
        clk = 1'b0;
        in = 4'b1001;

        #5; // 40
        clk = 1'b1;

        #5; // 45
        clk = 1'b0;
        in = 4'b1011;

        #5; // 50
        clk = 1'b1;

        #5; // 55

        $stop;
    end
endmodule
    

