module ISERDES2 (
  CFB0,
  CFB1,
  DFB,
  FABRICOUT,
  INCDEC,
  Q1,
  Q2,
  Q3,
  Q4,
  SHIFTOUT,
  VALID,
  BITSLIP,
  CE0,
  CLK0,
  CLK1,
  CLKDIV,
  D,
  IOCE,
  RST,
  SHIFTIN
);

  parameter BITSLIP_ENABLE = "FALSE";      // TRUE, FALSE
  parameter DATA_RATE = "SDR";             // SDR, DDR      
  parameter integer DATA_WIDTH = 1;        // {1..8}
  parameter INTERFACE_TYPE = "NETWORKING"; // NETWORKING, NETWORKING_PIPELINED, RETIMED
  parameter SERDES_MODE = "NONE";          // NONE, MASTER, SLAVE 
  localparam in_delay =  1;
  localparam out_delay = 100;
  localparam clk_delay = 0;
  localparam MODULE_NAME = "ISERDES2";

  output CFB0;
  output CFB1;
  output DFB;
  output FABRICOUT;
  output INCDEC;
  output reg Q1;
  output reg Q2;
  output reg Q3;
  output reg Q4;
  output reg SHIFTOUT;
  output VALID;

  input BITSLIP;
  input CE0;
  input CLK0;
  input CLK1;
  input CLKDIV;
  input D;
  input IOCE;
  input RST;
  input SHIFTIN;

//  pulldown( BITSLIP );
//  pulldown( RST );
//  pullup( CE0 );
//  pullup( IOCE );
//
  assign CFB0 = 0;
  assign CFB1 = 0;
  assign DFB = 0;
  assign FABRICOUT = 0;
  assign INCDEC = 0;
//  assign Q1 = 0;
//  assign Q2 = 0;
//  assign Q3 = 0;
//  assign Q4 = 0;
   assign VALID = 0;

   reg [3:0] srA;
   wire      Din = (SERDES_MODE == "SLAVE") ? SHIFTIN : D;
   
   always @(posedge CLK0 or posedge CLK1) begin
      srA <= { Din, srA[3:1] };
      SHIFTOUT <= srA[0];
      if(IOCE) begin
	 Q1 <= srA[0];
	 Q2 <= srA[1];
	 Q3 <= srA[2];
	 Q4 <= srA[3];
      end
   end
   
   
endmodule // ISERDES2
