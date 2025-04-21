module ALU_tb();
    reg [15:0] Ain, Bin;
    reg [1:0] ALUop;
    reg [15:0] out;
    reg [2:0] Z;
    reg err;

    ALU DUT(Ain,Bin,ALUop,out,Z);

    initial begin 

        // Test Addition - Tian

        err = 1'b0; 
        Ain = 16'b0000_0000_0000_0001;
        Bin = 16'b0000_0000_0000_0001;
        ALUop = 2'b00;

        #5;
        if (out !== 16'b0000_0000_0000_0010) err = 1'b1;
        if (Z[0] !== 1'b0) err = 1'b1;

        #5;

        // Test Subtraction - Tian
        ALUop = 2'b01;

        #5;
        if (out !== 16'b0000_0000_0000_0000) err = 1'b1;
        if (Z[0] !== 1'b1) err = 1'b1;

        #5;

        // Test AND - Iain
        ALUop = 2'b10;

        #5;
        if (out !== 16'b0000_0000_0000_0001) err = 1'b1;
        if (Z[0] !== 1'b0) err = 1'b1;

        #5;

        // Test NOT - Iain
        ALUop = 2'b11;

        #5;
        if (out !== 16'b1111_1111_1111_1110) err = 1'b1;
        if (Z[0] !== 1'b0) err = 1'b1;

        #5;

        // Second Test
        
        // Test Addition - Iain

        err = 1'b0;
        Ain = 16'b0000_0000_0101_1100;
        Bin = 16'b0000_0000_0010_0110;
        ALUop = 2'b00;

        #5;
        if (out !== 16'b0000_0000_1000_0010) err = 1'b1;
        if (Z[0] !== 1'b0) err = 1'b1;

        #5;

        // Test Subtraction - Tian
        ALUop = 2'b01;

        #5;
        if (out !== 16'b0000_0000_0011_0110) err = 1'b1;
        if (Z[0] !== 1'b0) err = 1'b1;

        #5;

        // Test AND - Tian
        ALUop = 2'b10;

        #5;
        if (out !== 16'b0000_0000_0000_0100) err = 1'b1;
        if (Z[0] !== 1'b0) err = 1'b1;

        #5;

        // Test NOT - Tian
        ALUop = 2'b11;

        #5;
        if (out !== 16'b1111_1111_1101_1001) err = 1'b1;
        if (Z[0] !== 1'b0) err = 1'b1; 
        #5;

        Ain = 16'b0111_1111_1101_1001;
        Bin = 16'b0111_1111_1101_1001;
        ALUop = 2'b00;

        #5;
        if (Z[2] !== 1'b1) err = 1'b1;
        #5;

        $stop;
    end
endmodule: ALU_tb
