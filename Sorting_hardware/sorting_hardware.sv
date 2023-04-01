module sorting_hardware(input logic clk, input logic rst_n,
                // slave (CPU-facing)
                output logic slave_waitrequest, //1 for busy, 0 for free
                input logic [3:0] slave_address,
                input logic slave_read, output logic [31:0] slave_readdata,
                input logic slave_write, input logic [31:0] slave_writedata,
                // master (SDRAM-facing)
                output logic [31:0] master_address, //the address I want to read or write to
                output logic master_read, input logic [31:0] master_readdata, //assert if i want to read or write
                output logic master_write, output logic [31:0] master_writedata,
				output logic [9:1] LEDR);

    //define the states
    enum{INIT, LOAD1, LOAD2, CMP, SWITCH, SWITCH2, DONE} state, next_state;
    logic [31:0] data1, next_data1, data2, next_data2;
    logic swapped, new_swapped;
    logic [31:0] new_m_addr;
    logic [9:0] count, new_count;

    //dff, updates every clock cycle
	always_ff @( posedge clk ) begin
		//if reset
		if (~rst_n) begin //reset_n is active low
			state <= INIT;
			count <= 0;
			swapped <= 1'b0;
			master_address <= 32'h0; //some hardcoded value
            data1 <= 32'h0;
            data2 <= 32'h0;
		end
		else begin
			state <= next_state;
			count <= new_count;	
			swapped <= new_swapped;
			master_address <= new_m_addr;
            data1 <= next_data1;
            data2 <= next_data2;
		end	
	end

    always@(*)begin
        case(state)
            INIT:begin
                next_state = (slave_write && slave_address == 4'd0) ? LOAD1 : INIT; //wait for it to be started
                new_count = 10'b0;
                new_m_addr = 32'h0;
                slave_waitrequest = 1'b0; //free
                master_read = 1'b0;
				master_write = 1'b0;
                master_writedata = 32'h0;
                new_swapped = 1'b0;
                //the data
                next_data1 = 32'h0;
                next_data2 = 32'h0;
                LEDR[9:3]= 7'b1000000;
            end
            LOAD1:begin //load the first data
            if(count == 10'd1023 && swapped == 0)begin
                next_state = DONE;
            end else begin
                next_state = LOAD2; //either swap was 1 or not at 1023
            end
                new_count = count;
                new_m_addr = master_address + 32'h4; //load the next value
                slave_waitrequest = 1'b1; //busy
                master_read = 1'b1;
                master_write = 1'b0;
                master_writedata = 32'h0;
                new_swapped = swapped;
                //the data
                next_data1 = 32'h0;
                next_data2 = 32'h0;
                LEDR[9:3]= 7'b0100000;
            end
            LOAD2:begin 
                next_state = CMP;
                new_count = count;
                new_m_addr = master_address + 32'h4; //load the next value
                slave_waitrequest = 1'b1; //busy
                master_read = 1'b1;
                master_write = 1'b0;
                master_writedata = 32'h0;
                new_swapped = swapped;
                //the data
                next_data1 = master_readdata; //gets the 1st data from last cycle
                next_data2 = 32'h0;
                LEDR[9:3]= 7'b0010000;
            end
            CMP:begin
                if(data1 > master_readdata)begin
                    next_state = SWITCH;
                    new_swapped = 1'b1;
                    new_m_addr = master_address - 32'd8;
                end else begin
                    next_state = LOAD1;
                    new_swapped = swapped;
                    new_m_addr = master_address;
                end
                new_count = (count == 10'd1023)? 1'b0:count + 1'b1; //either reset or increment
                slave_waitrequest = 1'b1; //busy
                master_read = 1'b0;
                master_write = 1'b0;
                master_writedata = 32'h0;
                new_swapped = (count == 10'd1023) ? 1'b0 : swapped; //either reset or retaain valud
                //the data
                next_data1 = data1; //retains data1
                next_data2 = master_readdata; //gets the 2nd data from last cycle
                LEDR[9:3]= 7'b0001000;
            end
            SWITCH:begin //need to switch the two values
                next_state = SWITCH2;
                new_count = count;
                new_m_addr = master_address + 32'h4; 
                slave_waitrequest = 1'b1; //busy
                master_read = 1'b0;
                master_write = 1'b1;
                master_writedata = data2;
                new_swapped = swapped;
                //the data
                next_data1 = data1; 
                next_data2 = data2;
                LEDR[9:3]= 7'b0000100;
            end
            SWITCH2:begin //need to switch the two values
                next_state = LOAD1;
                new_count = count;
                new_m_addr = master_address + 32'h4; 
                slave_waitrequest = 1'b1; //busy
                master_read = 1'b0;
                master_write = 1'b1;
                master_writedata = data1;
                new_swapped = swapped;
                //the data
                next_data1 = data1; 
                next_data2 = data2;
                LEDR[9:3]= 7'b0000010;
            end
            DONE:begin
                next_state = INIT; //wait for nios to start again
                new_count = 10'b0;
                new_m_addr = 32'h0;
                slave_waitrequest = 1'b1; //will be free next clk cycle
                master_read = 1'b0;
                master_write = 1'b0;
                master_writedata = 32'h0;
                new_swapped = 1'b0;
                //the data
                next_data1 = 32'h0;
                next_data2 = 32'h0;
                LEDR[9:3]= 7'b0000001;
            end
            default:begin
                next_state = INIT;
                new_count = 10'b0;
                new_m_addr = 32'h0;
                slave_waitrequest = 1'b0; //free
                master_read = 1'b0;
                master_write = 1'b0;
                master_writedata = 32'h0;
                new_swapped = 1'b0;
                //the data
                next_data1 = 32'h0;
                next_data2 = 32'h0;
                LEDR[9:3]= 7'b0000000;
            end

        endcase

    end//end of always block

endmodule