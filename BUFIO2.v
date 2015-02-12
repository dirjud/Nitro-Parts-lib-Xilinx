module BUFIO2 (DIVCLK, IOCLK, SERDESSTROBE, I);
  parameter DIVIDE_BYPASS = "TRUE";    // TRUE, FALSE
  parameter integer DIVIDE = 1;        // {1..8}
  parameter I_INVERT = "FALSE";        // TRUE, FALSE
  parameter USE_DOUBLER = "FALSE";     // TRUE, FALSE


   output	    DIVCLK; 
   output 	    IOCLK; 
   output	    SERDESSTROBE; 

    input I; 

   reg [3:0] div_count;
   reg 	     div_clk;
   reg 	     serdes_strobe;
   wire [3:0] next_div_count = div_count + 1;

   /* verilator lint_off WIDTH */
   wire [3:0] divider = (USE_DOUBLER == "FALSE") ? DIVIDE*2 : DIVIDE;
   
   always @(posedge I or negedge I) begin
      if(next_div_count == divider) begin
	 div_clk <= 1;
	 serdes_strobe <= 1;
	 div_count <= 0;
      end else begin
	 serdes_strobe <= 0;
	 div_count <= next_div_count;
	 if(next_div_count == divider >> 1) begin
	    div_clk <= 0;
	 end
      end
   end // always @ (posedge I)
   assign DIVCLK = (DIVIDE == 1 || DIVIDE_BYPASS == "TRUE") ? I : div_clk;
   assign SERDESSTROBE = (DIVIDE == 1) ? 1'b0 : serdes_strobe;
   assign IOCLK = (I_INVERT == "FALSE") ? I : !I;
   /* verilator lint_on WIDTH */
   
endmodule // BUFIO2

