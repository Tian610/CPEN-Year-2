module datapath(clk,Rd,w,in,sel,Ri,Rj,lsb,aop,loadb,out);
    input clk, w, sel, loadb;
    input [1:0] Rd, Ri, Rj;
    input [15:0] in;
    input [1:0] aop;
    output lsb;
    output [15:0] out;

    reg [15:0] in1;
    reg [2:0] load;
    reg [15:0] R0, R1, R2, iout, jout, aout;
    reg aL;
    reg lsb;

    always_ff @(clk) begin
        R0 = (w & load[0]) ? in1 : R0;
        R1 = (w & load[1]) ? in1 : R1;
        R2 = (w & load[2]) ? in1 : R2;
        lsb = loadb ? aL : lsb;
    end

    assign in1 = sel ? in : aout;
    
    MUX mux1(Ri, R0, R1, R2, iout);
    MUX mux2(Ri, R0, R1, R2, jout);

    always_comb begin
        case(aop)
            2'b00: aout = iout >> 1'b1;
            2'b01: aout = iout << 1'b1;
            2'b10: aout = iout + jout;
            2'b11: aout = iout;
        endcase
        case(Rd)
            2'b00: load = 3'b001;
            2'b01: load = 3'b010;
            2'b10: load = 3'b100;
            default: load = 3'bxxx;
        endcase
    end

    assign aL = !aout[0];
    assign out = R2;
endmodule

// Multiplexer for Ri and Rj
module MUX(sel, R0, R1, R2, out);
    input [15:0] R0, R1, R2;
    input [1:0] sel;
    output out;
    reg out;

    always_comb begin
        case(sel)
            2'b00: out = R0;
            2'b01: out = R1;
            2'b10: out = R2;
            default: out = {16{1'bx}};
        endcase
    end
endmodule
