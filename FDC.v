`timescale  1 ps / 1 ps


module FDC (Q, C, CLR, D);

    parameter INIT = 1'b0;

    output Q;

    input  C, CLR, D;

    wire Q;
    reg q_out;

    initial q_out = INIT;


    always @(posedge C or posedge CLR)
       if (CLR) 
             q_out <= 0;
       else
	         q_out <= D;

    assign Q = q_out;

endmodule
