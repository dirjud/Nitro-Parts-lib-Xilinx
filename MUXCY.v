`timescale  1 ps / 1 ps


module MUXCY (O, CI, DI, S);

    output O;
    reg    O;

    input  CI, DI, S;

	always @(CI or DI or S) 
	    if (S)
		O = CI;
	    else
		O = DI;

endmodule

