module ODDR2 (Q, C0, C1, CE, D0, D1, R, S);
    
   output reg Q;

   input      C0;
   input      C1;
   input      CE;
   input      D0;
   input      D1;
   input      R;
   input      S;


   always @(posedge C0 or posedge C1 or posedge R or posedge S) begin
      if(R) begin
         Q <= 0;
      end else if(S) begin
         Q <= 1;
      end else if(C0 && CE) begin
         Q <= D0;
      end else if(C1 && CE) begin
         Q <= D1;
      end
   end
   
endmodule 

