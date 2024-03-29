// fft_acc.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module fft_acc (
		input  wire       clk_clk,         //    clk.clk
		output wire [8:0] lights_readdata, // lights.readdata
		input  wire       reset_reset_n    //  reset.reset_n
	);

	wire  [31:0] fft_accel_0_avalon_master_1_readdata;                        // mm_interconnect_0:fft_accel_0_avalon_master_1_readdata -> fft_accel_0:master_readdata
	wire         fft_accel_0_avalon_master_1_waitrequest;                     // mm_interconnect_0:fft_accel_0_avalon_master_1_waitrequest -> fft_accel_0:master_waitrequest
	wire  [31:0] fft_accel_0_avalon_master_1_address;                         // fft_accel_0:master_address -> mm_interconnect_0:fft_accel_0_avalon_master_1_address
	wire         fft_accel_0_avalon_master_1_read;                            // fft_accel_0:master_read -> mm_interconnect_0:fft_accel_0_avalon_master_1_read
	wire         fft_accel_0_avalon_master_1_readdatavalid;                   // mm_interconnect_0:fft_accel_0_avalon_master_1_readdatavalid -> fft_accel_0:master_readdatavalid
	wire         fft_accel_0_avalon_master_1_write;                           // fft_accel_0:master_write -> mm_interconnect_0:fft_accel_0_avalon_master_1_write
	wire  [31:0] fft_accel_0_avalon_master_1_writedata;                       // fft_accel_0:master_writedata -> mm_interconnect_0:fft_accel_0_avalon_master_1_writedata
	wire  [31:0] nios2_gen2_0_data_master_readdata;                           // mm_interconnect_0:nios2_gen2_0_data_master_readdata -> nios2_gen2_0:d_readdata
	wire         nios2_gen2_0_data_master_waitrequest;                        // mm_interconnect_0:nios2_gen2_0_data_master_waitrequest -> nios2_gen2_0:d_waitrequest
	wire         nios2_gen2_0_data_master_debugaccess;                        // nios2_gen2_0:debug_mem_slave_debugaccess_to_roms -> mm_interconnect_0:nios2_gen2_0_data_master_debugaccess
	wire  [15:0] nios2_gen2_0_data_master_address;                            // nios2_gen2_0:d_address -> mm_interconnect_0:nios2_gen2_0_data_master_address
	wire   [3:0] nios2_gen2_0_data_master_byteenable;                         // nios2_gen2_0:d_byteenable -> mm_interconnect_0:nios2_gen2_0_data_master_byteenable
	wire         nios2_gen2_0_data_master_read;                               // nios2_gen2_0:d_read -> mm_interconnect_0:nios2_gen2_0_data_master_read
	wire         nios2_gen2_0_data_master_write;                              // nios2_gen2_0:d_write -> mm_interconnect_0:nios2_gen2_0_data_master_write
	wire  [31:0] nios2_gen2_0_data_master_writedata;                          // nios2_gen2_0:d_writedata -> mm_interconnect_0:nios2_gen2_0_data_master_writedata
	wire  [31:0] fft_accel_0_avalon_master_2_readdata;                        // mm_interconnect_0:fft_accel_0_avalon_master_2_readdata -> fft_accel_0:master_readdata2
	wire         fft_accel_0_avalon_master_2_waitrequest;                     // mm_interconnect_0:fft_accel_0_avalon_master_2_waitrequest -> fft_accel_0:master_waitrequest2
	wire  [31:0] fft_accel_0_avalon_master_2_address;                         // fft_accel_0:master_address2 -> mm_interconnect_0:fft_accel_0_avalon_master_2_address
	wire         fft_accel_0_avalon_master_2_read;                            // fft_accel_0:master_read2 -> mm_interconnect_0:fft_accel_0_avalon_master_2_read
	wire         fft_accel_0_avalon_master_2_readdatavalid;                   // mm_interconnect_0:fft_accel_0_avalon_master_2_readdatavalid -> fft_accel_0:master_readdatavalid2
	wire         fft_accel_0_avalon_master_2_write;                           // fft_accel_0:master_write2 -> mm_interconnect_0:fft_accel_0_avalon_master_2_write
	wire  [31:0] fft_accel_0_avalon_master_2_writedata;                       // fft_accel_0:master_writedata2 -> mm_interconnect_0:fft_accel_0_avalon_master_2_writedata
	wire  [31:0] nios2_gen2_0_instruction_master_readdata;                    // mm_interconnect_0:nios2_gen2_0_instruction_master_readdata -> nios2_gen2_0:i_readdata
	wire         nios2_gen2_0_instruction_master_waitrequest;                 // mm_interconnect_0:nios2_gen2_0_instruction_master_waitrequest -> nios2_gen2_0:i_waitrequest
	wire  [15:0] nios2_gen2_0_instruction_master_address;                     // nios2_gen2_0:i_address -> mm_interconnect_0:nios2_gen2_0_instruction_master_address
	wire         nios2_gen2_0_instruction_master_read;                        // nios2_gen2_0:i_read -> mm_interconnect_0:nios2_gen2_0_instruction_master_read
	wire         mm_interconnect_0_ram_1_s1_chipselect;                       // mm_interconnect_0:ram_1_s1_chipselect -> ram_1:chipselect
	wire  [31:0] mm_interconnect_0_ram_1_s1_readdata;                         // ram_1:readdata -> mm_interconnect_0:ram_1_s1_readdata
	wire   [9:0] mm_interconnect_0_ram_1_s1_address;                          // mm_interconnect_0:ram_1_s1_address -> ram_1:address
	wire   [3:0] mm_interconnect_0_ram_1_s1_byteenable;                       // mm_interconnect_0:ram_1_s1_byteenable -> ram_1:byteenable
	wire         mm_interconnect_0_ram_1_s1_write;                            // mm_interconnect_0:ram_1_s1_write -> ram_1:write
	wire  [31:0] mm_interconnect_0_ram_1_s1_writedata;                        // mm_interconnect_0:ram_1_s1_writedata -> ram_1:writedata
	wire         mm_interconnect_0_ram_1_s1_clken;                            // mm_interconnect_0:ram_1_s1_clken -> ram_1:clken
	wire         mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect;  // mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_chipselect -> jtag_uart_0:av_chipselect
	wire  [31:0] mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata;    // jtag_uart_0:av_readdata -> mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_readdata
	wire         mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest; // jtag_uart_0:av_waitrequest -> mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_waitrequest
	wire   [0:0] mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address;     // mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_address -> jtag_uart_0:av_address
	wire         mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read;        // mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_read -> jtag_uart_0:av_read_n
	wire         mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write;       // mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_write -> jtag_uart_0:av_write_n
	wire  [31:0] mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata;   // mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_writedata -> jtag_uart_0:av_writedata
	wire  [31:0] mm_interconnect_0_fft_accel_0_avalon_slave_readdata;         // fft_accel_0:slave_readdata -> mm_interconnect_0:fft_accel_0_avalon_slave_readdata
	wire         mm_interconnect_0_fft_accel_0_avalon_slave_waitrequest;      // fft_accel_0:slave_waitrequest -> mm_interconnect_0:fft_accel_0_avalon_slave_waitrequest
	wire   [3:0] mm_interconnect_0_fft_accel_0_avalon_slave_address;          // mm_interconnect_0:fft_accel_0_avalon_slave_address -> fft_accel_0:slave_address
	wire         mm_interconnect_0_fft_accel_0_avalon_slave_read;             // mm_interconnect_0:fft_accel_0_avalon_slave_read -> fft_accel_0:slave_read
	wire         mm_interconnect_0_fft_accel_0_avalon_slave_write;            // mm_interconnect_0:fft_accel_0_avalon_slave_write -> fft_accel_0:slave_write
	wire  [31:0] mm_interconnect_0_fft_accel_0_avalon_slave_writedata;        // mm_interconnect_0:fft_accel_0_avalon_slave_writedata -> fft_accel_0:slave_writedata
	wire  [31:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata;     // nios2_gen2_0:debug_mem_slave_readdata -> mm_interconnect_0:nios2_gen2_0_debug_mem_slave_readdata
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest;  // nios2_gen2_0:debug_mem_slave_waitrequest -> mm_interconnect_0:nios2_gen2_0_debug_mem_slave_waitrequest
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess;  // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_debugaccess -> nios2_gen2_0:debug_mem_slave_debugaccess
	wire   [8:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address;      // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_address -> nios2_gen2_0:debug_mem_slave_address
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read;         // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_read -> nios2_gen2_0:debug_mem_slave_read
	wire   [3:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable;   // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_byteenable -> nios2_gen2_0:debug_mem_slave_byteenable
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write;        // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_write -> nios2_gen2_0:debug_mem_slave_write
	wire  [31:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata;    // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_writedata -> nios2_gen2_0:debug_mem_slave_writedata
	wire         mm_interconnect_0_ram_instr_s1_chipselect;                   // mm_interconnect_0:ram_instr_s1_chipselect -> ram_instr:chipselect
	wire  [31:0] mm_interconnect_0_ram_instr_s1_readdata;                     // ram_instr:readdata -> mm_interconnect_0:ram_instr_s1_readdata
	wire  [12:0] mm_interconnect_0_ram_instr_s1_address;                      // mm_interconnect_0:ram_instr_s1_address -> ram_instr:address
	wire   [3:0] mm_interconnect_0_ram_instr_s1_byteenable;                   // mm_interconnect_0:ram_instr_s1_byteenable -> ram_instr:byteenable
	wire         mm_interconnect_0_ram_instr_s1_write;                        // mm_interconnect_0:ram_instr_s1_write -> ram_instr:write
	wire  [31:0] mm_interconnect_0_ram_instr_s1_writedata;                    // mm_interconnect_0:ram_instr_s1_writedata -> ram_instr:writedata
	wire         mm_interconnect_0_ram_instr_s1_clken;                        // mm_interconnect_0:ram_instr_s1_clken -> ram_instr:clken
	wire         mm_interconnect_0_ram_2_s1_chipselect;                       // mm_interconnect_0:ram_2_s1_chipselect -> ram_2:chipselect
	wire  [31:0] mm_interconnect_0_ram_2_s1_readdata;                         // ram_2:readdata -> mm_interconnect_0:ram_2_s1_readdata
	wire   [9:0] mm_interconnect_0_ram_2_s1_address;                          // mm_interconnect_0:ram_2_s1_address -> ram_2:address
	wire   [3:0] mm_interconnect_0_ram_2_s1_byteenable;                       // mm_interconnect_0:ram_2_s1_byteenable -> ram_2:byteenable
	wire         mm_interconnect_0_ram_2_s1_write;                            // mm_interconnect_0:ram_2_s1_write -> ram_2:write
	wire  [31:0] mm_interconnect_0_ram_2_s1_writedata;                        // mm_interconnect_0:ram_2_s1_writedata -> ram_2:writedata
	wire         mm_interconnect_0_ram_2_s1_clken;                            // mm_interconnect_0:ram_2_s1_clken -> ram_2:clken
	wire         irq_mapper_receiver0_irq;                                    // jtag_uart_0:av_irq -> irq_mapper:receiver0_irq
	wire  [31:0] nios2_gen2_0_irq_irq;                                        // irq_mapper:sender_irq -> nios2_gen2_0:irq
	wire         rst_controller_reset_out_reset;                              // rst_controller:reset_out -> [fft_accel_0:rst_n, irq_mapper:reset, jtag_uart_0:rst_n, mm_interconnect_0:fft_accel_0_reset_sink_reset_bridge_in_reset_reset, nios2_gen2_0:reset_n, ram_1:reset, ram_2:reset, ram_instr:reset, rst_translator:in_reset]
	wire         rst_controller_reset_out_reset_req;                          // rst_controller:reset_req -> [nios2_gen2_0:reset_req, ram_1:reset_req, ram_2:reset_req, ram_instr:reset_req, rst_translator:reset_req_in]
	wire         nios2_gen2_0_debug_reset_request_reset;                      // nios2_gen2_0:debug_reset_request -> rst_controller:reset_in1

	fft_wrapper fft_accel_0 (
		.clk                   (clk_clk),                                                //           clock.clk
		.rst_n                 (~rst_controller_reset_out_reset),                        //      reset_sink.reset_n
		.slave_waitrequest     (mm_interconnect_0_fft_accel_0_avalon_slave_waitrequest), //    avalon_slave.waitrequest
		.slave_address         (mm_interconnect_0_fft_accel_0_avalon_slave_address),     //                .address
		.slave_read            (mm_interconnect_0_fft_accel_0_avalon_slave_read),        //                .read
		.slave_readdata        (mm_interconnect_0_fft_accel_0_avalon_slave_readdata),    //                .readdata
		.slave_write           (mm_interconnect_0_fft_accel_0_avalon_slave_write),       //                .write
		.slave_writedata       (mm_interconnect_0_fft_accel_0_avalon_slave_writedata),   //                .writedata
		.master_address2       (fft_accel_0_avalon_master_2_address),                    // avalon_master_2.address
		.master_read2          (fft_accel_0_avalon_master_2_read),                       //                .read
		.master_readdata2      (fft_accel_0_avalon_master_2_readdata),                   //                .readdata
		.master_readdatavalid2 (fft_accel_0_avalon_master_2_readdatavalid),              //                .readdatavalid
		.master_waitrequest2   (fft_accel_0_avalon_master_2_waitrequest),                //                .waitrequest
		.master_write2         (fft_accel_0_avalon_master_2_write),                      //                .write
		.master_writedata2     (fft_accel_0_avalon_master_2_writedata),                  //                .writedata
		.master_address        (fft_accel_0_avalon_master_1_address),                    // avalon_master_1.address
		.master_read           (fft_accel_0_avalon_master_1_read),                       //                .read
		.master_readdata       (fft_accel_0_avalon_master_1_readdata),                   //                .readdata
		.master_readdatavalid  (fft_accel_0_avalon_master_1_readdatavalid),              //                .readdatavalid
		.master_waitrequest    (fft_accel_0_avalon_master_1_waitrequest),                //                .waitrequest
		.master_write          (fft_accel_0_avalon_master_1_write),                      //                .write
		.master_writedata      (fft_accel_0_avalon_master_1_writedata),                  //                .writedata
		.LEDR                  (lights_readdata)                                         //     conduit_end.readdata
	);

	fft_acc_jtag_uart_0 jtag_uart_0 (
		.clk            (clk_clk),                                                     //               clk.clk
		.rst_n          (~rst_controller_reset_out_reset),                             //             reset.reset_n
		.av_chipselect  (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect),  // avalon_jtag_slave.chipselect
		.av_address     (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address),     //                  .address
		.av_read_n      (~mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read),       //                  .read_n
		.av_readdata    (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata),    //                  .readdata
		.av_write_n     (~mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write),      //                  .write_n
		.av_writedata   (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata),   //                  .writedata
		.av_waitrequest (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest), //                  .waitrequest
		.av_irq         (irq_mapper_receiver0_irq)                                     //               irq.irq
	);

	fft_acc_nios2_gen2_0 nios2_gen2_0 (
		.clk                                 (clk_clk),                                                    //                       clk.clk
		.reset_n                             (~rst_controller_reset_out_reset),                            //                     reset.reset_n
		.reset_req                           (rst_controller_reset_out_reset_req),                         //                          .reset_req
		.d_address                           (nios2_gen2_0_data_master_address),                           //               data_master.address
		.d_byteenable                        (nios2_gen2_0_data_master_byteenable),                        //                          .byteenable
		.d_read                              (nios2_gen2_0_data_master_read),                              //                          .read
		.d_readdata                          (nios2_gen2_0_data_master_readdata),                          //                          .readdata
		.d_waitrequest                       (nios2_gen2_0_data_master_waitrequest),                       //                          .waitrequest
		.d_write                             (nios2_gen2_0_data_master_write),                             //                          .write
		.d_writedata                         (nios2_gen2_0_data_master_writedata),                         //                          .writedata
		.debug_mem_slave_debugaccess_to_roms (nios2_gen2_0_data_master_debugaccess),                       //                          .debugaccess
		.i_address                           (nios2_gen2_0_instruction_master_address),                    //        instruction_master.address
		.i_read                              (nios2_gen2_0_instruction_master_read),                       //                          .read
		.i_readdata                          (nios2_gen2_0_instruction_master_readdata),                   //                          .readdata
		.i_waitrequest                       (nios2_gen2_0_instruction_master_waitrequest),                //                          .waitrequest
		.irq                                 (nios2_gen2_0_irq_irq),                                       //                       irq.irq
		.debug_reset_request                 (nios2_gen2_0_debug_reset_request_reset),                     //       debug_reset_request.reset
		.debug_mem_slave_address             (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address),     //           debug_mem_slave.address
		.debug_mem_slave_byteenable          (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable),  //                          .byteenable
		.debug_mem_slave_debugaccess         (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess), //                          .debugaccess
		.debug_mem_slave_read                (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read),        //                          .read
		.debug_mem_slave_readdata            (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata),    //                          .readdata
		.debug_mem_slave_waitrequest         (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest), //                          .waitrequest
		.debug_mem_slave_write               (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write),       //                          .write
		.debug_mem_slave_writedata           (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata),   //                          .writedata
		.dummy_ci_port                       ()                                                            // custom_instruction_master.readra
	);

	fft_acc_ram_1 ram_1 (
		.clk        (clk_clk),                               //   clk1.clk
		.address    (mm_interconnect_0_ram_1_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_ram_1_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_ram_1_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_ram_1_s1_write),      //       .write
		.readdata   (mm_interconnect_0_ram_1_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_ram_1_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_ram_1_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),        // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req),    //       .reset_req
		.freeze     (1'b0)                                   // (terminated)
	);

	fft_acc_ram_2 ram_2 (
		.clk        (clk_clk),                               //   clk1.clk
		.address    (mm_interconnect_0_ram_2_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_ram_2_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_ram_2_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_ram_2_s1_write),      //       .write
		.readdata   (mm_interconnect_0_ram_2_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_ram_2_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_ram_2_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),        // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req),    //       .reset_req
		.freeze     (1'b0)                                   // (terminated)
	);

	fft_acc_ram_instr ram_instr (
		.clk        (clk_clk),                                   //   clk1.clk
		.address    (mm_interconnect_0_ram_instr_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_ram_instr_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_ram_instr_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_ram_instr_s1_write),      //       .write
		.readdata   (mm_interconnect_0_ram_instr_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_ram_instr_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_ram_instr_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),            // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req),        //       .reset_req
		.freeze     (1'b0)                                       // (terminated)
	);

	fft_acc_mm_interconnect_0 mm_interconnect_0 (
		.clk_0_clk_clk                                      (clk_clk),                                                     //                                    clk_0_clk.clk
		.fft_accel_0_reset_sink_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                              // fft_accel_0_reset_sink_reset_bridge_in_reset.reset
		.fft_accel_0_avalon_master_1_address                (fft_accel_0_avalon_master_1_address),                         //                  fft_accel_0_avalon_master_1.address
		.fft_accel_0_avalon_master_1_waitrequest            (fft_accel_0_avalon_master_1_waitrequest),                     //                                             .waitrequest
		.fft_accel_0_avalon_master_1_read                   (fft_accel_0_avalon_master_1_read),                            //                                             .read
		.fft_accel_0_avalon_master_1_readdata               (fft_accel_0_avalon_master_1_readdata),                        //                                             .readdata
		.fft_accel_0_avalon_master_1_readdatavalid          (fft_accel_0_avalon_master_1_readdatavalid),                   //                                             .readdatavalid
		.fft_accel_0_avalon_master_1_write                  (fft_accel_0_avalon_master_1_write),                           //                                             .write
		.fft_accel_0_avalon_master_1_writedata              (fft_accel_0_avalon_master_1_writedata),                       //                                             .writedata
		.fft_accel_0_avalon_master_2_address                (fft_accel_0_avalon_master_2_address),                         //                  fft_accel_0_avalon_master_2.address
		.fft_accel_0_avalon_master_2_waitrequest            (fft_accel_0_avalon_master_2_waitrequest),                     //                                             .waitrequest
		.fft_accel_0_avalon_master_2_read                   (fft_accel_0_avalon_master_2_read),                            //                                             .read
		.fft_accel_0_avalon_master_2_readdata               (fft_accel_0_avalon_master_2_readdata),                        //                                             .readdata
		.fft_accel_0_avalon_master_2_readdatavalid          (fft_accel_0_avalon_master_2_readdatavalid),                   //                                             .readdatavalid
		.fft_accel_0_avalon_master_2_write                  (fft_accel_0_avalon_master_2_write),                           //                                             .write
		.fft_accel_0_avalon_master_2_writedata              (fft_accel_0_avalon_master_2_writedata),                       //                                             .writedata
		.nios2_gen2_0_data_master_address                   (nios2_gen2_0_data_master_address),                            //                     nios2_gen2_0_data_master.address
		.nios2_gen2_0_data_master_waitrequest               (nios2_gen2_0_data_master_waitrequest),                        //                                             .waitrequest
		.nios2_gen2_0_data_master_byteenable                (nios2_gen2_0_data_master_byteenable),                         //                                             .byteenable
		.nios2_gen2_0_data_master_read                      (nios2_gen2_0_data_master_read),                               //                                             .read
		.nios2_gen2_0_data_master_readdata                  (nios2_gen2_0_data_master_readdata),                           //                                             .readdata
		.nios2_gen2_0_data_master_write                     (nios2_gen2_0_data_master_write),                              //                                             .write
		.nios2_gen2_0_data_master_writedata                 (nios2_gen2_0_data_master_writedata),                          //                                             .writedata
		.nios2_gen2_0_data_master_debugaccess               (nios2_gen2_0_data_master_debugaccess),                        //                                             .debugaccess
		.nios2_gen2_0_instruction_master_address            (nios2_gen2_0_instruction_master_address),                     //              nios2_gen2_0_instruction_master.address
		.nios2_gen2_0_instruction_master_waitrequest        (nios2_gen2_0_instruction_master_waitrequest),                 //                                             .waitrequest
		.nios2_gen2_0_instruction_master_read               (nios2_gen2_0_instruction_master_read),                        //                                             .read
		.nios2_gen2_0_instruction_master_readdata           (nios2_gen2_0_instruction_master_readdata),                    //                                             .readdata
		.fft_accel_0_avalon_slave_address                   (mm_interconnect_0_fft_accel_0_avalon_slave_address),          //                     fft_accel_0_avalon_slave.address
		.fft_accel_0_avalon_slave_write                     (mm_interconnect_0_fft_accel_0_avalon_slave_write),            //                                             .write
		.fft_accel_0_avalon_slave_read                      (mm_interconnect_0_fft_accel_0_avalon_slave_read),             //                                             .read
		.fft_accel_0_avalon_slave_readdata                  (mm_interconnect_0_fft_accel_0_avalon_slave_readdata),         //                                             .readdata
		.fft_accel_0_avalon_slave_writedata                 (mm_interconnect_0_fft_accel_0_avalon_slave_writedata),        //                                             .writedata
		.fft_accel_0_avalon_slave_waitrequest               (mm_interconnect_0_fft_accel_0_avalon_slave_waitrequest),      //                                             .waitrequest
		.jtag_uart_0_avalon_jtag_slave_address              (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address),     //                jtag_uart_0_avalon_jtag_slave.address
		.jtag_uart_0_avalon_jtag_slave_write                (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write),       //                                             .write
		.jtag_uart_0_avalon_jtag_slave_read                 (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read),        //                                             .read
		.jtag_uart_0_avalon_jtag_slave_readdata             (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata),    //                                             .readdata
		.jtag_uart_0_avalon_jtag_slave_writedata            (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata),   //                                             .writedata
		.jtag_uart_0_avalon_jtag_slave_waitrequest          (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest), //                                             .waitrequest
		.jtag_uart_0_avalon_jtag_slave_chipselect           (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect),  //                                             .chipselect
		.nios2_gen2_0_debug_mem_slave_address               (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address),      //                 nios2_gen2_0_debug_mem_slave.address
		.nios2_gen2_0_debug_mem_slave_write                 (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write),        //                                             .write
		.nios2_gen2_0_debug_mem_slave_read                  (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read),         //                                             .read
		.nios2_gen2_0_debug_mem_slave_readdata              (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata),     //                                             .readdata
		.nios2_gen2_0_debug_mem_slave_writedata             (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata),    //                                             .writedata
		.nios2_gen2_0_debug_mem_slave_byteenable            (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable),   //                                             .byteenable
		.nios2_gen2_0_debug_mem_slave_waitrequest           (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest),  //                                             .waitrequest
		.nios2_gen2_0_debug_mem_slave_debugaccess           (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess),  //                                             .debugaccess
		.ram_1_s1_address                                   (mm_interconnect_0_ram_1_s1_address),                          //                                     ram_1_s1.address
		.ram_1_s1_write                                     (mm_interconnect_0_ram_1_s1_write),                            //                                             .write
		.ram_1_s1_readdata                                  (mm_interconnect_0_ram_1_s1_readdata),                         //                                             .readdata
		.ram_1_s1_writedata                                 (mm_interconnect_0_ram_1_s1_writedata),                        //                                             .writedata
		.ram_1_s1_byteenable                                (mm_interconnect_0_ram_1_s1_byteenable),                       //                                             .byteenable
		.ram_1_s1_chipselect                                (mm_interconnect_0_ram_1_s1_chipselect),                       //                                             .chipselect
		.ram_1_s1_clken                                     (mm_interconnect_0_ram_1_s1_clken),                            //                                             .clken
		.ram_2_s1_address                                   (mm_interconnect_0_ram_2_s1_address),                          //                                     ram_2_s1.address
		.ram_2_s1_write                                     (mm_interconnect_0_ram_2_s1_write),                            //                                             .write
		.ram_2_s1_readdata                                  (mm_interconnect_0_ram_2_s1_readdata),                         //                                             .readdata
		.ram_2_s1_writedata                                 (mm_interconnect_0_ram_2_s1_writedata),                        //                                             .writedata
		.ram_2_s1_byteenable                                (mm_interconnect_0_ram_2_s1_byteenable),                       //                                             .byteenable
		.ram_2_s1_chipselect                                (mm_interconnect_0_ram_2_s1_chipselect),                       //                                             .chipselect
		.ram_2_s1_clken                                     (mm_interconnect_0_ram_2_s1_clken),                            //                                             .clken
		.ram_instr_s1_address                               (mm_interconnect_0_ram_instr_s1_address),                      //                                 ram_instr_s1.address
		.ram_instr_s1_write                                 (mm_interconnect_0_ram_instr_s1_write),                        //                                             .write
		.ram_instr_s1_readdata                              (mm_interconnect_0_ram_instr_s1_readdata),                     //                                             .readdata
		.ram_instr_s1_writedata                             (mm_interconnect_0_ram_instr_s1_writedata),                    //                                             .writedata
		.ram_instr_s1_byteenable                            (mm_interconnect_0_ram_instr_s1_byteenable),                   //                                             .byteenable
		.ram_instr_s1_chipselect                            (mm_interconnect_0_ram_instr_s1_chipselect),                   //                                             .chipselect
		.ram_instr_s1_clken                                 (mm_interconnect_0_ram_instr_s1_clken)                         //                                             .clken
	);

	fft_acc_irq_mapper irq_mapper (
		.clk           (clk_clk),                        //       clk.clk
		.reset         (rst_controller_reset_out_reset), // clk_reset.reset
		.receiver0_irq (irq_mapper_receiver0_irq),       // receiver0.irq
		.sender_irq    (nios2_gen2_0_irq_irq)            //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (2),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                         // reset_in0.reset
		.reset_in1      (nios2_gen2_0_debug_reset_request_reset), // reset_in1.reset
		.clk            (clk_clk),                                //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),         // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req),     //          .reset_req
		.reset_req_in0  (1'b0),                                   // (terminated)
		.reset_req_in1  (1'b0),                                   // (terminated)
		.reset_in2      (1'b0),                                   // (terminated)
		.reset_req_in2  (1'b0),                                   // (terminated)
		.reset_in3      (1'b0),                                   // (terminated)
		.reset_req_in3  (1'b0),                                   // (terminated)
		.reset_in4      (1'b0),                                   // (terminated)
		.reset_req_in4  (1'b0),                                   // (terminated)
		.reset_in5      (1'b0),                                   // (terminated)
		.reset_req_in5  (1'b0),                                   // (terminated)
		.reset_in6      (1'b0),                                   // (terminated)
		.reset_req_in6  (1'b0),                                   // (terminated)
		.reset_in7      (1'b0),                                   // (terminated)
		.reset_req_in7  (1'b0),                                   // (terminated)
		.reset_in8      (1'b0),                                   // (terminated)
		.reset_req_in8  (1'b0),                                   // (terminated)
		.reset_in9      (1'b0),                                   // (terminated)
		.reset_req_in9  (1'b0),                                   // (terminated)
		.reset_in10     (1'b0),                                   // (terminated)
		.reset_req_in10 (1'b0),                                   // (terminated)
		.reset_in11     (1'b0),                                   // (terminated)
		.reset_req_in11 (1'b0),                                   // (terminated)
		.reset_in12     (1'b0),                                   // (terminated)
		.reset_req_in12 (1'b0),                                   // (terminated)
		.reset_in13     (1'b0),                                   // (terminated)
		.reset_req_in13 (1'b0),                                   // (terminated)
		.reset_in14     (1'b0),                                   // (terminated)
		.reset_req_in14 (1'b0),                                   // (terminated)
		.reset_in15     (1'b0),                                   // (terminated)
		.reset_req_in15 (1'b0)                                    // (terminated)
	);

endmodule
