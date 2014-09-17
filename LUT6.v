`timescale  1 ps / 1 ps


module LUT6 (O, I0, I1, I2, I3, I4, I5);

  parameter INIT = 64'h0000000000000000;

  input I0, I1, I2, I3, I4, I5;

  output O;

  reg O;
  reg tmp;

  always @( I5 or I4 or I3 or  I2 or  I1 or  I0 )  begin
 
    tmp =  I0 ^ I1  ^ I2 ^ I3 ^ I4 ^ I5;

    if ( tmp == 0 || tmp == 1)

        O = INIT[{I5, I4, I3, I2, I1, I0}];

    else 
    
      O =  lut6_mux8 ( {lut6_mux8 ( INIT[63:56], {I2, I1, I0}),
                          lut6_mux8 ( INIT[55:48], {I2, I1, I0}),
                          lut6_mux8 ( INIT[47:40], {I2, I1, I0}),
                          lut6_mux8 ( INIT[39:32], {I2, I1, I0}),
                          lut6_mux8 ( INIT[31:24], {I2, I1, I0}),
                          lut6_mux8 ( INIT[23:16], {I2, I1, I0}),
                          lut6_mux8 ( INIT[15:8], {I2, I1, I0}),
                          lut6_mux8 ( INIT[7:0], {I2, I1, I0}) }, {I5, I4, I3});
  end

  function lut6_mux8;
  input [7:0] d;
  input [2:0] s;
   
  begin

   if ((s[2]^s[1]^s[0] ==1) || (s[2]^s[1]^s[0] ==0))
           
       lut6_mux8 = d[s];

     else
       if ( ~(|d))
             lut6_mux8 = 1'b0;
       else if ((&d))
             lut6_mux8 = 1'b1;
       else if (((s[1]^s[0] ==1'b1) || (s[1]^s[0] ==1'b0)) && (d[{1'b0,s[1:0]}]==d[{1'b1,s[1:0]}]))
             lut6_mux8 = d[{1'b0,s[1:0]}];
       else if (((s[2]^s[0] ==1) || (s[2]^s[0] ==0)) && (d[{s[2],1'b0,s[0]}]==d[{s[2],1'b1,s[0]}]))
             lut6_mux8 = d[{s[2],1'b0,s[0]}];
       else if (((s[2]^s[1] ==1) || (s[2]^s[1] ==0)) && (d[{s[2],s[1],1'b0}]==d[{s[2],s[1],1'b1}]))
             lut6_mux8 = d[{s[2],s[1],1'b0}];
       else if (((s[0] ==1) || (s[0] ==0)) && (d[{1'b0,1'b0,s[0]}]==d[{1'b0,1'b1,s[0]}]) &&
          (d[{1'b0,1'b0,s[0]}]==d[{1'b1,1'b0,s[0]}]) && (d[{1'b0,1'b0,s[0]}]==d[{1'b1,1'b1,s[0]}]))
             lut6_mux8 = d[{1'b0,1'b0,s[0]}];
       else if (((s[1] ==1) || (s[1] ==0)) && (d[{1'b0,s[1],1'b0}]==d[{1'b0,s[1],1'b1}]) &&
          (d[{1'b0,s[1],1'b0}]==d[{1'b1,s[1],1'b0}]) && (d[{1'b0,s[1],1'b0}]==d[{1'b1,s[1],1'b1}]))
             lut6_mux8 = d[{1'b0,s[1],1'b0}];
       else if (((s[2] ==1) || (s[2] ==0)) && (d[{s[2],1'b0,1'b0}]==d[{s[2],1'b0,1'b1}]) &&
          (d[{s[2],1'b0,1'b0}]==d[{s[2],1'b1,1'b0}]) && (d[{s[2],1'b0,1'b0}]==d[{s[2],1'b1,1'b1}]))
             lut6_mux8 = d[{s[2],1'b0,1'b0}];
       else
             lut6_mux8 = 1'bx;
   end
  endfunction

endmodule
