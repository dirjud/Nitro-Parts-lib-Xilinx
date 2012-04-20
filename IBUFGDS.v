module IBUFGDS (O, I, IB);

    parameter CAPACITANCE = "DONT_CARE";   
    parameter DIFF_TERM = "FALSE";
    parameter IBUF_DELAY_VALUE = "0";
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
   
    output O;
    input  I, IB;

   assign O = I;
   
endmodule
