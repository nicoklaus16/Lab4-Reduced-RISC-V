#include "Vprogramcounter.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
    int simcyc;
    int clk;

    Verilated::commandArgs(argc, argv);
    //init top verilog instance
    Vprogramcounter* top = new Vprogramcounter;
    //init trace dump
    Verilated::traceEverOn (true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("programcounter.vcd");

    // initialize simulation inputs
    top->clk = 1;
    top->rst = 1;
    top->PCsrc = 0;
    top->ImmOp = 8;

    //run simulation for 150 clock cycles
    for (simcyc=0; simcyc<40; simcyc++){

        //dump variables into VCD file and toggle clock
        for (clk=0; clk<2; clk++) {
            tfp->dump (2*simcyc+clk);
            top->clk = !top->clk;
            top->eval ();
        }

        top->rst = (simcyc<4);
        top->PCsrc = (simcyc>=10 && simcyc<12);

        if (Verilated::gotFinish())  exit(0);
    }
    tfp->close();
    exit(0);
}
