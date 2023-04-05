
module audioUart (
	clk_clk,
	led_external_connection_export,
	rs232_external_connection_rxd,
	rs232_external_connection_txd);	

	input		clk_clk;
	output	[7:0]	led_external_connection_export;
	input		rs232_external_connection_rxd;
	output		rs232_external_connection_txd;
endmodule
