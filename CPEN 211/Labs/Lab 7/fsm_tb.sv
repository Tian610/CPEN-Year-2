module fsm_tb();
    reg clk, reset, s;
    reg reset_pc;
    reg load_pc;
    reg [1:0] mem_cmd;
    reg addr_sel;
    reg load_ir;

    reg [2:0] opcode;
    reg [1:0] op;
    reg [13:0] control;
    reg err;

    fsm DUT (clk, s, reset, opcode, op, control, reset_pc, load_pc, addr_sel, mem_cmd, load_ir);

    reg [3:0] path;
    assign path = fsm_tb.DUT.path;
    reg [5:0] state;
    assign state = fsm_tb.DUT.state;



    initial begin
        err = 1'b0;
        reset = 1'b1; #5;
        clk = 1'b1; #5;
        reset = 1'b0;

        opcode = 3'b101;
        op = 3'b00;
        s = 1'b1;
        clk = 1'b0; #5;

        clk = 1'b1; #5;
        clk = 1'b0; #5;

        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        clk = 1'b0; #5;

    end

endmodule