module fft_wrapper_top(  input logic CLOCK_50,
    input logic [3:0] KEY, // KEY[3] is async active-low reset
    input logic [9:0] SW,
    output logic [9:0] LEDR);
	 assign LEDR[0] = 10'b1;

	fft_acc u0 (
		.clk_clk       (CLOCK_50),       //   clk.clk
		.reset_reset_n (KEY[3]),   //  reset.reset_n
		.lights_readdata (LEDR[9:1])  // lights.readdata
	);

endmodule 