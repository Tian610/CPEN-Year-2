module cpu(clk,reset,in,out,N,V,Z,mem_cmd,mem_addr);
    input clk, reset;
    input [15:0] in;
    output [15:0] out;
    output N, V, Z;
    output [1:0] mem_cmd;
    output [8:0] mem_addr;
    // N = Negative
    // V = Overflow
    // Z = Zero

    // reg declarations and assignments by Iain and Tian
    reg [15:0] regOut;
    reg [2:0] nsel;
    reg [15:0] sximm5, sximm8;
    reg [1:0] shift;
    reg [2:0] readnum, writenum;
    reg [2:0] opcode;
    reg [1:0] op, ALUop;
    reg [13:0] control;
    reg [3:0] vsel;
    reg [2:0] Z_out;
    reg write, loada, loadb, asel, bsel, loads, loadc, load_ir;
    reg [1:0] mem_cmd;
    reg [8:0] mem_addr;
    reg [8:0] PC;
    reg reset_pc, load_pc, addr_sel;
    reg [8:0] next_pc;

    assign nsel  = control[13:11];
    assign vsel  = control[10:7];   
    assign write = control[6];
    assign loada = control[5];
    assign loadb = control[4];
    assign asel  = control[3];
    assign bsel  = control[2];    
    assign loadc = control[1];
    assign loads = control[0];
    assign V = Z_out[2];
    assign N = Z_out[1];
    assign Z = Z_out[0];

    assign next_pc = reset_pc ? {9{1'b0}} : (PC + 1'b1);

    reg load_addr;
    reg [8:0] da_out;

    vDFFE #(9)  PCREG(clk, load_pc, next_pc, PC);
    vDFFE #(16) INREG(clk, load_ir, in, regOut); // by Tian
    vDFFE #(9)  DA(clk, load_addr, out[8:0], da_out);
    RISCdecoder decoder(regOut, ALUop, sximm5, sximm8, shift, readnum, writenum, opcode, op, nsel); // By Tian
    fsm StateMachine(clk, reset, opcode, op, control,
                     reset_pc, load_pc, addr_sel, mem_cmd, load_ir, load_addr); // By Iain
    datapath DP(clk, readnum, vsel, loada, loadb, shift, asel, bsel, 
                  ALUop, loadc, loads, writenum, write, sximm8, sximm5, Z_out, out, in); // By Iain

    assign mem_addr = addr_sel ? PC : da_out;

endmodule

module RISCdecoder(regOut, ALUop, 
                    sximm5, sximm8, 
                    shift, readnum, writenum, 
                    opcode, op, nsel);
    // declarations and assignments by Tian and Iain
    input [15:0] regOut;
    input [2:0] nsel;

    output [15:0] sximm5, sximm8;
    output [1:0] shift;
    output reg [2:0] readnum, writenum;
    output [2:0] opcode;
    output [1:0] op, ALUop;

    assign opcode = regOut[15:13];
    assign op = regOut[12:11];
    assign ALUop = regOut[12:11];
    assign sximm5 = {{11{regOut[4]}}, regOut[4:0]}; // By Tian
    assign sximm8 = {{8{regOut[7]}}, regOut[7:0]}; // By Iain
    assign shift = regOut[4:3];
    assign writenum = readnum;

    // By Tian
    always @(*) begin
        case (nsel)
            3'b001: readnum = regOut[2:0]; // Rm
            3'b010: readnum = regOut[7:5]; // Rd
            3'b100: readnum = regOut[10:8]; // Rn
            default: readnum = 3'bxxx;
        endcase
    end
    
endmodule