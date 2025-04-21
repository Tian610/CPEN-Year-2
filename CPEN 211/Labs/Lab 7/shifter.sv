module shifter(in,shift,sout);
    input [15:0] in;
    input [1:0] shift;
    output [15:0] sout;
    
    reg [15:0] sout;

    always_comb begin // Iain
        case (shift) // Tian
            2'b00: sout = in; // Iain - Performs no bit shift
            2'b01: sout = in << 1'b1; // Tian - Performs left bit shift
            2'b10: sout = in >> 1'b1; // Performs right bit shift
            2'b11: begin 
                sout = in >> 1'b1;
                sout[15] = in[15]; // Iain - Performs right bit shift with MSB preserved
            end
            default: sout = {16{1'bx}}; // Tian
        endcase
    end
endmodule