//module top(
////	input clk,
////	input rx,
////	output tx,
////	output [7:0]led
//
//	input CLOCK_50,
//	input [3:0] KEY,
//	output [7:0] USER_LED,
//	input [0:35] GPIO_0,
//	output [0:35] GPIO_1
//	
//);
//	
//	
//
//audioUart u0(
//	.clk_clk		(CLOCK_50),
//	.led_external_connection_export (USER_LED),
//	.rs232_external_connection_rxd (GPIO_0[35]),
//	.rs232_external_connection_txd (GPIO_1[35])
//	
//);
//
//endmodule


module top(
    input CLOCK_50,
    input [3:0] KEY,
    input [35:0] GPIO_1,
    output [7:0] USER_LED,
    output [35:0] GPIO_0
);

audioUart u0 (
//    .reset_reset_n (KEY[0]),
    .clk_clk (CLOCK_50),
    .led_external_connection_export (USER_LED),
    .rs232_external_connection_rxd (GPIO_1[35]),
    .rs232_external_connection_txd (GPIO_0[35])
);

endmodule