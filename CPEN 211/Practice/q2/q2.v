`define SA 3'b00
`define SB 3'b01
`define SC 3'b10
`define SD 3'b11

module MealyDec(state,in,out);
    input [1:0] state;
    input in;
    output [2:0] out;

    reg [2:0] out;

    always @(*) begin
        case (in)
            1'b0:
                if (state == `SA) out = 3'b111;
                else if (state == `SB) out = 3'b001;
                else if (state == `SC) out = 3'b000;
                else if (state == `SD) out = 3'b110;
                else out = 3'b000;

            1'b1:
                if (state == `SA) out = 3'b101;
                else if (state == `SB) out = 3'b011;
                else if (state == `SC) out = 3'b100;
                else if (state == `SD) out = 3'b110;
                else out = 3'b000;
                
            default:
                out = 3'b000;
        endcase
    end
endmodule
