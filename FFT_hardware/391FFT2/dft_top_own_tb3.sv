module dft_top_own_tb3();
   reg clk, reset, next;
   wire next_out;
   integer i, j, k, l, m;
   reg [15:0] counter;
   reg [31:0] in [3:0];
   wire [31:0] X0;
   wire [31:0] Y0;
   wire [31:0] X1;
   wire [31:0] Y1;
   wire [31:0] X2;
   wire [31:0] Y2;
   wire [31:0] X3;
   wire [31:0] Y3;
   reg clrCnt;
   assign X0 = in[0];
   assign X1 = in[1];
   assign X2 = in[2];
   assign X3 = in[3];

   initial clk = 0;

   always #10000 clk = ~clk;


   // Instantiate top-level module of core 'X' signals are system inputs
   // and 'Y' signals are system outputs
   dft_top dft_top_instance2 (.clk(clk), .reset(reset), .next(next), .next_out(next_out),
    .X0(X0), .Y0(Y0),
    .X1(X1), .Y1(Y1),
    .X2(X2), .Y2(Y2),
    .X3(X3), .Y3(Y3));

   // You can use this counter to verify that the gap and latency are as expected.
   always @(posedge clk) begin
      if (clrCnt) counter <= 0;
      else counter <= counter+1;
   end


   initial begin
      @(posedge clk);
      @(posedge clk);

      // On the next cycle, begin loading input vector.
      next <= 1;
      clrCnt <= 1;
      @(posedge clk);
      clrCnt <= 0;
      next <= 0;

      // The 1024 complex data points enter the system over 512 cycles
      for (j=0; j < 512; j = j+1) begin
          // Input: 2 complex words per cycle
         for (k=0; k < 4; k = k+1) begin
            if(k%2 == 0)begin
					in[k] <= j; 
				end else begin
					in[k] <= 0; 
				end
         end
         @(posedge clk);
      end


      @(posedge clk);
      // Wait until the next data vector can be entered
      while (counter < 510)
        @(posedge clk);

      // On the next cycle, we will start the next data vector
      next <= 1;
      clrCnt <= 1;
      @(posedge clk);
      clrCnt <= 0;
      next <= 0;
   end


   initial begin
      // set initial values
      in[0] <= 0;
      in[1] <= 0;
      in[2] <= 0;
      in[3] <= 0;
      next <= 0;
      reset <= 0;

      @(posedge clk);
      reset <= 1;
      @(posedge clk);
      reset <= 0;
      @(posedge clk);
      @(posedge clk);
      // Wait until next_out goes high, then wait one clock cycle and begin receiving data
      @(posedge next_out);
      @(posedge clk); #1;
      $display("--- begin output 1---");

      for (m=0; m < 511; m=m+1) begin
//         $display("Y0 = %d", $signed(Y0));
//         $display("Y1 = %d", $signed(Y1));
//         $display("Y2 = %d", $signed(Y2));
//         $display("Y3 = %d", $signed(Y3));
			  $display("%d + %d i", $signed(Y0),$signed(Y1));
			  $display("%d + %d i", $signed(Y2),$signed(Y3));
         @(posedge clk); #1;
      end
		$display("%d + %d i", $signed(Y0),$signed(Y1));
		$display("%d + %d i", $signed(Y2),$signed(Y3));
//    $display("Y0 = %d", $signed(Y0));
//		$display("Y1 = %d", $signed(Y1));
//		$display("Y2 = %d", $signed(Y2));
//		$display("Y3 = %d", $signed(Y3));

      $stop;
   end
endmodule