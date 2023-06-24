module top #(
    parameter   WIDTH = 32,
                rWIDTH = 5,
                aluctrlWIDTH = 3
) (
    input logic                     clk,
    input logic [rWIDTH-1:0]        AD1,
    input logic [rWIDTH-1:0]        AD2,
    input logic [rWIDTH-1:0]        AD3,
    input logic                     RegWrite,
    input logic [aluctrlWIDTH-1:0]  ALUctrl,
    input logic                     ALUsrc,
    input logic [WIDTH-1:0]         ImmOp,
    output logic [WIDTH-1:0]        ALUout,
    output logic [WIDTH-1:0]        a0
);

    logic [WIDTH-1:0]   ALUop1, regOp2, ALUop2;
    logic EQ;

    registerfile regfile1(
        .clk(clk),
        .AD1(AD1),
        .AD2(AD2),
        .AD3(AD3),
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
