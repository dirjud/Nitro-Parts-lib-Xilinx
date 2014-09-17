`timescale  1 ps / 1 ps

module FDE (Q, C, CE, D);

    parameter INIT = 1'b0;

    output Q;

    input  C, CE, D;

    wire Q;
    reg q_out;

    initial q_out = INIT;

    assign Q = q_out;


    always @(posedge C)
	    if (CE)
	       q_out <=  D;

endmodule
