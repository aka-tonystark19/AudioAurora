	component vga_system is
		port (
			clk_clk             : in    std_logic                     := 'X';             -- clk
			lights_readdata     : out   std_logic_vector(8 downto 0);                     -- readdata
			pll_0_locked_export : out   std_logic;                                        -- export
			pll_0_outclk1_clk   : out   std_logic;                                        -- clk
			reset_reset_n       : in    std_logic                     := 'X';             -- reset_n
			sdram_addr          : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_ba            : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_cas_n         : out   std_logic;                                        -- cas_n
			sdram_cke           : out   std_logic;                                        -- cke
			sdram_cs_n          : out   std_logic;                                        -- cs_n
			sdram_dq            : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_dqm           : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_ras_n         : out   std_logic;                                        -- ras_n
			sdram_we_n          : out   std_logic;                                        -- we_n
			vga_vga_blu         : out   std_logic_vector(7 downto 0);                     -- vga_blu
			vga_vga_clk         : out   std_logic;                                        -- vga_clk
			vga_vga_grn         : out   std_logic_vector(7 downto 0);                     -- vga_grn
			vga_vga_hsync       : out   std_logic;                                        -- vga_hsync
			vga_vga_red         : out   std_logic_vector(7 downto 0);                     -- vga_red
			vga_vga_vsync       : out   std_logic                                         -- vga_vsync
		);
	end component vga_system;

	u0 : component vga_system
		port map (
			clk_clk             => CONNECTED_TO_clk_clk,             --           clk.clk
			lights_readdata     => CONNECTED_TO_lights_readdata,     --        lights.readdata
			pll_0_locked_export => CONNECTED_TO_pll_0_locked_export, --  pll_0_locked.export
			pll_0_outclk1_clk   => CONNECTED_TO_pll_0_outclk1_clk,   -- pll_0_outclk1.clk
			reset_reset_n       => CONNECTED_TO_reset_reset_n,       --         reset.reset_n
			sdram_addr          => CONNECTED_TO_sdram_addr,          --         sdram.addr
			sdram_ba            => CONNECTED_TO_sdram_ba,            --              .ba
			sdram_cas_n         => CONNECTED_TO_sdram_cas_n,         --              .cas_n
			sdram_cke           => CONNECTED_TO_sdram_cke,           --              .cke
			sdram_cs_n          => CONNECTED_TO_sdram_cs_n,          --              .cs_n
			sdram_dq            => CONNECTED_TO_sdram_dq,            --              .dq
			sdram_dqm           => CONNECTED_TO_sdram_dqm,           --              .dqm
			sdram_ras_n         => CONNECTED_TO_sdram_ras_n,         --              .ras_n
			sdram_we_n          => CONNECTED_TO_sdram_we_n,          --              .we_n
			vga_vga_blu         => CONNECTED_TO_vga_vga_blu,         --           vga.vga_blu
			vga_vga_clk         => CONNECTED_TO_vga_vga_clk,         --              .vga_clk
			vga_vga_grn         => CONNECTED_TO_vga_vga_grn,         --              .vga_grn
			vga_vga_hsync       => CONNECTED_TO_vga_vga_hsync,       --              .vga_hsync
			vga_vga_red         => CONNECTED_TO_vga_vga_red,         --              .vga_red
			vga_vga_vsync       => CONNECTED_TO_vga_vga_vsync        --              .vga_vsync
		);

