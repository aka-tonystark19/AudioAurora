	vga_system u0 (
		.clk_clk                        (<connected-to-clk_clk>),                        //                        clk.clk
		.lights_readdata                (<connected-to-lights_readdata>),                //                     lights.readdata
		.pll_0_locked_export            (<connected-to-pll_0_locked_export>),            //               pll_0_locked.export
		.pll_0_outclk1_clk              (<connected-to-pll_0_outclk1_clk>),              //              pll_0_outclk1.clk
		.reset_reset_n                  (<connected-to-reset_reset_n>),                  //                      reset.reset_n
		.sdram_addr                     (<connected-to-sdram_addr>),                     //                      sdram.addr
		.sdram_ba                       (<connected-to-sdram_ba>),                       //                           .ba
		.sdram_cas_n                    (<connected-to-sdram_cas_n>),                    //                           .cas_n
		.sdram_cke                      (<connected-to-sdram_cke>),                      //                           .cke
		.sdram_cs_n                     (<connected-to-sdram_cs_n>),                     //                           .cs_n
		.sdram_dq                       (<connected-to-sdram_dq>),                       //                           .dq
		.sdram_dqm                      (<connected-to-sdram_dqm>),                      //                           .dqm
		.sdram_ras_n                    (<connected-to-sdram_ras_n>),                    //                           .ras_n
		.sdram_we_n                     (<connected-to-sdram_we_n>),                     //                           .we_n
		.vga_vga_blu                    (<connected-to-vga_vga_blu>),                    //                        vga.vga_blu
		.vga_vga_clk                    (<connected-to-vga_vga_clk>),                    //                           .vga_clk
		.vga_vga_grn                    (<connected-to-vga_vga_grn>),                    //                           .vga_grn
		.vga_vga_hsync                  (<connected-to-vga_vga_hsync>),                  //                           .vga_hsync
		.vga_vga_red                    (<connected-to-vga_vga_red>),                    //                           .vga_red
		.vga_vga_vsync                  (<connected-to-vga_vga_vsync>),                  //                           .vga_vsync
		.rs232_0_external_interface_RXD (<connected-to-rs232_0_external_interface_RXD>), // rs232_0_external_interface.RXD
		.rs232_0_external_interface_TXD (<connected-to-rs232_0_external_interface_TXD>)  //                           .TXD
	);

