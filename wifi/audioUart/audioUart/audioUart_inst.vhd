	component audioUart is
		port (
			clk_clk                        : in  std_logic                    := 'X'; -- clk
			led_external_connection_export : out std_logic_vector(7 downto 0);        -- export
			rs232_external_connection_rxd  : in  std_logic                    := 'X'; -- rxd
			rs232_external_connection_txd  : out std_logic                            -- txd
		);
	end component audioUart;

	u0 : component audioUart
		port map (
			clk_clk                        => CONNECTED_TO_clk_clk,                        --                       clk.clk
			led_external_connection_export => CONNECTED_TO_led_external_connection_export, --   led_external_connection.export
			rs232_external_connection_rxd  => CONNECTED_TO_rs232_external_connection_rxd,  -- rs232_external_connection.rxd
			rs232_external_connection_txd  => CONNECTED_TO_rs232_external_connection_txd   --                          .txd
		);

