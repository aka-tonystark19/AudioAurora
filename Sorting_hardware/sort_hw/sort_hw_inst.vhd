	component sort_hw is
		port (
			clk_clk         : in  std_logic                    := 'X'; -- clk
			lights_readdata : out std_logic_vector(8 downto 0);        -- readdata
			reset_reset_n   : in  std_logic                    := 'X'  -- reset_n
		);
	end component sort_hw;

	u0 : component sort_hw
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --    clk.clk
			lights_readdata => CONNECTED_TO_lights_readdata, -- lights.readdata
			reset_reset_n   => CONNECTED_TO_reset_reset_n    --  reset.reset_n
		);

