`timescale  1 ps / 1 ps


module SRL16E (Q, A0, A1, A2, A3, CE, CLK, D);

    parameter INIT = 16'h0000;

    output Q;

    input  A0, A1, A2, A3, CE, CLK, D;

    reg  [15:0] data;


    assign Q = data[{A3, A2, A1, A0}];

    initial data = INIT;

    always @(posedge CLK)
    begin
	if (CE == 1'b1) begin
	    {data[15:0]} <= /* NOTE #100 */ {data[14:0], D};
	end
    end


endmodule

