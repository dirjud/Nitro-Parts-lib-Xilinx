
`timescale  1 ps / 1 ps


module FDP (Q, C, D, PRE);

    parameter INIT = 1'b1;

    output Q;

    input  C, D, PRE;

    wire Q;
    reg q_out;

    initial q_out = INIT;

    assign Q = q_out;

    always @(posedge C or posedge PRE)
        if (PRE)
             q_out <= 1;
        else
	         q_out <= D;

endmodule
