module vga_integrate (
    input logic clk,
    input logic rst_n,
    input logic [2:0] address,
    input logic read,
    input logic write,
    input logic [31:0] writedata,
    output logic [31:0] readdata,
    output logic [7:0] vga_red,
    output logic [7:0] vga_grn,
    output logic [7:0] vga_blu,
    output logic vga_hsync,
    output logic vga_vsync,
    output logic vga_clk
);

    // Set up signals for the VGA adapter
    logic [5:0] colour;
    logic [7:0] x_axis;
    logic [6:0] y_axis;
    logic plot_assert;
    logic [9:0] ctrl_red, ctrl_grn, ctrl_blu;
    
    // Assign signals to the VGA adapter
    assign colour = writedata[5:0];
    assign x_axis = writedata[23:16];
    assign y_axis = writedata[30:24];
    assign vga_red = ctrl_red[9:2];
    assign vga_grn = ctrl_grn[9:2];
    assign vga_blu = ctrl_blu[9:2];

    // VGA plot logic and control
    assign plot_assert = (write && (x_axis >= 8'd0) && (x_axis < 8'd160) && (y_axis >= 7'd0 && y_axis) < 7'd120) ? 1'b1 : 1'b0;
    
    // Instantiate the VGA adapter
    vga_adapter #( .RESOLUTION("160x120"), .USING_DE1("TRUE"), .BITS_PER_COLOUR_CHANNEL(2))
	vga(.resetn(rst_n), .clock(clk), .colour(colour), .x(x_axis), .y(y_axis), .plot(plot_assert), 
        .VGA_R(ctrl_red), .VGA_G(ctrl_grn), .VGA_B(ctrl_blu), .VGA_HS(vga_hsync), .VGA_VS(vga_vsync), .VGA_CLK(vga_clk));
endmodule