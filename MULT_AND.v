`timescale  1 ps / 1 ps


module MULT_AND (LO, I0, I1);

    output LO;

    input  I0, I1;

    and A1 (LO, I0, I1);

    specify
	(I0 *> LO) = (0, 0);
	(I1 *> LO) = (0, 0);
    endspecify

endmodule

