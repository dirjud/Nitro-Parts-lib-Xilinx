module DCM_SP
  #(   parameter CLKFX_MULTIPLY = 4,
       parameter CLKFX_DIVIDE   = 1,
       parameter CLKDV_DIVIDE   = 2,
       parameter CLKIN_PERIOD   = 10,
       parameter CLK_FEEDBACK   = 0,
       parameter CLKOUT_PHASE_SHIFT = 0
       )
   (
    CLK0, CLK180, CLK270, CLK2X, CLK2X180, CLK90,
    CLKDV, CLKFX, CLKFX180, LOCKED, PSDONE, STATUS,
    CLKFB, CLKIN, DSSEN, PSCLK, PSEN, PSINCDEC, RST);
   

input CLKFB, CLKIN, DSSEN;
input PSCLK, PSEN, PSINCDEC, RST;

output CLK0, CLK180, CLK270, CLK2X, CLK2X180, CLK90;
output CLKDV, CLKFX, CLKFX180, LOCKED, PSDONE;
output [7:0] STATUS;

   assign STATUS = 0;
   
   assign CLK0 = CLKIN;
   assign CLK180 = ~CLKIN;


   assign CLK270   = ~CLK90;
   assign CLK2X180 = ~CLK2X;
   assign CLKFX180 = ~CLKFX;

`ifdef verilator

   wire resetb = ~RST;
   
   // 2x clock
   wire clk2x, lock_2x;
   PLL_sim
   dcm_2x(
      .input_clk( CLKIN ),
      .output_clk ( clk2x ),
      .pll_mult ( 2 ),
      .pll_div  ( 1 ),
      .locked ( lock_2x ),
	  .debug(0)
	  
   );
   reg clk90;
   reg [1:0] cnt;
   always @(posedge clk2x or negedge clk2x or negedge resetb) begin
      if (!resetb) begin
         clk90 <= 0;
         cnt <= 0;
      end else begin
         cnt <= cnt + 1;
         if (!cnt[0]) clk90 <= ~clk90; 
      end
   end
   assign CLK2X=clk2x;
   assign CLK90=clk90;


   // clkfx 
generate
   wire lock_fx;
   if (CLKFX_MULTIPLY==2 && CLKFX_DIVIDE==1) begin
     assign CLKFX=clk2x;
     assign lock_fx=lock_2x;
   end else begin
     PLL_sim
        #(.PLL_NAME("DCM_SP"))
     dcm_pll (
        .input_clk( CLKIN ),
        .output_clk ( CLKFX ),
        .pll_mult ( CLKFX_MULTIPLY ),
        .pll_div  ( CLKFX_DIVIDE ),
        .locked ( lock_fx ),
        .debug(0)
     );
   end
endgenerate
 
  assign LOCKED = lock_2x && lock_fx;

`else
 $error ("Unimplemented DCM_SP for non verilator sim.  Should use original Xilinx sim libs not this library." );
`endif
   
endmodule

