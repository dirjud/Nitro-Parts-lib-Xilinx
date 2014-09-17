
`timescale  1 ps / 1 ps


module FDR (Q, C, D, R);

    parameter INIT = 1'b0;

    output Q;

    input  C, D, R;

    wire Q;
    reg q_out;

    initial q_out = INIT;

    assign Q = q_out;

    always @(posedge C )
         if (R)
	    q_out <=  0;
         else
	    q_out <=  D;

endmodule
