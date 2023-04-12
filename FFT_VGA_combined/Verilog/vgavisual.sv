module vgavisual (
    input logic CLOCK_50,
    input logic [3:0] KEY, // KEY[3] is async active-low reset
    input logic [9:0] SW,
    output logic [9:0] LEDR,
    output logic [7:0] VGA_R,
    output logic [7:0] VGA_G,
    output logic [7:0] VGA_B,
    output logic VGA_HS,
    output logic VGA_VS,
    output logic VGA_CLK,
    output logic DRAM_CLK,
    output logic DRAM_CKE,
    output logic DRAM_CAS_N,
    output logic DRAM_RAS_N,
    output logic DRAM_WE_N,
    output logic [12:0] DRAM_ADDR,
    output logic [1:0] DRAM_BA,
    output logic DRAM_CS_N,
    inout logic [15:0] DRAM_DQ,
    output logic DRAM_UDQM,
    output logic DRAM_LDQM,
    input logic [35:0] GPIO_1,
    output logic [35:0] GPIO_0
);

	vga_system u0 (
		.clk_clk             (CLOCK_50),                //           clk.clk
		.reset_reset_n       (KEY[3]),                  //         reset.reset_n
		.pll_0_outclk1_clk   (DRAM_CLK),                // pll_0_outclk1.clk
		.pll_0_locked_export (LEDR[0]),                 //  pll_0_locked.export
		.sdram_addr          (DRAM_ADDR),               //         sdram.addr
		.sdram_ba            (DRAM_BA),                 //              .ba
		.sdram_cas_n         (DRAM_CAS_N),              //              .cas_n
		.sdram_cke           (DRAM_CKE),                //              .cke
		.sdram_cs_n          (DRAM_CS_N),               //              .cs_n
		.sdram_dq            (DRAM_DQ),                 //              .dq
		.sdram_dqm           ({DRAM_UDQM, DRAM_LDQM}),  //              .dqm
		.sdram_ras_n         (DRAM_RAS_N),              //              .ras_n
		.sdram_we_n          (DRAM_WE_N),               //              .we_n
		.vga_vga_blu         (VGA_B),                   //           vga.vga_blu
		.vga_vga_clk         (VGA_CLK),                 //              .vga_clk
		.vga_vga_grn         (VGA_G),                   //              .vga_grn
		.vga_vga_hsync       (VGA_HS),                  //              .vga_hsync
		.vga_vga_red         (VGA_R),                   //              .vga_red
		.vga_vga_vsync       (VGA_VS),                  //              .vga_vsync
        .lights_readdata     (LEDR[9:1]),               //        lights.readdata
        .rs232_0_external_interface_RXD (GPIO_1[35]),   // rs232_0_external_interface.RXD
		.rs232_0_external_interface_TXD (GPIO_0[35])    //  
	);


endmodule