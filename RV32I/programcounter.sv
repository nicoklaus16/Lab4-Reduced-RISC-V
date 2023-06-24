module programcounter #(
    parameter   WIDTH = 32
) (
    input logic clk,
    input logic rst,
    input logic PCsrc,
    input logic [WIDTH-1:0]     ImmOp,
    output logic [WIDTH-1:0]    PC
);
    logic [WIDTH-1:0] next_PC;
    //logic [WIDTH-1:0] branch_PC;
    //logic [WIDTH-1:0] inc_PC;

    assign next_PC = PCsrc ? PC + ImmOp : PC + 3'b100;

    /*always_comb begin
        branch_PC = PC + ImmOp;
        inc_PC = PC + 3'b100;
        if (PCsrc)  next_PC = branch_PC;
        else        next_PC = inc_PC;
    end*/

    always_ff @(posedge clk, posedge rst) begin
        if (rst)    PC <= {WIDTH{1'b0}};
        else        PC <= next_PC;
    end


endmodule
