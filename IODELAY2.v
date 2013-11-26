module IODELAY2 (
  output BUSY,
  output DATAOUT,
  output DATAOUT2,
  output DOUT,
  output TOUT,
  input CAL,
  input CE,
  input CLK,
  input IDATAIN,
  input INC,
  input IOCLK0,
  input IOCLK1,
  input ODATAIN,
  input RST,
  input T
);

  parameter COUNTER_WRAPAROUND = "WRAPAROUND"; // "WRAPAROUND", "STAY_AT_LIMIT"
  parameter DATA_RATE = "SDR";       // "SDR", "DDR"
  parameter DELAY_SRC = "IO";        // "IO", "IDATAIN", "ODATAIN"
  parameter integer IDELAY2_VALUE = 0;  // 0 to 255 inclusive
  parameter IDELAY_MODE = "NORMAL";  // "NORMAL", "PCI"
  parameter IDELAY_TYPE = "DEFAULT";    // "DEFAULT", "DIFF_PHASE_DETECTOR", "FIXED", "VARIABLE_FROM_HALF_MAX", "VARIABLE_FROM_ZERO"
  parameter integer IDELAY_VALUE = 0;   // 0 to 255 inclusive
  parameter integer ODELAY_VALUE = 0;   // 0 to 255 inclusive
  parameter SERDES_MODE = "NONE";       // "NONE", "MASTER", "SLAVE"
  parameter integer SIM_TAPDELAY_VALUE = 75; // 10 to 90 inclusive

   assign DATAOUT  = IDATAIN;
   assign DATAOUT2 = IDATAIN;
   assign DOUT = ODATAIN;
   assign TOUT = T;
   assign BUSY = 1'b0;

endmodule // IODELAY2
