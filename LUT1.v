
`timescale  1 ps / 1 ps


module LUT1 (O, I0);

    parameter INIT = 2'h0;

    input I0;

    output O;
    
    wire O;

    assign O = (INIT[0] == INIT[1]) ? INIT[0] : INIT[I0];

endmodule
