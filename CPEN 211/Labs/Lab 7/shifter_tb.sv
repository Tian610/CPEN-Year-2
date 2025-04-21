module shifter_tb();
    reg [15:0] in;
    reg [1:0] shift;
    reg [15:0] sout;
    reg err;

    shifter DUT(in,shift,sout);

    initial begin // Tian

        // TEST NO SHIFT

        err = 1'b0;
        in = 16'b1111000011001111;
        shift = 2'b00;

        #5
        if (sout !== 16'b1111000011001111) err = 1'b1;
        #5

        // TEST LEFT SHIFT

        shift = 2'b01;

        #5
        if (sout !== 16'b1110000110011110) err = 1'b1;
        #5

        // TEST RIGHT SHIFT

        shift = 2'b10;

        #5
        if (sout !== 16'b0111100001100111) err = 1'b1;
        #5

        // TEST RIGHT SHIFT WITH PRESERVED MSB

        shift = 2'b11;

        #5
        if (sout !== 16'b1111100001100111) err = 1'b1;
        #5

        $stop;
    end
endmodule: shifter_tb
