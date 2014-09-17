
`timescale  1 ps / 1 ps


module FDRE (Q, C, CE, D, R);

    parameter INIT = 1'b0;

    output Q;

    input  C, CE, D, R;

    wire Q;
    reg q_out;

    initial q_out = INIT;
   
    assign Q = q_out;

    always @(posedge C )
        if (R)
	     q_out <=  0;
         else if (CE)
	     q_out <=  D;

endmodule
