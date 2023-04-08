`timescale 1ns/1ns
`define clk_cycle #2

module sorting_hw_tb();
    logic clk, rst_n;
    logic slave_waitrequest, slave_read, slave_write;
    logic [31:0] slave_address, slave_readdata, slave_writedata;
    logic [31:0] master_address, master_readdata, master_writedata;
    logic master_read, master_write, master_waitrequest, master_readdatavalid;
    logic [9:1] LEDR;
    //instantiate a locl memory
    logic [31:0] mem[0:1023];

    enum{INIT, LOAD1, LOAD2, CMP, SWITCH, SWITCH2, DONE} state;

    sorting_hardware DUT(clk, rst_n,
                // slave (CPU-facing)
                slave_waitrequest, //1 for busy, 0 for free
                slave_address,
                slave_read, slave_readdata,
                slave_write, slave_writedata,
                // master (SDRAM-facing)
                master_waitrequest,
                master_address, //the address I want to read or write to
                master_read, master_readdata, //assert if i want to read or write
                master_readdatavalid,
                master_write, master_writedata, LEDR);

    //convert master address to array indices

    initial begin
        //fill in the mem with integers 1023 to 0
        for(int i = 0; i < 1024; i = i + 1)begin
            mem[i] = 1023 - i;
        end

        clk = 1; #1 clk = 0;
            forever begin
                if(DUT.state == DONE)begin
                    $display("Simulation has reached finish state");
                    // check if the array is sorted
                    for(int i = 0; i < 1023; i = i + 1)begin
                        if(mem[i] > mem[i+1])begin
                            $display("Error: array is not sorted");
                            $stop;
                        end
                    end
                    $display("Array is sorted");
                    $stop;
                end
                if(DUT.state == LOAD2)begin
                    master_readdata = mem[(master_address-32'h6000-4)/4];
                end
                if(DUT.state == CMP)begin
                    master_readdata = mem[(master_address-32'h6000-4)/4];
                end
                #1 clk = 1; #1 clk = 0;
                mem[(master_address-32'h6000)/4] = master_write ? master_writedata : mem[(master_address-32'h6000)/4];
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
        //master_readdata = 1; //gets data for data1
        @ (posedge DUT.state or negedge DUT.state);
        if(DUT.state != CMP)begin
            $display("Error: state is not CMP");
            $stop;
        end
        //master_readdata = 0; //gets data for data 2
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
        `clk_cycle;
        `clk_cycle;
        if(DUT.state != LOAD1)begin
            $display("Error: state is not LOAD1");
            $stop;
        end
        //$stop;

    end

endmodule