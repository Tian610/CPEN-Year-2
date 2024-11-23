`define Wait 4'b0000
`define Decode 4'b0001
`define MOV 4'b0010
`define LSR 4'b0011
`define LSL 4'b0100
`define CHK 4'b0101
`define ADC 4'b0110

`define STR 4'b0010
`define SHR 4'b0011
`define SHL 4'b0100
`define WRITE 4'b0101

module mult(clk,reset,s,op,in,out,done);
    input clk, reset, s;
    input [15:0] in;
    input [4:0] op;
    output [15:0] out;
    output done;
    reg done;
    reg [1:0] Rd, Ri, Rj, aop;
    reg w, loadb, sel, lsb;
    datapath DP(clk,Rd,w,in,sel,Ri,Rj,lsb,aop,loadb,out);

    reg [3:0] state;
    reg [3:0] path;
    
    always_ff @(clk) begin
        if (reset) state = `Wait;
        else if (state == `Wait) state = (s ? `Decode : `Wait); 
        else if (state == `Decode) begin
            case ({op[4], op[1], op[0]})
                    {3'b000} : {path, state} = {`MOV, `STR};
                    {3'b001} : {path, state} = {`LSR, `SHR};
                    default : path = 4'bxxxx;
            endcase
        end

        else if (path == `MOV) begin
            case (state)
                `STR: state = `Wait;
            endcase
        end

        else if (path == `LSR) begin
            case (state)
                `SHR: state = `Wait;
            endcase
        end
        
    end

    always @(*) begin
        if (state == `Wait) done = 1'b1;
        else done = 1'b0;

        case (state)
            `STR: begin
                Rd = {op[3], op[2]};
                w = 1'b1;
                sel = 1'b1;
                loadb = 1'b0;
                Ri = 2'b00;
                Rj = 2'b00;
                aop = 2'b00;
            end
            `SHR: begin
                Rd = 2'b00;
                Ri = {op[3], op[2]};
                Rj = {op[3], op[2]};
                w = 1'b0;
                sel = 1'b0;
                loadb = 1'b0;
                aop = 2'b00;
            end

        endcase
    end

endmodule