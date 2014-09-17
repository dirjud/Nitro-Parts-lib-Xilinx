`timescale  1 ps / 1 ps

module MUXF5 (O, I0, I1, S);

    output O;
    reg    O;

    input  I0, I1, S;

	always @(I0 or I1 or S)
	    if (S)
		O = I1;
	    else
		O = I0;
endmodule

