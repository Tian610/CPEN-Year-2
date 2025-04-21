    module regfile_tb();
    reg clk;  // reg declarations by Iain
    reg [15:0] data_in;
    reg [15:0] data_out;
    reg [2:0] writenum;
    reg [2:0] readnum;
    reg write;

    reg err;

    reg[15:0] R0; // By Iain
    reg[15:0] R1;
    reg[15:0] R2;
    reg[15:0] R3;
    reg[15:0] R4;
    reg[15:0] R5;
    reg[15:0] R6;
    reg[15:0] R7;
    
    assign R0 = regfile_tb.DUT.R0;
    assign R1 = regfile_tb.DUT.R1;
    assign R2 = regfile_tb.DUT.R2;
    assign R3 = regfile_tb.DUT.R3;
    assign R4 = regfile_tb.DUT.R4;
    assign R5 = regfile_tb.DUT.R5;
    assign R6 = regfile_tb.DUT.R6;
    assign R7 = regfile_tb.DUT.R7;

    regfile DUT(data_in, writenum, write, readnum, clk, data_out); // by Tian

    initial begin 
        err = 1'b0; // initial cases by Tian
        clk = 1'b0; 
        data_in = 16'b0000_0000_0000_1111;
        write = 1'b1;
        writenum = 3'b000;

        #5; // 5 ms
        clk = 1'b1; #5;
        // check that the number 15 has been written to R0 - Iain
        if (R0 !== 16'b0000_0000_0000_1111) err = 1'b1;
        
        #5; // 10 ms
        clk = 1'b0; #5; // Iain
        write = 1'b0;
        readnum = 3'b000;
        #5;
        // check that data out reads the number 15 - Iain
        if (data_out !== 16'b0000_0000_0000_1111) err = 1'b1; #5;

        // remaining by Iain
        write = 1'b1;
        data_in = 16'b1111_1111_1111_1111;
        writenum = 3'b111; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        // check that the correct number is written to R7 
        if (R7 !== 16'b1111_1111_1111_1111) err = 1'b1;
        // check that R0 has not been overwritten
        if (R0 !== 16'b0000_0000_0000_1111) err = 1'b1;

        write = 1'b0;
        readnum = 3'b111; #5;
        if (data_out !== 16'b1111_1111_1111_1111) err = 1'b1; #5;
        readnum = 3'b000; #5;
        if (data_out !== 16'b0000_0000_0000_1111) err = 1'b1; #5;

        // Test overriding a previously written register - Tian
        write = 1'b1;
        writenum = 3'b000;
        data_in = 16'b0000_0000_0000_0000;

        #5;
        clk = 1'b1;
        #5;
        clk = 1'b0;
        write = 1'b0;
        readnum = 3'b000; #5;

        if (data_out !== 16'b0000_0000_0000_0000) err = 1'b1; #5;

        // Test write does not work when write = 0;

        write = 1'b0;
        writenum = 3'b000;
        data_in = 16'b0000_0000_0000_0001;

        #5;
        clk = 1'b1;
        #5;
        clk = 1'b0;

        readnum = 3'b000;

        if (data_out !== 16'b0000_0000_0000_0000) err = 1'b1; #5;

        $stop;
    end
endmodule: regfile_tb
