`timescale 1ns/1ns
`define clk_cycle #2
module fft_wrapper_tb();

logic clk, rst_n;
logic slave_waitrequest, slave_read, slave_write;
logic [31:0] slave_address, slave_readdata, slave_writedata;
logic master_waitrequest, master_read, master_write, master_readdatavalid, master_waitrequest2, master_read2, master_write2, master_readdatavalid2;
logic [31:0] master_address, master_readdata, master_writedata, master_address2, master_readdata2, master_writedata2;

integer i, j;
	enum{INIT, START, READ, WAITFFT, WRITE, DONE} state;

fft_wrapper DUT(clk, rst_n,
                // slave (CPU-facing)
                slave_waitrequest, //1 for busy, 0 for free
                slave_address,
                slave_read, slave_readdata,
                slave_write, slave_writedata,
                // master (SDRAM-facing)
                master_waitrequest, //comes from mem, need to wait until it is 0, 1 for busy 0 for free
                master_address, //the address I want to read or write to
                master_read, master_readdata, //assert if i want to read or write
				master_readdatavalid,	//need to check if it is valid, store only if its valid
                master_write, master_writedata,
				master_waitrequest2,
                master_address2, //the address I want to read or write to
                master_read2, master_readdata2, //assert if i want to read or write
				master_readdatavalid2,	//need to check if it is valid, store only if its valid
                master_write2, master_writedata2);

initial begin
	clk = 1; #1 clk = 0;
	    forever begin
            if(DUT.state == DONE)begin
                $display("Simulation has reached finish state");
                $stop;
            end
        #1 clk = 1; #1 clk = 0 ;
        end
end

initial begin
    //set initial values
    rst_n = 0;
    master_waitrequest = 0; //assume always free
    master_waitrequest2 = 0;
    master_readdatavalid = 1; //assume always valid
    master_readdatavalid2 = 1;
    slave_writedata = 0;
    `clk_cycle;
    rst_n = 1;
    @ (posedge DUT.state);
    if(DUT.state != START)begin
        $display("Error: state is not START");
        $stop;
    end
    @ (posedge DUT.state or negedge DUT.state);
    if(DUT.state != READ)begin
        $display("Error: state is not READ");
        $stop;
    end
    //pass in values to x0 and x2
    for(i = 0; i< 512; i = i + 1) begin
        master_readdata = i;
        master_readdata2 = i;
        `clk_cycle;
    end
    @ (posedge DUT.state or negedge DUT.state);
    if(DUT.state != WAITFFT)begin
        $display("Error: state is not WAITFFT");
        $stop;
    end

    @ (posedge DUT.state or negedge DUT.state);
    if(DUT.state != WRITE)begin
        $display("Error: state is not WRITE");
        $stop;
    end
    for(i = 0; i < 512; i = i + 1) begin
        $display("%d + %d i", $signed(DUT.y0),$signed(DUT.y1));
		$display("%d + %d i", $signed(DUT.y2),$signed(DUT.y3));
        `clk_cycle;
    end

    @ (posedge DUT.state or negedge DUT.state);
    


    
    


end


endmodule