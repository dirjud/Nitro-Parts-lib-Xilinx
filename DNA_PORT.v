`timescale  1 ps / 1 ps

module DNA_PORT (DOUT, CLK, DIN, READ, SHIFT);

    parameter [56:0] SIM_DNA_VALUE = 57'h0;

    output DOUT;

    input  CLK, DIN, READ, SHIFT;

    localparam MAX_DNA_BITS = 57;
    localparam MSB_DNA_BITS = MAX_DNA_BITS - 1;

    reg [MSB_DNA_BITS:0] dna_val = SIM_DNA_VALUE;
    reg dout_out;
    reg notifier;

    wire clk_in, din_in, read_in, shift_in;

    buf b_dout  (DOUT, dout_out);
    buf b_clk   (clk_in, CLK);
    buf b_din   (din_in, DIN);
    buf b_read  (read_in, READ);
    buf b_shift (shift_in, SHIFT);

    always @(posedge clk_in) begin
       if(read_in == 1'b1) begin
          dna_val = SIM_DNA_VALUE;
	  dout_out = dna_val[MSB_DNA_BITS];
       end // read_in == 1'b1
       else if(read_in == 1'b0)
               if(shift_in == 1'b1) begin
                   dna_val = {dna_val[MSB_DNA_BITS-1 : 0], din_in};
                   dout_out = dna_val[MSB_DNA_BITS];
               end  // shift_in == 1'b1
    end // always @ (posedge clk_in)
    
endmodule // DNA_PORT