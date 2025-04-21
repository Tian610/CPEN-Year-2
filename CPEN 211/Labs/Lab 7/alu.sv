module ALU(Ain,Bin,ALUop,out,Z);
    input [15:0] Ain, Bin;
    input [1:0] ALUop;
    output [15:0] out;
    output [2:0] Z;
    // left bit = overflow
    // middle bit = negative
    // right bit = is zero 

    reg [15:0] out; //by Iain
    reg [2:0] Z; // by Tian
    
    // ALU performs 4 different operations depending
    // on ALUop
    always_comb begin
        case(ALUop) 
            2'b00: out = Ain + Bin; // by Iain - Adds two numbers
            2'b01: out = Ain - Bin; // by Iain - Subtracts two numbers
            2'b10: out = Ain & Bin; // by Tian - ANDS two numbers
            2'b11: out = ~Bin; // by Iain - NOTS the B signal
            default: out = {16{1'bx}};
        endcase
        if (out == {16{1'b0}}) Z[0] = 1'b1; // by Tian - Set Z to true if all values in the result are false
        else Z[0] = 1'b0; // by Iain
        if (out[15] == 1'b1) Z[1] = 1'b1;
        else Z[1] = 1'b0;
        if ((Ain[15] & Bin[15]) & (ALUop == 2'b00) & (~out[15])) Z[2] = 1'b1;
        else if (~(Ain[15] & Bin[15]) & (ALUop == 2'b01) & (out[15])) Z[2] = 1'b1;
        else Z[2] = 1'b0;
    end
endmodule