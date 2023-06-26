module controlunit #(
    parameter   WIDTH = 32,
                OCWIDTH = 7,
                F7WIDTH = 7,
                F3WIDTH = 3,
                aluopWIDTH = 3,
                typeWIDTH = 3
) (
    input logic                     EQ,
    input logic [OCWIDTH-1:0]       opcode,
    input logic [F7WIDTH-1:0]       funct7,
    input logic [F3WIDTH-1:0]       funct3,
    output logic                    RegWrite,
    output logic                    ALUsrc,
    output logic                    PCsrc,
    output logic [typeWIDTH-1:0]    ImmSrc,
    output logic [aluopWIDTH-1:0]   ALUctrl
);

    always_comb begin
        case (opcode)
            7'b0010011: case (funct3)
                            // addi
                            3'b000: begin
                                RegWrite = 1;
                                ALUsrc = 1;
                                ImmSrc = 3'b000;
                                PCsrc = 0;
                                ALUctrl = 3'b000;
                            end

                            default: begin
                                RegWrite = 0;
                                ALUsrc = 0;
                                ImmSrc = 3'b000;
                                PCsrc = 0;
                                ALUctrl = 3'b000;
                            end
                        endcase
            
            7'b1100011: case (funct3)
                        // bne
                        3'b001: begin
                            RegWrite = 0;
                            ALUsrc = 0;
                            ImmSrc = 3'b010;
                            if (EQ)     PCsrc = 0;
                            else        PCsrc = 1;
                            //SHOULD I SPECIFY ALUCTRL???
                        end

                        default: begin
                            RegWrite = 0;
                            ALUsrc = 0;
                            ImmSrc = 3'b000;
                            PCsrc = 0;
                            ALUctrl = 3'b000;
                        end
                        endcase
            default: begin
                RegWrite = 0;
                ALUsrc = 0;
                ImmSrc = 3'b000;
                PCsrc = 0;
                ALUctrl = 3'b000;
            end
        endcase
    end

endmodule
