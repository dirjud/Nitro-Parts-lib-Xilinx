// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/stan/BUFPLL.v,v 1.11 2012/10/04 22:10:38 robh Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2007 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 10.1
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Phase Locked Loop buffer for Spartan Series
// /___/   /\     Filename : BUFPLL.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    06/09/08 - Initial version.
//    08/19/08 - IR 479918 -- added 100 ps latency to sequential paths.
//    02/10/09 - IR 505709 -- correlate SERDESSTROBE to GLCK
//    03/24/09 - CR 514119 -- sync output to LOCKED high signal 
//    06/16/09 - CR 525221 -- added ENABLE_SYNC attribute
//    02/08/11 - CR 584404 -- restart, if LOCK lost or reprogrammed
//    01/11/12 - CR 639574 -- aligned the SERDESTROBE to GCLK when ENABLE_SYNC=TRUE
//    10/04/12 - 680268 -- aligned the SERDESTROBE to IOCLK always and other clean up
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

module BUFPLL (IOCLK, LOCK, SERDESSTROBE, GCLK, LOCKED, PLLIN);


    parameter integer DIVIDE = 1;        // {1..8}
    parameter ENABLE_SYNC = "TRUE";



    output IOCLK;
    output LOCK;
    output SERDESSTROBE;

    input GCLK;
    input LOCKED;
    input PLLIN;


   assign IOCLK = PLLIN;
   assign LOCK = LOCKED;

   reg [3:0] div_count;
   reg 	     serdes_strobe;
   wire [3:0] next_div_count = div_count + 1;

   /* verilator lint_off WIDTH */
   wire [3:0] divider = DIVIDE;
   
   always @(posedge IOCLK) begin
      if(next_div_count == divider) begin
	 serdes_strobe <= 1;
	 div_count <= 0;
      end else begin
	 serdes_strobe <= 0;
	 div_count <= next_div_count;
      end
   end
   assign SERDESSTROBE = (DIVIDE == 1) ? 1'b0 : serdes_strobe;
   /* verilator lint_on WIDTH */

endmodule // BUFPLL

