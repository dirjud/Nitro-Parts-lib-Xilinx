///////////////////////////////////////////////////////////////////////////////
//    Copyright (c) 1995/2005 Xilinx, Inc.
// 
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
// 
//        http://www.apache.org/licenses/LICENSE-2.0
// 
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 10.1
//  \   \         Description : Xilinx Unified Simulation Library Component
//  /   /                  Dual Data Rate Output D Flip-Flop
// /___/   /\     Filename : ODDR.v
// \   \  /  \    
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Added LOC parameter, removed GSR ports and initialized outputs.
//    05/29/07 - Added wire declaration for internal signals
//    04/17/08 - CR 468871 Negative SetupHold fix
//    05/12/08 - CR 455447 add XON MSGON property to support async reg
//    12/03/08 - CR 498674 added pulldown on R/S.
//    07/28/09 - CR 527698 According to holistic, CE has to be high for both rise/fall CLK
//             - If CE is low on the rising edge, it has an effect of no change in the falling CLK.
//    06/23/10 - CR 566394 Removed extra recrem checks
//    12/13/11 - Added `celldefine and `endcelldefine (CR 524859).
//    04/13/12 - CR 591320 fixed SU/H checks in OPPOSITE edge mode.
//    10/22/14 - Added #1 to $finish (CR 808642).
// End Revision

`timescale 1 ps / 1 ps

`celldefine

module ODDR (Q, C, CE, D1, D2, R, S);
    
    output Q;
    
    input C;
    input CE;
    input D1;
    input D2;    
    input R;
    input S;

    parameter DDR_CLK_EDGE = "OPPOSITE_EDGE";    
    parameter INIT = 1'b0;
    parameter [0:0] IS_C_INVERTED = 1'b0;
    parameter [0:0] IS_D1_INVERTED = 1'b0;
    parameter [0:0] IS_D2_INVERTED = 1'b0;

    parameter SRTYPE = "SYNC";

    localparam MODULE_NAME = "ODDR";

    pulldown P1 (R);
    pulldown P2 (S);

    wire c_in;
    wire ce_in;
    wire d1_in;
    wire d2_in;
    wire gsr_in;
    wire r_in;
    wire s_in;
/* verilator lint_off MULTIDRIVEN */
    reg q_out;
/* verilator lint_off MULTIDRIVEN */

    assign c_in = C;
    assign ce_in = CE;
    assign d1_in =  D1;
    assign d2_in =  D2;
    assign r_in = R;
    assign s_in = S;
    assign Q = q_out;

    reg qd2_posedge_int;

    initial begin
        if ((SRTYPE != "ASYNC") && (SRTYPE != "ASYNC")) begin
            $display("SRTYPE = %s is not supported!", SRTYPE);
            $finish();
        end
    end

    if (SRTYPE == "ASYNC") begin
        always @(gsr_in or r_in or s_in) begin
            if (r_in == 1'b1) begin
                assign q_out = 1'b0;
                assign qd2_posedge_int = 1'b0;
            end
            else if (r_in == 1'b0 && s_in == 1'b1) begin
                assign q_out = 1'b1;
                assign qd2_posedge_int = 1'b1;
            end
            else if (r_in == 1'b0 && s_in == 1'b0) begin
                // deassign q_out;
                // deassign qd2_posedge_int;
            end
        end
    end else if (SRTYPE == "SYNC") begin
        always @(posedge c_in) begin
            if (r_in == 1'b1) begin
                q_out <= 1'b0;
                qd2_posedge_int <= 1'b0;
            end
            else if (r_in == 1'b0 && s_in == 1'b1) begin
                q_out <= 1'b1;
                qd2_posedge_int <= 1'b1;
            end
            else if (ce_in == 1'b1 && r_in == 1'b0 && s_in == 1'b0) begin
                q_out <= d1_in;
                qd2_posedge_int <= d2_in;
            end
            // CR 527698 
            else if (ce_in == 1'b0 && r_in == 1'b0 && s_in == 1'b0) begin
                qd2_posedge_int <= q_out;
            end
        end // always @ (posedge c_in)

        always @(negedge c_in) begin
            if (r_in == 1'b1)
                q_out <= 1'b0;
            else if (r_in == 1'b0 && s_in == 1'b1)
                q_out <= 1'b1;
            else if (ce_in == 1'b1 && r_in == 1'b0 && s_in == 1'b0) begin
                if (DDR_CLK_EDGE == "SAME_EDGE")
                    q_out <= qd2_posedge_int;
                else if (DDR_CLK_EDGE == "OPPOSITE_EDGE")
                    q_out <= d2_in;
            end
        end // always @ (negedge c_in)
    end

endmodule // ODDR

`endcelldefine

