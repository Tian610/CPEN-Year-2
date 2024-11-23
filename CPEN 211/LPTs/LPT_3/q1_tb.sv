module q1_tb();
    reg clk, w, sel, loadb;
    reg [1:0] Rd, Ri, Rj;
    reg [15:0] in;
    reg [1:0] aop;
    reg  lsb;
    reg  [15:0] out;

    datapath DUT(clk,Rd,w,in,sel,Ri,Rj,lsb,aop,loadb,out);

    reg [15:0] R0, R1, R2, iout, jout, aout;

    assign R0 = q1_tb.DUT.R0;
    assign R1 = q1_tb.DUT.R1;
    assign R2 = q1_tb.DUT.R2;
    assign iout = q1_tb.DUT.iout;
    assign jout = q1_tb.DUT.jout;
    assign aout = q1_tb.DUT.aout;

    initial begin
        in = 16'b0000_0000_0000_0001;
        sel = 1'b1;
        Rd = 2'b01;
        Ri = 2'b00;
        Rj = 2'b01;
        w = 1'b1;
        loadb = 1'b1;
        aop = 2'b10;

        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;

    end

endmodule

module tb2;
  reg clk, reset, s;
  reg [15:0] in;
  reg [4:0] op;
  wire [15:0] out;
  wire done;
  
  mult DUT(clk,reset,s,op,in,out,done);

  wire [15:0] R0 = DUT.DP.R0;
  wire [15:0] R1 = DUT.DP.R1;
  wire [15:0] R2 = DUT.DP.R2;
  wire [15:0] aout = DUT.DP.aout;
  wire [15:0] iout = DUT.DP.iout;
  wire [15:0] jout = DUT.DP.jout;
  wire aL  = DUT.DP.aL;
  wire [2:0] load = DUT.DP.load;

  wire [1:0] Rd = DUT.mult.Rd;
  wire [1:0] Ri = DUT.mult.Ri;
  wire [1:0] Rj = DUT.mult.Rj;
  wire [3:0] state = DUT.mult.state;
  wire [3:0] path = DUT.mult.path;
  wire [1:0] aop = DUT.DP.aop;



  // make sure you get no warnings for the the following lines!

  initial begin
        op = 5'bxxxxx;
        reset = 1'b1;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        reset = 1'b0;
        s = 1'b1;
        in = 16'b0000_0000_0000_0011;
        op = 5'b0_10_01;

        clk = 1'b1; #5;
        clk = 1'b0; #5;

        s = 1'b0;
        clk = 1'b1; #5;
        clk = 1'b0; #5;

        clk = 1'b1; #5;
        clk = 1'b0; #5;

        clk = 1'b1; #5;
        clk = 1'b0; #5;

        clk = 1'b1; #5;
        clk = 1'b0; #5;

        
  end
endmodule 
