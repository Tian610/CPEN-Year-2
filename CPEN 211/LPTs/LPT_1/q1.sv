`define SA 3'b000
`define SB 3'b001
`define SC 3'b010
`define SD 3'b011
`define SE 3'b100

module top_module(clk,reset,in,out);
    input clk, reset;
    input [1:0] in;
    output [1:0] out;

    reg [1:0] out;
    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) state <= `SD;
        else begin
            case(state)
                `SA:
                    if (in == 2'b10) state <= `SB;
                    else state <= `SA;
                `SB:
                    if (in == 2'b11) state <= `SA;
                    else if (in == 2'b00) state <= `SC;
                    else state <= `SB;
                `SC:
                    if (in == 2'b10) state <= `SD;
                    else if (in == 2'b11) state <= `SB;
                    else state <= `SC;
                `SD:
                    if (in == 2'b01) state <= `SE;
                    else state <= `SD;
                `SE:
                    if (in == 2'b10) state <= `SD;
                    else if (in == 2'b01) state <= `SC;
                    else state <= `SE;
                default: 
                    state <= 3'bxxx;
            endcase
        end
    end

    always @(state) begin
        case(state)
            `SA:
                out = 2'b01;
            `SB:
                out = 2'b00;
            `SC:
                out = 2'b11;
            `SD:
                out = 2'b10;
            `SE:
                out = 2'b11;
            default:
                out = 3'bxx;
        endcase
    end
endmodule