module OBUFDS (O, OB, I);

    parameter CAPACITANCE = "DONT_CARE";
    parameter IOSTANDARD = "DEFAULT";
    parameter SLEW = "SLOW";

    output O, OB;

    input  I;
   assign O=I;
   assign OB =!I;

endmodule
