module ALU #(
    parameter   WIDTH = 32,
                aluctrlWIDTH = 3
) (
    input logic [WIDTH-1:0]         ALUop1,
    input logic [WIDTH-1:0]         ALUop2,
    input logic [aluctrlWIDTH-1:0]  ALUctrl,
    output logic                    EQ,
    output logic [WIDTH-1:0]        ALUout
);

    always_comb begin
        case (ALUctrl)
            3'b0: ALUout = ALUop1 + ALUop2;
            default: ALUout = {WIDTH{1'b0}};
        endcase
    end
    
endmodule
