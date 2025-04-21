module cpu_tb();

    reg clk, reset, s, load, N, V, Z, w, err;
    reg [15:0] in;
    reg [15:0] out;

    cpu gpu(clk, reset, s, load, in, out, N, V, Z, w);
    
    reg[15:0] r0; // By Iain
    reg[15:0] r1;
    reg[15:0] r2;
    reg[15:0] r3;
    reg[15:0] r4;
    reg[15:0] r5;
    reg[15:0] r6;
    reg[15:0] r7;

    assign r0 = cpu_tb.gpu.DP.REGFILE.R0;
    assign r1 = cpu_tb.gpu.DP.REGFILE.R1;
    assign r2 = cpu_tb.gpu.DP.REGFILE.R2;
    assign r3 = cpu_tb.gpu.DP.REGFILE.R3;
    assign r4 = cpu_tb.gpu.DP.REGFILE.R4;
    assign r5 = cpu_tb.gpu.DP.REGFILE.R5;
    assign r6 = cpu_tb.gpu.DP.REGFILE.R6;
    assign r7 = cpu_tb.gpu.DP.REGFILE.R7;

    reg [3:0] path;
    assign path = cpu_tb.gpu.StateMachine.path;
    reg [5:0] state;
    assign state = cpu_tb.gpu.StateMachine.state;

    reg [2:0] opcode;
    assign opcode = cpu_tb.gpu.opcode;
    reg [1:0] op;
    assign op = cpu_tb.gpu.op;

    reg[15:0] regOut;
    assign regOut = cpu_tb.gpu.regOut;

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        s = 1'b0;
        load = 1'b0;
        err = 1'b0;
        #5;

        clk = 1'b1; #5;
        clk = 1'b0; #5;
        reset = 1'b0;

        //in = 16'b101_00_000_010_00_001; // Add test
        //in = 16'b101_01_000_010_00_001; // Cmp test
        //in = 16'b101_10_000_010_00_001; // And test
        //in = 16'b101_11_000_010_00_001; // Mvn test
        //in = 16'b110_10_010_101_01_010; // Mov test
        // in = 16'b110_00_000_010_00_001; // Mov from Reg test
        in = 16'b110_10_000_00110011; // MOV R0, #51

        load = 1'b1; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        load = 1'b0;

        s = 1'b1;

        clk = 1'b1; #5;
        clk = 1'b0; #5;
        s = 1'b0;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        // check that 51 was written to R0
        if (r0 !== 16'b000_0000_0011_0011) err = 1'b1; #5;

        in = 16'b110_10_111_00110001; // MOV R7, #49
        load = 1'b1; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        load = 1'b0;
        s = 1'b1;
        clk = 1'b1; #5; clk = 1'b0; #5;
        s = 1'b0;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;

        // check that 49 was written to R7
        if (r7 !== 16'b000_0000_0011_0001) err = 1'b1; #5;

        in = 16'b101_00_000_001_00_111; // ADD R1, R0, R7
        load = 1'b1; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        load = 1'b0;
        s = 1'b1;
        clk = 1'b1; #5; clk = 1'b0; #5;
        s = 1'b0;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;

        // check that 100 was written to R1
        if (r1 !== 16'b000_0000_0110_0100) err = 1'b1; #5;

        // MOV R2, R1, LSL #1
        in = 16'b110_00_000_010_01_001;
        load = 1'b1; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        load = 1'b0;
        s = 1'b1;
        clk = 1'b1; #5; clk = 1'b0; #5;
        s = 1'b0;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;

        // check that 200 was written to R2
        if (r2 !== 16'b000_0000_1100_1000) err = 1'b1; #5;

        // AND R3, R1, R2
        in = 16'b101_10_001_011_00_010;
        load = 1'b1; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        load = 1'b0;
        s = 1'b1;
        clk = 1'b1; #5; clk = 1'b0; #5;
        s = 1'b0;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;

        // check that 64 was written to R3
        if (r3 !== 16'b000_0000_0100_0000) err = 1'b1; #5;

        // MVN R4, R3, LSR #1
        in = 16'b101_11_000_100_11_011;
        load = 1'b1; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        load = 1'b0;
        s = 1'b1;
        clk = 1'b1; #5; clk = 1'b0; #5;
        s = 1'b0;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;

        // check that 32735 was written to R4
        if (r4 !== 16'b1111_1111_1101_1111) err = 1'b1; #5;

        // CMP R1, R0
        in = 16'b101_01_001_000_00_000;
        load = 1'b1; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        load = 1'b0;
        s = 1'b1;
        clk = 1'b1; #5; clk = 1'b0; #5;
        s = 1'b0;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;
        clk = 1'b1; #5; clk = 1'b0; #5;

        // check that N is 0, V is 0, Z is 0
        if (N !== 1'b0 || V !== 1'b0 || Z !== 1'b0) err = 1'b1; #5;
    end
endmodule