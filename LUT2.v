
`timescale  1 ps / 1 ps


module LUT2 (O, I0, I1);

    parameter INIT = 4'h0;

    input I0, I1;

    output O;

    reg  O;
    wire [1:0] s;

    assign s = {I1, I0};

    always @(s)
       if ((s[1]^s[0] ==1) || (s[1]^s[0] ==0))
           O = INIT[s];
         else if ((INIT[0] == INIT[1]) && (INIT[2] == INIT[3]) && (INIT[0] == INIT[2])) 
           O = INIT[0];
         else if ((s[1] == 0) && (INIT[0] == INIT[1]))
           O = INIT[0];
         else if ((s[1] == 1) && (INIT[2] == INIT[3])) 
           O = INIT[2];
         else if ((s[0] == 0) && (INIT[0] == INIT[2])) 
           O = INIT[0];
         else if ((s[0] == 1) && (INIT[1] == INIT[3]))
           O = INIT[1];
         else
           O = 1'bx;
endmodule
