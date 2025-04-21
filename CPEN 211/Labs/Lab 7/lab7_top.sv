`define MREAD 2'b01
`define MWRITE 2'b10

`define mem_addrLED 9'b100000000
`define mem_addrSW 9'b101000000

module lab7_top(KEY,SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
    input [3:0] KEY;
    input [9:0] SW;
    output [9:0] LEDR;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    // RAM
    reg [7:0] read_address;
    reg [7:0] write_address;
    reg write;
    reg [15:0] dout;
    reg enable;
    
    // CPU
    reg clk, reset, N, V, Z;
    reg [15:0] out;
    reg [8:0] mem_addr;
    reg [1:0] mem_cmd;
    reg [15:0] read_data;

    cpu CPU(clk,reset,read_data,out,N,V,Z,mem_cmd,mem_addr);
    RAM MEM(clk,read_address,write_address,write,out,dout);

    assign clk = ~KEY[0]; //may need to change later, for testing
    assign reset = ~KEY[1]; //may need to change later, for testing
    assign HEX0 = 7'b1111111; 
    assign HEX1 = 7'b1111111; 
    assign HEX2 = 7'b1111111; 
    assign HEX3 = 7'b1111111; 
    assign HEX4 = 7'b1111111; 
    assign HEX5 = 7'b1111111; 
    assign HEX6 = 7'b1111111; 
    reg enable1, enable2;

    assign read_address = mem_addr[7:0];
    assign write_address = mem_addr[7:0];

    assign enable = (`MREAD == mem_cmd) & (!mem_addr[8]);
    assign write = (`MWRITE == mem_cmd) & (!mem_addr[8]);

    assign read_data = enable ? dout : (enable1 ? {{8{1'b0}}, SW[7:0]} : {16{1'bz}});  
    vDFFE #(8) DesignThisCircuitRight(clk, enable2, out[7:0], LEDR[7:0]);

    assign enable1 = (mem_cmd == `MREAD) & (mem_addr == `mem_addrSW);
    assign enable2 = (mem_cmd == `MREAD) & (mem_addr == `mem_addrLED);

endmodule


module RAM(clk,read_address,write_address,write,din,dout);
    parameter data_width = 16;
    parameter addr_width = 8;
    parameter filename = "data.txt";

    input clk;
    input [addr_width-1:0] read_address, write_address;
    input write;
    input [data_width-1:0] din;
    
    output [data_width-1:0] dout;

    reg [data_width-1:0] dout;
    reg [data_width-1:0] mem [2**addr_width-1:0];

    initial $readmemb(filename, mem);
    always @ (posedge clk) begin
        if (write)
        mem[write_address] <= din;
        dout <= mem[read_address]; // dout doesn't get din in this clock cycle
        // (this is due to Verilog non-blocking assignment "<=")
    end
endmodule