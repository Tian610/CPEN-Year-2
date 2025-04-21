module datapath (clk, 
                readnum, 
                vsel, 
                loada, loadb, 
                shift, 
                asel, bsel, 
                ALUop, 
                loadc, loads, 
                writenum, write, 
                sximm8, sximm5,
                Z_out, 
                datapath_out, mdata);

    // by Tian
    input clk, loada, loadb, asel, bsel, loadc, loads, write;
    output [2:0] Z_out;
    output [15:0] datapath_out;
    input [2:0] readnum, writenum;
    input [1:0] shift, ALUop;
    input [3:0] vsel;
    input [15:0] sximm8, sximm5, mdata;
    
    reg [15:0] datapath_out;
    reg [2:0] readnum, writenum;
    reg [1:0] shift, ALUop;

    reg [15:0] data_in;
    reg [15:0] data_out;

    // new lab 6 stuff here - Iain
    reg [15:0] mdata;
    reg [15:0] sximm8;
    reg [15:0] sximm5;
    reg [15:0] PC;
    assign PC [15:0] = 16'b0;

    // Block 9 - Chooses mdata, sximm8, PC, or datapath_out based on vsel
    Mux4 #(16) MUXSEL(mdata, sximm8, PC, datapath_out, vsel, data_in);
    
    // Block 1 - Reads and Writes to the Register File
    regfile REGFILE(data_in, writenum, write, readnum, clk, data_out);
    
    // BLocks 3 and 4 - Loads values to A and B
    reg [15:0] lrA, lrB;
    vDFFE #(16) A(clk, loada, data_out, lrA);
    vDFFE #(16) B(clk, loadb, data_out, lrB); // end Iain

    // Block 8 - Bit Shift operations on B
    reg [15:0] sout; // by Tian
    reg [15:0] in;
    assign in [15:0] = lrB;
    shifter U1(in, shift, sout); 

    // Blocks 6 and 7 - Selects signals based off asel and bsel
    wire [15:0] Ain;
    wire [15:0] Bin;
    assign Ain = asel ? {16{1'b0}} : lrA;
    assign Bin = bsel ? sximm5 : sout; // end Tian

    // Block 2 - ALU for Ain and Bin
    reg [15:0] out; // by Iain
    reg [2:0] Z;
    ALU U2(Ain, Bin, ALUop, out, Z);

    // Block 5 - Updates datapath_out and Z_out based on clk
    // and loads and loadc
    vDFFE #(16) C(clk, loadc, out, datapath_out);
    vDFFE #(3) status(clk, loads, Z, Z_out); // end Iain
endmodule

module Mux4(mdata, sximm8, PC, datapath_out, s, data_in) ;
  parameter k = 1;
  input [k-1:0] mdata, sximm8, PC, datapath_out;  // inputs
  input [3:0] s; // one-hot select
  output[k-1:0] data_in;
  wire [k-1:0] data_in = ({k{s[0]}} & mdata) | 
                   ({k{s[1]}} & sximm8) |
                   ({k{s[2]}} & PC) |
                   ({k{s[3]}} & datapath_out) ;
endmodule
