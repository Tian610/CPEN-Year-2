`define Wait 6'b000000
`define Decode 6'b000001
`define GetA 6'b000010
`define GetB 6'b000011
`define Sum 6'b000100
`define Write 6'b000101
`define Sub 6'b000110
`define And 6'b000111
`define Not 6'b001000
`define WriteIM8 6'b001001
`define Sum0 6'b001010
`define RST 6'b001011
`define IF1 6'b001100
`define IF2 6'b001101
`define UpdatePC 6'b001110
`define LdAdr 6'b001111
`define SumBsel 6'b010000
`define WriteM 6'b010001
`define WaitM 6'b010010
`define WriteR 6'b010011
`define GetD 6'b010100
`define Halt 6'b111111

`define ADD 4'b0001
`define CMP 4'b0010
`define AND 4'b0011
`define MVN 4'b0100
`define MOV 4'b0101
`define MOVREG 4'b0110
`define LDR 4'b0111
`define STR 4'b1000

`define MNONE 2'b00
`define MREAD 2'b01
`define MWRITE 2'b10

module fsm(clk, reset, opcode, op, control, reset_pc, load_pc, addr_sel, mem_cmd, load_ir, load_addr);
    input clk, reset;
    input [2:0] opcode;
    input [1:0] op;

    output [13:0] control;
    reg [13:0] control;

    output reg reset_pc;
    output reg load_pc;
    output reg addr_sel;
    output reg load_ir;
    output reg load_addr;
    output reg [1:0] mem_cmd;

    // nsel: [13:11] = [Rn, Rd, Rm]
    // vsel; [10:7] = [datapath_out, PC, sximm8,  mdata]
    // write; (6)
    // loada;
    // loadb;
    // asel;
    // bsel; 
    // loadc;
    // loads; (0)

    reg [5:0] state;
    reg [3:0] path;

    always_ff @(posedge clk) begin
        if (reset) begin
            state = `RST; // By Tian
        end
        else if (state == `Halt) state = `Halt;
        else if (state == `RST) state = `IF1;
        else if (state == `IF1) state = `IF2;
        else if (state == `IF2) state = `UpdatePC;
        else if (state == `UpdatePC) state = `Decode;
        else if (state == `Decode) begin
        if (opcode == 3'b111) state = `Halt;
        else case({opcode, op})    // By both Iain and Tian 
                {{3'b101, 2'b00}} : {path, state} = {`ADD, `GetA}; // Go to ADD
                {{3'b101, 2'b01}} : {path, state} = {`CMP, `GetA}; // Go to CMP
                {{3'b101, 2'b10}} : {path, state} = {`AND, `GetA}; // Go to AND
                {{3'b101, 2'b11}} : {path, state} = {`MVN, `GetB}; // Go to MVN
                {{3'b110, 2'b10}} : {path, state} = {`MOV, `WriteIM8}; // Go to MOV
                {{3'b110, 2'b00}} : {path, state} = {`MOVREG, `GetB}; // Go to MOV From Reg
                {{3'b011, 2'b00}} : {path, state} = {`LDR, `GetA}; // Go to LDR From Reg
                {{3'b100, 2'b00}} : {path, state} = {`STR, `GetA}; // Go to STR From Reg
                default : path = 4'bxxxx;
            endcase
        end
    
        // Get A and B, find their sum, then write it
        else if (path == `ADD) begin // By Iain
            case (state)
                `GetA: state = `GetB;
                `GetB: state = `Sum;
                `Sum: state = `Write;
                `Write: state = `IF1;
            endcase
        end

        // Get A and B and update status based on their Sub
        else if (path == `CMP) begin // By Iain
            case (state)
                `GetA: state = `GetB;
                `GetB: state = `Sub;
                `Sub: state = `IF1;
            endcase
        end

        // Bitwise AND A and B and write it
        else if (path == `AND) begin // By Tian
            case (state)
                `GetA: state = `GetB;
                `GetB: state = `And;
                `And: state = `Write;
                `Write: state = `IF1;
            endcase
        end

        // Bitwise NOT A and write it
        else if (path == `MVN) begin // By Iain
            case (state)
                `GetB: state = `Not;
                `Not: state = `Write;
                `Write: state = `IF1;
            endcase
        end

        // write SXIMM 8
        else if (path == `MOV) begin // By Tian
            case (state)
                `WriteIM8: state = `IF1;
            endcase
        end
        
        // write B to a reg
        else if (path == `MOVREG) begin // By Tian
            case (state)
                `GetB: state = `Sum0;
                `Sum0: state = `Write;
                `Write: state = `IF1;
            endcase
        end

        // LDR Instruction
        else if (path == `LDR) begin // By Tian
            case (state)
                `GetA: state = `SumBsel;
                `SumBsel: state = `LdAdr;
                `LdAdr: state = `WaitM;
                `WaitM: state = `WriteM;
                `WriteM: state = `IF1;
            endcase
        end
        else if (path == `STR) begin // By Iain 
            case (state)
                `GetA: state = `SumBsel;
                `SumBsel: state = `LdAdr;
                `LdAdr: state = `GetD;
                `GetD: state = `Sum0;
                `Sum0: state = `WriteR;
                `WriteR: state = `IF1;
            endcase
        end
    end

    always @(*) begin

        if (state == `RST) reset_pc = 1'b1;
        else reset_pc = 1'b0;
        
        if (state == `IF1 | state == `IF2 | state == `LdAdr | state == `WriteM) mem_cmd = `MREAD;
        else if (state == `WriteR) mem_cmd = `MWRITE;
        else mem_cmd = `MNONE;

        if (state == `IF1 | state == `IF2) addr_sel = 1'b1;
        else addr_sel = 1'b0;
        
        if (state == `IF2) load_ir = 1'b1;
        else load_ir = 1'b0;
        
        if (state == `UpdatePC | state == `RST) load_pc = 1'b1;
        else load_pc = 1'b0;

        if (state == `LdAdr | state == `SumBsel) begin
            load_addr = 1'b1;
        end
        else begin
            load_addr = 1'b0;
        end
        // Change state - By both Iain and Tian
        case (state)
            `GetA: control = 14'b100_0010_0100000;
            `GetB: control = 14'b001_0010_0010000;
            `GetD: control = 14'b010_0010_0010000;
             `Sum: control = 14'b000_1000_0000010;
           `Write: control = 14'b010_1000_1000000;
             `Sub: control = 14'b000_0010_0000011;
             `And: control = 14'b000_0010_0000010;
             `Not: control = 14'b000_0010_0000010;
        `WriteIM8: control = 14'b100_0010_1000000;
            `Sum0: control = 14'b000_0010_0001010; 
         `SumBsel: control = 14'b000_0010_0000110;
          `WriteM: control = 14'b010_0001_1000000;
          `WriteR: control = 14'b000_0010_0001010;
          default: control = 14'b000_0000_0000000;
        endcase
    end
endmodule