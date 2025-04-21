module datapath_tb();
    
    reg clk, vsel, loada, loadb, asel, bsel, loadc, loads, write, Z_out;
    reg [1:0] shift, ALUop;
    reg [2:0] readnum, writenum;
    reg [15:0] datapath_in, datapath_out;

    datapath DUT(clk, readnum, vsel, loada, loadb, shift, asel, bsel,
        ALUop, loadc, loads, writenum, write, datapath_in, Z_out, datapath_out);

    reg err; 

    reg[15:0] r0; // By Iain
    reg[15:0] r1;
    reg[15:0] r2;
    reg[15:0] r3;
    reg[15:0] r4;
    reg[15:0] r5;
    reg[15:0] r6;
    reg[15:0] r7;

    assign r0 = datapath_tb.DUT.REGFILE.R0;
    assign r1 = datapath_tb.DUT.REGFILE.R1;
    assign r2 = datapath_tb.DUT.REGFILE.R2;
    assign r3 = datapath_tb.DUT.REGFILE.R3;
    assign r4 = datapath_tb.DUT.REGFILE.R4;
    assign r5 = datapath_tb.DUT.REGFILE.R5;
    assign r6 = datapath_tb.DUT.REGFILE.R6;
    assign r7 = datapath_tb.DUT.REGFILE.R7;

    initial begin  // written by Iain
        clk = 0;
        vsel = 0;
        loada = 0;
        loadb = 0;
        asel = 0;
        bsel = 0;
        loadc = 0;
        loads = 0;
        write = 0;
        shift [1:0] = 2'b00;
        ALUop [1:0] = 2'b00;
        readnum [2:0] = 3'b00;
        writenum [2:0] = 3'b00;
        datapath_in [15:0] = {16{1'b0}};
        err = 1'b0;
        #5;

        vsel = 1'b1;
        datapath_in = 16'b0000_0000_0000_1111;
        write = 1'b1;
        writenum = 3'b001;
        #5;
        clk = 1'b1; #5;
        // writes the number 15 into register 1 and checks that it matches
        if (datapath_tb.DUT.REGFILE.R1 !== datapath_in) err = 1'b1; #5;
        clk = 1'b0; #5;

        // write the number 30 into register 7        
        datapath_in = 16'b0000_0000_0001_1110;
        writenum = 3'b111; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        if (r7 !== datapath_in) err = 1'b1; #5; //checks that 30 is in r7

        // read r1 and load it into register A
        write = 1'b0;
        readnum = 3'b001;
        loada = 1'b1; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;

        // read r7 and load into the B register
        loada = 1'b0;
        readnum = 3'b111;
        loadb = 1'b1; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;

        // perform right shift operation on output of B reg
        shift = 2'b11; #5;

        // perform addition operation and enable load into C reg
        loadb = 1'b0;
        ALUop = 2'b00;
        loadc = 1'b1; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        // check that the output is 15 + 15 
        if (datapath_out !== 16'b0000_0000_0001_1110) err = 1'b1; #5; 
        loadc = 1'b0;
        
        // TESTING ALU invert, and bsel 0
        write = 1'b1;
        writenum = 3'b000;
        datapath_in = 16'b1111_1111_1111_1111;
        vsel = 1'b1; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        // confirm correct number written to R0
        if (r0 !== 16'b1111_1111_1111_1111) err = 1'b1;
        
        write = 0'b0;
        readnum = 3'b000;
        loadb = 1'b1; #5;
        clk = 1'b1; #5;
        clk = 1'b0;
        loadb = 1'b0; 
        ALUop = 2'b11;
        loadc = 1'b1;
        loads = 1'b1; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        // check that the negated value is in datapath out
        if (datapath_out !== 16'b0000_0000_0000_0000) err = 1'b1;
        // since the value is zero, check that Z_out is 1
        if (Z_out !== 1'b1) err = 1'b1; #5;


        // test for reading output back into registers
        loadb = 1'b0;
        loadc = 1'b0;
        loads = 1'b0;

        vsel = 1'b0;
        writenum = 3'b100;
        write = 1'b1; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;

        // check that the correct number gets into R4
        if (r4 !== 16'b0000_0000_0000_0000) err = 1'b1; #5;
        
        $stop;
    end
endmodule : datapath_tb