`timescale  1 ps / 1 ps

module FDSE (Q, C, CE, D, S);

    parameter INIT = 1'b1;

    output Q;

    input  C, CE, D, S;

    wire Q;
    reg q_out;

    initial q_out = INIT;
   
    assign Q = q_out;

    always @(posedge C )
	  if (S)
	     q_out <=  1;
	  else if (CE)
	     q_out <=  D;

endmodule
