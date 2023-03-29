	audioUart u0 (
		.clk_clk                        (<connected-to-clk_clk>),                        //                       clk.clk
		.led_external_connection_export (<connected-to-led_external_connection_export>), //   led_external_connection.export
		.rs232_external_connection_rxd  (<connected-to-rs232_external_connection_rxd>),  // rs232_external_connection.rxd
		.rs232_external_connection_txd  (<connected-to-rs232_external_connection_txd>)   //                          .txd
	);

