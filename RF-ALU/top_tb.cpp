#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
    int simcyc;
    int clk;

    Verilated::commandArgs(argc, argv);
    //init top verilog instance
    Vtop* top = new Vtop;
    //init trace dump
    Verilated::traceEverOn (true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("top.vcd");

    // initialize simulation inputs
    top->clk = 1;
    top->AD1 = 0;
    top->AD2 = 0;
    top->AD3 = 0;
    top->RegWrite = 0;
    top->ALUctrl = 0;
    top->ALUsrc = 0;
    top->ImmOp = 0;

    //run simulation for 150 clock cycles
    for (simcyc=0; simcyc<10; simcyc++){

        //dump variables into VCD file and toggle clock
        for (clk=0; clk<2; clk++) {
            tfp->dump (2*simcyc+clk);
            top->clk = !top->clk;
            top->eval ();
        }

        top->AD1 = (simcyc == 5);
        top->AD2 = (simcyc == 6);
        if (simcyc == 2) top->AD3 = 16;
        top->RegWrite = (simcyc > 5);
        top->ALUsrc = (simcyc < 7);
        if (simcyc > 2) top->ImmOp = 25;

        if (Verilated::gotFinish())  exit(0);
    }
    tfp->close();
    exit(0);
}
