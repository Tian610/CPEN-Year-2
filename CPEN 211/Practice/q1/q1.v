`define SA 3'b000
`define SB 3'b001
`define SC 3'b010
`define SD 3'b011
`define SE 3'b100

module q1(clk,reset,in,out);
    input clk, reset;
    input [1:0] in;
    output [2:0] out;

    reg [2:0] out;
    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= `SA;
        end
        else begin
            case(state)
                `SA:
                    if (in == 2'b01) state <= `SB;
                    else if (in == 2'b10) state <= `SD;
                    else state <= `SA;
                `SB:
                    state <= `SA;
                `SC:
                    if (in == 2'b01) state <= `SE;
                    else if (in == 2'b11) state <= `SB;
                    else state <= `SC;
                `SD:
                    state <= `SC;
                `SE:
                    if (in == 2'b11) state <= `SD;
                    else state <= `SE;
                default: 
                    state <= `SA;
            endcase
        end
    end

    always @(*) begin
        case(state)
            `SA:
                out = 3'b000;
            `SB:
                out = 3'b001;
            `SC:
                out = 3'b010;
            `SD:
                out = 3'b000;
            `SE:
                out = 3'b100;
            default:
                out = 3'b000;
        endcase
    end

endmodule