`timescale  1 ps / 1 ps

module MUXCY_L (LO, CI, DI, S);

    output LO;
    reg    LO;

    input  CI, DI, S;

	always @(CI or DI or S) 
	    if (S)
		LO = CI;
	    else
		LO = DI;
endmodule

