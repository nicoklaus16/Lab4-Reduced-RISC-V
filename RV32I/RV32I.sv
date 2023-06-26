module RV32I #(
    parameter   WIDTH = 32,
                typeWIDTH = 3,
                aluopWIDTH = 3
) (
    input logic                 clk,
    input logic                 rst,
    output logic [WIDTH-1:0]    a0
);

    logic PCsrc, RegWrite, ALUsrc, EQ;
    logic [WIDTH-1:0] ImmOp;
    logic [WIDTH-1:0] PC;
    logic [WIDTH-1:0] instr;
    logic [WIDTH-1:0] ALUout;
    logic [WIDTH-1:0] ALUop1;
    logic [WIDTH-1:0] ALUop2;
    logic [WIDTH-1:0] regOp2;
    logic [typeWIDTH-1:0] ImmSrc;
    logic [aluopWIDTH-1:0] ALUctrl;

    programcounter PC1 (
        .clk(clk),
        .rst(rst),
        .PCsrc(PCsrc),
        .ImmOp(ImmOp),
        .PC(PC)
    );

    rom rom1 (
        //Pass only the first 8 bits because we have a 32 words long memory to not overload Verilator
        .addr(PC[7:0]),
        .dout(instr)
    );

    controlunit CU1 (
        .EQ(EQ),
        .opcode(instr[6:0]),
        .funct7(instr[31:25]),
        .funct3(instr[14:12]),
        .RegWrite(RegWrite),
        .ALUsrc(ALUsrc),
        .PCsrc(PCsrc),
        .ImmSrc(ImmSrc),
        .ALUctrl(ALUctrl)
    );

    sext sext1 (
        .instr(instr),
        .ImmSrc(ImmSrc),
        .ImmOp(ImmOp)
    );

    registerfile RF1 (
        .clk(clk),
        .AD1(instr[19:15]),
        .AD2(instr[24:20]),
        .AD3(instr[11:7]),
        .RegWrite(RegWrite),
        .WD3(ALUout),
        .RD1(ALUop1),
        .RD2(regOp2),
        .a0(a0)
    );

    assign ALUop2 = ALUsrc ? ImmOp : regOp2;

    ALU ALU1(
        .ALUop1(ALUop1),
        .ALUop2(ALUop2),
        .ALUctrl(ALUctrl),
        .EQ(EQ),
        .ALUout(ALUout)
    );
    
endmodule
