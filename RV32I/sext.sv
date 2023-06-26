module sext #(
    parameter   WIDTH = 32,
                instrWIDTH = 32,
                typeWIDTH = 3
) (
    input logic [instrWIDTH-1:0]    instr,
    input logic [typeWIDTH-1:0]     ImmSrc,
    output logic [WIDTH-1:0]        ImmOp
);

    always_comb begin
        case(ImmSrc)
            //Immediate
            {(typeWIDTH){1'b0}}: ImmOp = {{20{instr[31]}}, instr[31:20]};
            //Store
            {{(typeWIDTH-1){1'b0}}, {1'b1}}: ImmOp = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            //Branch
            {{(typeWIDTH-2){1'b0}}, {2'b10}}: ImmOp = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], {1'b0}};

            default: ImmOp = {WIDTH{1'b0}};
        endcase
    end

endmodule
