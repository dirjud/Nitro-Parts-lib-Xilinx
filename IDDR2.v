module IDDR2 (Q0, Q1, C0, C1, CE, D, R, S);
    
    output reg Q0;
    output reg Q1;
    
    input C0;
    input C1;
    input CE;
    input D;
    input R;
    input S;


   always @(posedge C0 or posedge R or posedge S) begin
      if(R) begin
	 Q0 <= 0;
      end else if(S) begin
	 Q0 <= 1;
      end else if(CE) begin
	 Q0 <= D;
      end
   end

   always @(posedge C1 or posedge R or posedge S) begin
      if(R) begin
	 Q1 <= 0;
      end else if(S) begin
	 Q1 <= 1;
      end else if(CE) begin
	 Q1 <= D;
      end
   end

   
endmodule 

