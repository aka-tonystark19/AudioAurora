module fft_wrapper(input logic clk, input logic rst_n,
                // slave (CPU-facing)
                output logic slave_waitrequest, //1 for busy, 0 for free
                input logic [3:0] slave_address,
                input logic slave_read, output logic [31:0] slave_readdata,
                input logic slave_write, input logic [31:0] slave_writedata,
                // master (SDRAM-facing)
                input logic master_waitrequest, //comes from mem, need to wait until it is 0, 1 for busy 0 for free
                output logic [31:0] master_address, //the address I want to read or write to
                output logic master_read, input logic [31:0] master_readdata, //assert if i want to read or write
				input logic master_readdatavalid,	//need to check if it is valid, store only if its valid
                output logic master_write, output logic [31:0] master_writedata,
				input logic master_waitrequest2,
                output logic [31:0] master_address2, //the address I want to read or write to
                output logic master_read2, input logic [31:0] master_readdata2, //assert if i want to read or write
				input logic master_readdatavalid2,	//need to check if it is valid, store only if its valid
                output logic master_write2, output logic [31:0] master_writedata2,
				output logic [9:1] LEDR);
				
	//states
	enum{INIT, START, READ, WAITFFT, WRITE, DONE} state, next_state;

	//values from CPU
	logic [31:0] new_m_addr, new_m_addr2; //the two address are the same so only need one address
	logic [31:0] x0, y0, x1, y1, x2, y2, x3, y3;
	logic [9:0] count, new_count; //keep track of how many times I have read or written (512)
	logic [31:0] mag; //magnitude of output
	logic reset, next_reset, next, next_out; //control signals for fft
	assign slave_readdata = 32'd777;

	//there are no imaginary inputs so assign them to 0
	assign x1 = 31'b0;
	assign x3 = 31'b0;

	dft_top fft(clk, reset, next, next_out,
			x0, y0,
			x1, y1,
			x2, y2,
			x3, y3);

	//dff, updates every clock cycle
	always_ff @( posedge clk ) begin
		//if reset
		if (~rst_n) begin //reset_n is active low
			state <= INIT;
			count <= 0;
			//reset <= 1'b1; //rest for the fft
			master_address <= 32'h7000;
			master_address2 <= 32'h6000;
		end
		else begin
			state <= next_state;
			count <= new_count;	
			//reset <= 1'b0;
			master_address <= new_m_addr;
			master_address2 <= new_m_addr2;
		end
		
	end

	always @(*) begin
		case(state)
			INIT: begin //reset the fft first
				next_state = (slave_write && slave_address == 4'd0) ? START : INIT;
				new_count = 1'b0;
				new_m_addr = 32'h7000;
				new_m_addr2 = 32'h6000;
				reset = 1'b1; //reset the fft
				next = 1'b0;

				//fft inputs
				x0 = 32'b0;
				x2 = 32'b0;
				//master slave interface
				slave_waitrequest = 1'b0; //free
				master_read = 1'b0;
				master_write = 1'b0;
				master_read2 = 1'b0;
				master_write2 = 1'b0;
				master_writedata = 0;
				master_writedata2 = 0;
				LEDR[9:4]= 6'b100000;
			end
			START:begin //signal the fft to start reading values
			//if(master_waitrequest == 1'b0 && master_waitrequest2 == 1'b0) begin
				next_state = READ;
				next = 1'b1; //signal the fft to start reading values
				master_read = 1'b1;
				master_read2 = 1'b1;
				new_m_addr = master_address + 32'd4; //need to read the next val next clock
				new_m_addr2 = master_address2 + 32'd4;
				/*
			end else begin
				next_state = state; //master busy
				next = 1'b0; //don't signal the fft
				master_read = 1'b0;
				master_read2 = 1'b0;
				new_m_addr = 32'h7000;
				new_m_addr2 = 32'h6000;
			end
			*/
				new_count = 0;
				reset = 1'b0;
				
				//fft inputs
				x0 = 32'b0;
				x2 = 32'b0;
				//master slave interface
				slave_waitrequest = 1'b1; //busy
				master_write = 1'b0;
				master_write2 = 1'b0;
				master_writedata = 0;
				master_writedata2 = 0;
				LEDR[9:4]= 6'b010000;
			end
			READ: begin //read 512 values per port from memory
				if(count <= 10'd511) begin //wait 512 clk cycles to read all the values
					next_state = state;
					new_count = count + 1'b1;
					master_read = 1'b1;
					master_read2 = 1'b1;
					new_m_addr = master_address + 32'd4;
					new_m_addr2 = master_address2 + 32'd4;
				end else begin
					next_state = WAITFFT;
					new_count = 1'b0;
					master_read = 1'b0;
					master_read2 = 1'b0;
					new_m_addr = 32'h7000;
					new_m_addr2 = 32'h6000;
				end
				//check for valid data
				if(master_readdatavalid == 1'b1 && master_readdatavalid2 == 1'b1) begin
					x0 = master_readdata;
					x2 = master_readdata2;
				end else begin
					//thinking of the illusion of choice
					x0 = master_readdata;
					x2 = master_readdata2;
				end
				reset = 1'b0;
				next = 1'b0;
				//master slave interface
				slave_waitrequest = 1'b1; //busy
				master_write = 1'b0;
				master_write2 = 1'b0;
				master_writedata = 0;
				master_writedata2 = 0;
				LEDR[9:4]= 6'b001000;

			end
			WAITFFT:begin
				if(next_out == 1'b1) begin //fft will start outputting values next clock cycle
					next_state = WRITE;	
				end else begin
					next_state = state;
				end
				new_count = 1'b0;
				new_m_addr = 32'h7000;
				new_m_addr2 = 32'h6000;
				reset = 1'b0;
				next = 1'b0;

				//fft inputs
				x0 = 32'b0;
				x2 = 32'b0;

				//master slave interface
				slave_waitrequest = 1'b1; //busy
				master_read = 1'b0;
				master_read2 = 1'b0;
				master_write = 1'b0;
				master_write2 = 1'b0;
				master_writedata = 0;
				master_writedata2 = 0;
				LEDR[9:4]= 6'b000100;
			end
			WRITE:begin
				if(count <= 10'd511) begin //wait 512 clk cycles to read all the values
					next_state = state;
					new_count = count + 1'b1;
					master_write = 1'b1;
					master_write2 = 1'b1;
					new_m_addr = master_address + 32'd4;
					new_m_addr2 = master_address2 + 32'd4;
				end else begin
					next_state = DONE;
					new_count = 1'b0;
					master_write = 1'b0;
					master_write2 = 1'b0;
					new_m_addr = 32'h7000;
					new_m_addr2 = 32'h6000;
				end
				//fft inputs
				x0 = 0;
				x2 = 0;
				reset = 1'b0;
				next = 1'b0;
				//master slave interface
				slave_waitrequest = 1'b1; //busy
				master_read = 1'b0;
				master_read2 = 1'b0;
				master_writedata = y0*y0 + y1*y1; //write the magnitudes into memory
				master_writedata2 = y2*y2 + y3*y3;
				LEDR[9:4]= 6'b000010;
			end
			DONE:begin //done
				next_state = INIT;
				new_count = 1'b0;
				new_m_addr = 32'h7000;
				new_m_addr2 = 32'h6000;
				reset = 1'b0; 
				next = 1'b0;

				//fft inputs
				x0 = 32'b0;
				x2 = 32'b0;
				//master slave interface
				slave_waitrequest = 1'b1; // after returning to INIT will stop being busy
				master_read = 1'b0;
				master_write = 1'b0;
				master_read2 = 1'b0;
				master_write2 = 1'b0;
				master_writedata = 0;
				master_writedata2 = 0;
				LEDR[9:4]= 6'b000001;
			end
			default:begin //default
				next_state = INIT;
				new_count = 1'b0;
				new_m_addr = 32'b0;
				new_m_addr2 = 32'b0;
				reset = 1'b0; 
				next = 1'b0;

				//fft inputs
				x0 = 32'b0;
				x2 = 32'b0;
				//master slave interface
				slave_waitrequest = 1'b0; // after returning to INIT will stop being busy
				master_read = 1'b0;
				master_write = 1'b0;
				master_read2 = 1'b0;
				master_write2 = 1'b0;
				master_writedata = 0;
				master_writedata2 = 0;
				LEDR[9:4]= 6'b000000;
			end
		endcase
		
	end



endmodule