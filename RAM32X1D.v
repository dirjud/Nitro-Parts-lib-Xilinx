`timescale  1 ps / 1 ps

module RAM32X1D (DPO, SPO, A0, A1, A2, A3, A4, D, DPRA0, DPRA1, DPRA2, DPRA3, DPRA4, WCLK, WE);

    parameter INIT = 32'h00000000;

    output DPO, SPO;

    input  A0, A1, A2, A3, A4, D, DPRA0, DPRA1, DPRA2, DPRA3, DPRA4, WCLK, WE;

    reg  [31:0] mem;
    wire [4:0] adr;

    assign adr = {A4, A3, A2, A1, A0};
    assign SPO = mem[adr];
    assign DPO = mem[{DPRA4, DPRA3, DPRA2, DPRA1, DPRA0}];

    initial 
        mem = INIT;

    always @(posedge WCLK) 
        if (WE == 1'b1)
            mem[adr] <= #100 D;

endmodule

