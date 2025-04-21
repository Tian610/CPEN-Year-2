module regfile(data_in, writenum, write, readnum, clk, data_out);
    input [15:0] data_in;
    input [2:0] writenum, readnum;
    input write, clk;
    output [15:0] data_out;

    reg [15:0] R0, R1, R2, R3, R4, R5, R6, R7; //written by Iain
    reg [7:0] en;
    reg [7:0] writeEnable;
	assign writeEnable = {8{write}} & en;
    reg [7:0] decodedRead; // written by Tian
    reg [15:0] data_out;

    // Decoders for controlling reading and writing
    Decoder38 writeDecoder(writenum, en); // written by Tian
    Decoder38 readDecoder(readnum, decodedRead);
    
    vDFFE #(16) LE0(clk, writeEnable[0], data_in, R0); // written by Iain
    vDFFE #(16) LE1(clk, writeEnable[1], data_in, R1);
    vDFFE #(16) LE2(clk, writeEnable[2], data_in, R2);
    vDFFE #(16) LE3(clk, writeEnable[3], data_in, R3);
    vDFFE #(16) LE4(clk, writeEnable[4], data_in, R4);
    vDFFE #(16) LE5(clk, writeEnable[5], data_in, R5);
    vDFFE #(16) LE6(clk, writeEnable[6], data_in, R6);
    vDFFE #(16) LE7(clk, writeEnable[7], data_in, R7);

    // Chooses which register to read from based on one hot code
    always_comb begin //written by Tian
        case(decodedRead)
            8'b00_00_00_01: data_out = R0;
            8'b00_00_00_10: data_out = R1;
            8'b00_00_01_00: data_out = R2;
            8'b00_00_10_00: data_out = R3;
            8'b00_01_00_00: data_out = R4;
            8'b00_10_00_00: data_out = R5;
            8'b01_00_00_00: data_out = R6;
            8'b10_00_00_00: data_out = R7;
            default: data_out = {16{1'bx}}; // written by Iain
        endcase
    end

endmodule

// Updates out to in on posedge of clk if en is true
module vDFFE(clk, en, in, out); // Written by Iain but taken from lecture slides as permissed by Dr. Aamodt 
	parameter n = 1;
	input clk, en;
	input [n-1:0] in;
	output [n-1:0] out;
	reg [n-1:0] out;
	wire [n-1:0] next_out;
	
	assign next_out = en ? in : out;
	always @(posedge clk)
	    out = next_out;  
endmodule

// Decodes a 3 bit binary signal to an 8 bit one hot code
module Decoder38(in, out); // Written by Tian
    input [2:0] in;
    output [7:0] out;
    reg [7:0] out;

    always_comb begin
        case(in)
            3'b000: out = 8'b00_00_00_01;
            3'b001: out = 8'b00_00_00_10;
            3'b010: out = 8'b00_00_01_00;
            3'b011: out = 8'b00_00_10_00;
            3'b100: out = 8'b00_01_00_00;
            3'b101: out = 8'b00_10_00_00;
            3'b110: out = 8'b01_00_00_00;
            3'b111: out = 8'b10_00_00_00;
            default: out = 8'bxxxxxxxx;
        endcase
    end
endmodule