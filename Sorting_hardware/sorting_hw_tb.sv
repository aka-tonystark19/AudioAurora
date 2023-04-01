`timescale 1ns/1ns
`define clk_cycle #2

module sorting_hw_tb();
    logic clk, rst_n;
    logic slave_waitrequest, slave_read, slave_write;
    logic [31:0] slave_address, slave_readdata, slave_writedata;
    logic [31:0] master_address, master_readdata, master_writedata;
    logic master_read, master_write;
    logic [9:1] LEDR;

    enum{INIT, LOAD1, LOAD2, CMP, SWITCH, SWITCH2, DONE} state;

    sorting_hardware DUT(clk, rst_n,
                // slave (CPU-facing)
                slave_waitrequest, //1 for busy, 0 for free
                slave_address,
                slave_read, slave_readdata,
                slave_write, slave_writedata,
                // master (SDRAM-facing)
                master_address, //the address I want to read or write to
                master_read, master_readdata, //assert if i want to read or write
                master_write, master_writedata, LEDR);

    initial begin
        clk = 1; #1 clk = 0;
            forever begin
                if(DUT.state == DONE)begin
                    $display("Simulation has reached finish state");
                    $stop;
                end
                #1 clk = 1; #1 clk = 0;
            end
    end

    initial begin
        rst_n = 0;
        slave_address = 0;
        slave_write = 1;
        `clk_cycle;
         rst_n = 1;
        @ (posedge DUT.state);
        if(DUT.state != LOAD1)begin
            $display("Error: state is not LOAD1");
            $stop;
        end
        @ (posedge DUT.state or negedge DUT.state);
        if(DUT.state != LOAD2)begin
            $display("Error: state is not LOAD2");
            $stop;
        end
        master_readdata = 1; //gets data for data1
        @ (posedge DUT.state or negedge DUT.state);
        if(DUT.state != CMP)begin
            $display("Error: state is not CMP");
            $stop;
        end
        master_readdata = 0; //gets data for data 2
        @ (posedge DUT.state or negedge DUT.state);
        if(DUT.state != SWITCH)begin
            $display("Error: state is not SWITCH");
            $stop;
        end
        @ (posedge DUT.state or negedge DUT.state);
        if(DUT.state != SWITCH2)begin
            $display("Error: state is not SWITCH2");
            $stop;
        end
        @ (posedge DUT.state or negedge DUT.state);
        if(DUT.state != LOAD1)begin
            $display("Error: state is not LOAD1");
            $stop;
        end
        $stop;

    end

endmodule