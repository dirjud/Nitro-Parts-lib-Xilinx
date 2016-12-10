module PLL_BASE 
  (
   output CLKFBOUT,
   output CLKOUT0,
   output CLKOUT1,
   output CLKOUT2,
   output CLKOUT3,
   output CLKOUT4,
   output CLKOUT5,
   output LOCKED,
   input CLKFBIN,
   input CLKIN,
   input RST
  );

  parameter BANDWIDTH = "OPTIMIZED";
  parameter integer CLKFBOUT_MULT = 1;
  parameter real CLKFBOUT_PHASE = 0.0;
  parameter real CLKIN_PERIOD = 0.000;
  parameter integer CLKOUT0_DIVIDE = 1;
  parameter real CLKOUT0_DUTY_CYCLE = 0.5;
  parameter real CLKOUT0_PHASE = 0.0;
  parameter integer CLKOUT1_DIVIDE = 1;
  parameter real CLKOUT1_DUTY_CYCLE = 0.5;
  parameter real CLKOUT1_PHASE = 0.0;
  parameter integer CLKOUT2_DIVIDE = 1;
  parameter real CLKOUT2_DUTY_CYCLE = 0.5;
  parameter real CLKOUT2_PHASE = 0.0;
  parameter integer CLKOUT3_DIVIDE = 1;
  parameter real CLKOUT3_DUTY_CYCLE = 0.5;
  parameter real CLKOUT3_PHASE = 0.0;
  parameter integer CLKOUT4_DIVIDE = 1;
  parameter real CLKOUT4_DUTY_CYCLE = 0.5;
  parameter real CLKOUT4_PHASE = 0.0;
  parameter integer CLKOUT5_DIVIDE = 1;
  parameter real CLKOUT5_DUTY_CYCLE = 0.5;
  parameter real CLKOUT5_PHASE = 0.0;
  parameter CLK_FEEDBACK = "CLKFBOUT";
  parameter COMPENSATION = "SYSTEM_SYNCHRONOUS";
  parameter integer DIVCLK_DIVIDE = 1;
  parameter real REF_JITTER = 0.100;
  parameter RESET_ON_LOSS_OF_LOCK = "FALSE";


   PLL_sim PLL_sim
     (.input_clk(CLKIN),
      .output_clk(CLKFBOUT),
      .pll_mult(CLKFBOUT_MULT),
      .pll_div(1),
      .locked(LOCKED),
      .debug(1'b0)
      );

   PLL_DIV #(.DIVIDE(CLKOUT0_DIVIDE)) pll_div0
     (.clki(CLKFBOUT),
      .rst(RST),
      .clko(CLKOUT0));
   PLL_DIV #(.DIVIDE(CLKOUT1_DIVIDE)) pll_div1
     (.clki(CLKFBOUT),
      .rst(RST),
      .clko(CLKOUT1));
   PLL_DIV #(.DIVIDE(CLKOUT2_DIVIDE)) pll_div2
     (.clki(CLKFBOUT),
      .rst(RST),
      .clko(CLKOUT2));
   PLL_DIV #(.DIVIDE(CLKOUT3_DIVIDE)) pll_div3
     (.clki(CLKFBOUT),
      .rst(RST),
      .clko(CLKOUT3));
   PLL_DIV #(.DIVIDE(CLKOUT4_DIVIDE)) pll_div4
     (.clki(CLKFBOUT),
      .rst(RST),
      .clko(CLKOUT4));
   PLL_DIV #(.DIVIDE(CLKOUT5_DIVIDE)) pll_div5
     (.clki(CLKFBOUT),
      .rst(RST),
      .clko(CLKOUT5));

endmodule

module PLL_DIV
  #(DIVIDE=1)
   (input clki,
    input  rst,
    output clko
    );
   reg [31:0] cnt;
   wire [31:0] next_cnt = cnt + 1;

   reg 	       clkdiv;
   assign clko = (DIVIDE == 1) ? clki : clkdiv;

   always @(posedge clki or posedge rst) begin
      if(rst) begin
	 cnt <= 0;
	 clkdiv <= 0;
      end else begin
	 if(next_cnt >= DIVIDE) begin
	    clkdiv <= 0;
	    cnt <= 0;
	 end else begin
	    cnt <= cnt + 1;
	    if(next_cnt == DIVIDE/2) begin
	       clkdiv <= 1;
	    end
	 end
      end
   end

endmodule
