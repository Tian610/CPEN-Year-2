module q1(ain, bin, cin, f, valid);
    input [8:0] ain, bin, cin;
    output [2:0] f;
    output valid;

    isValid val(ain, bin, cin, valid);

    assign f[0] = ain[0] | ain[3] | ain[6];
    assign f[1] = bin[0] | bin[3] | bin[6];
    assign f[2] = cin[0] | cin[3] | cin[6];

endmodule

module isValid(ain, bin, cin, valid);
    input [8:0] ain, bin, cin;
    output valid;
    wire [8:0] occupied, validBus;
    wire valid0, valid1, valid3, valid4, valid6, valid8, validX;

    assign occupied = ain | bin | cin;

    assign valid0 = (occupied[0] & occupied[1]) | ~occupied[0];
    assign valid1 = (occupied[1] & occupied[2]) | ~occupied[1];
    assign valid3 = (occupied[3] & occupied[4]) | ~occupied[3];
    assign valid4 = (occupied[4] & occupied[5]) | ~occupied[4];
    assign valid6 = (occupied[6] & occupied[7]) | ~occupied[6];
    assign valid8 = (occupied[8] & occupied[8]) | ~occupied[8];
    assign validBus = (ain & bin) | (bin & cin) | (ain & cin); // Check for overlap at any bit position
    assign validX = ~|validBus; // If any overlap exists, valid will be 0
 
    assign valid = valid0 & valid1 & valid3 & valid4 & valid6 & valid8 & validX;
endmodule