module registerfile #(
    parameter   WIDTH = 32,
                rWIDTH = 5

) (
    input logic                 clk,
    input logic [rWIDTH-1:0]    AD1,
    input logic [rWIDTH-1:0]    AD2,
    input logic [rWIDTH-1:0]    AD3,
    input logic                 RegWrite,
    input logic [WIDTH-1:0]     WD3,
    output logic [WIDTH-1:0]    RD1,
    output logic [WIDTH-1:0]    RD2,
    output logic [WIDTH-1:0]    a0
);
    logic [WIDTH-1:0] zero = {WIDTH{1'b0}};
    logic [WIDTH-1:0] a1;
    logic [WIDTH-1:0] t1;

    always_ff @(negedge clk) begin
        case (AD1)
            5'h0: RD1 <= zero;
            5'h6: RD1 <= t1;
            5'hB: RD1 <= a1;
            default: RD1 <= {WIDTH{1'b0}};
        endcase

        case (AD2)
            5'h0: RD2 <= zero;
            5'h6: RD2 <= t1;
            5'hB: RD2 <= a1;
            default: RD2 <= {WIDTH{1'b0}};
        endcase

        if (RegWrite)
            case (AD3)
                5'h6: t1 <= WD3;
                5'hA: a0 <= WD3;
                5'hB: a1 <= WD3;
                default: begin
                    t1 <= {WIDTH{1'b0}};
                    a0 <= {WIDTH{1'b0}};
                    a1 <= {WIDTH{1'b0}};
                end
            endcase
    end
    
endmodule
