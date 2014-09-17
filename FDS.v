
`timescale  1 ps / 1 ps


module FDS (Q, C, D, S);

    parameter INIT = 1'b1;

    output Q;

    input  C, D, S;

    wire Q;
    reg q_out;

    initial q_out = INIT;

    assign Q = q_out;

    always @(posedge C )
         if (S)
	     q_out <=  1;
         else
	     q_out <=  D;

endmodule
