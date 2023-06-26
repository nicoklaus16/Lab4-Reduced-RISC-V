#include "VRV32I.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
    int simcyc;
    int clk;

    Verilated::commandArgs(argc, argv);
    //init RV32I verilog instance
    VRV32I* top = new VRV32I;
    //init trace dump
    Verilated::traceEverOn (true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("RV32I.vcd");

    // initialize simulation inputs
    top->clk = 1;
    top->rst = 1;

    //run simulation for 150 clock cycles
    for (simcyc=0; simcyc<1000; simcyc++){

        //dump variables into VCD file and toggle clock
        for (clk=0; clk<2; clk++) {
            tfp->dump (2*simcyc+clk);
            top->clk = !top->clk;
            top->eval ();
        }

        top->rst = (simcyc < 3);

        if (Verilated::gotFinish())  exit(0);
    }
    tfp->close();
    exit(0);
}
