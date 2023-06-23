module top #(
    parameter   WIDTH = 32,
                AWIDTH = 8,
                typeWIDTH = 3,
                aluopWIDTH = 3
) (
    input logic [AWIDTH-1:0] address,
    output logic [WIDTH-1:0] ImmOp,
    output logic [WIDTH-1:0] instr,
    output logic                    RegWrite,
    output logic                    ALUsrc,
    output logic                    PCsrc,
    output logic [typeWIDTH-1:0]    ImmSrc,
    output logic [aluopWIDTH-1:0]   ALUctrl
);

    rom rom1(
        .addr(address),
        .dout(instr)
    );
    
    sext sext1(
        .instr({instr}),
        .ImmSrc (ImmSrc),
        .ImmOp(ImmOp)
    );

    controlunit controlunit1(
        .zero(1'b0),
        .opcode(instr[6:0]),
        .funct7(instr[31:25]),
        .funct3(instr[14:12]),
        .RegWrite(RegWrite),
        .ALUsrc(ALUsrc),
        .PCsrc(PCsrc),
        .ImmSrc(ImmSrc),
        .ALUctrl(ALUctrl)
    );

endmodule
