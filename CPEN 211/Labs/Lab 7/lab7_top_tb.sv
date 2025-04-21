module lab7_top_tb();

    reg [3:0] KEY;
    reg [9:0] SW;
    reg [9:0] LEDR;
    reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    reg [15:0] R0, R1, R2, R3, R4, R5, R6, R7, A, B;
    assign R0 = lab7_top_tb.DUT.CPU.DP.REGFILE.R0;    
    assign R1 = lab7_top_tb.DUT.CPU.DP.REGFILE.R1;    
    assign R2 = lab7_top_tb.DUT.CPU.DP.REGFILE.R2;    
    // assign R3 = lab7_top_tb.DUT.CPU.DP.REGFILE.R3;    
    // assign R4 = lab7_top_tb.DUT.CPU.DP.REGFILE.R4;    
    // assign R5 = lab7_top_tb.DUT.CPU.DP.REGFILE.R5;    
    // assign R6 = lab7_top_tb.DUT.CPU.DP.REGFILE.R6;    
    // assign R7 = lab7_top_tb.DUT.CPU.DP.REGFILE.R7;    
    assign A  = lab7_top_tb.DUT.CPU.DP.Ain;
    assign B  = lab7_top_tb.DUT.CPU.DP.Bin;
    reg addr_sel;
    reg [8:0] Data_Address;
    reg [8:0] mem_addr;
    assign Data_Address = lab7_top_tb.DUT.CPU.da_out;
    assign addr_sel = lab7_top_tb.DUT.CPU.StateMachine.addr_sel;
    assign mem_addr = lab7_top_tb.DUT.CPU.mem_addr;
    reg [15:0] datapath_out;
    assign datapath_out = lab7_top_tb.DUT.CPU.DP.datapath_out;
    reg [1:0] mem_cmd;
    assign mem_cmd = lab7_top_tb.DUT.mem_cmd;
    reg load_addr;
    assign load_addr = lab7_top_tb.DUT.CPU.StateMachine.load_addr;
    reg [15:0] read_data;
    assign read_data = lab7_top_tb.DUT.read_data;
    reg [8:0] PC;
    assign PC = lab7_top_tb.DUT.CPU.PC;

    reg[15:0] dout;
    assign dout = lab7_top_tb.DUT.dout;
    reg enable, enable1, enable2;
    assign enable = lab7_top_tb.DUT.enable;
    assign enable1 = lab7_top_tb.DUT.enable1;
    assign enable2 = lab7_top_tb.DUT.enable2;

    reg clk, rst;
    assign KEY[0] = ~clk;
    assign KEY[1] = ~rst;

    reg [5:0] state;
    reg [3:0] path;
    assign state = lab7_top_tb.DUT.CPU.StateMachine.state;
    assign path = lab7_top_tb.DUT.CPU.StateMachine.path;

    lab7_top DUT(KEY,SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);

    initial forever begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end

    initial begin
        SW[7:0] = 8'b00_00_00_11;
        rst = 1'b1; #10;
        rst = 1'b0;
        #1500;
        $stop;
    end

endmodule