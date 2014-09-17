
`timescale 1 ps/1 ps

module RAMB16BWER (DOA, DOB, DOPA, DOPB, 
		   ADDRA, ADDRB, CLKA, CLKB, DIA, DIB, DIPA, DIPB, ENA, ENB, REGCEA, REGCEB, RSTA, RSTB, WEA, WEB);

    output [31:0] DOA;
    output [31:0] DOB;
    output [3:0] DOPA;
    output [3:0] DOPB;

    input [13:0] ADDRA;
    input [13:0] ADDRB;
    input CLKA;
    input CLKB;
    input [31:0] DIA;
    input [31:0] DIB;
    input [3:0] DIPA;
    input [3:0] DIPB;
    input ENA;
    input ENB;
    input REGCEA;
    input REGCEB;
    input RSTA;
    input RSTB;
    input [3:0] WEA;
    input [3:0] WEB;
    
    parameter integer DATA_WIDTH_A = 0;
    parameter integer DATA_WIDTH_B = 0;
    parameter integer DOA_REG = 0;
    parameter integer DOB_REG = 0;
    parameter EN_RSTRAM_A = "TRUE";
    parameter EN_RSTRAM_B = "TRUE";
    parameter INITP_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_20 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_21 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_22 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_23 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_24 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_25 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_26 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_27 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_28 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_29 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_30 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_31 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_32 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_33 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_A = 36'h0;
    parameter INIT_B = 36'h0;
    parameter INIT_FILE = "NONE";
    parameter RSTTYPE = "SYNC";
    parameter RST_PRIORITY_A = "CE";
    parameter RST_PRIORITY_B = "CE";
    parameter SETUP_ALL = 1000;
    parameter SETUP_READ_FIRST = 3000;
    parameter SIM_DEVICE = "SPARTAN3ADSP";
    parameter SIM_COLLISION_CHECK = "ALL";
    parameter SRVAL_A = 36'h0;
    parameter SRVAL_B = 36'h0;
    parameter WRITE_MODE_A = "WRITE_FIRST";
    parameter WRITE_MODE_B = "WRITE_FIRST";


// verilator lint_off width
// verilator lint_off selrange 
// verilator lint_off initialdly
//


    localparam widest_width = (DATA_WIDTH_A >= DATA_WIDTH_B) ? DATA_WIDTH_A : DATA_WIDTH_B;

    localparam a_width = (DATA_WIDTH_A == 1) ? 1 : (DATA_WIDTH_A == 2) ? 2 : (DATA_WIDTH_A == 4) ? 4 :
			 (DATA_WIDTH_A == 9) ? 8 : (DATA_WIDTH_A == 18) ? 16 : (DATA_WIDTH_A == 36) ? 32 : 32;
    
    localparam b_width = (DATA_WIDTH_B == 1) ? 1 : (DATA_WIDTH_B == 2) ? 2 : (DATA_WIDTH_B == 4) ? 4 :
			 (DATA_WIDTH_B == 9) ? 8 : (DATA_WIDTH_B == 18) ? 16 : (DATA_WIDTH_B == 36) ? 32 : 32;
    localparam width = (widest_width == 1) ? 1 : (widest_width == 2) ? 2 : (widest_width == 4) ? 4 :
		       (widest_width == 9) ? 8 : (widest_width == 18) ? 16 : (widest_width == 36) ? 32 : 32;
    
    localparam widthp = (widest_width == 9) ? 1 : (widest_width == 18) ? 2 : (widest_width == 36) ? 4 : 4;
    localparam mem_depth = (widest_width == 1) ? 16384 : (widest_width == 2) ? 8192 : (widest_width == 4) ? 4096 : (widest_width == 9) ? 2048 : 
			   (widest_width == 18) ? 1024 :(widest_width == 36) ? 512 : 16384;
		
    localparam memp_depth = (widest_width == 9) ? 2048 : (widest_width == 18) ? 1024 : (widest_width == 36) ? 512 : 2048;

    reg [widest_width-1:0] tmp_mem [mem_depth-1:0];
    
    reg [width-1:0] mem [mem_depth-1:0];
    reg [widthp-1:0] memp [memp_depth-1:0];

    integer count, countp, init_mult, initp_mult, large_width;
    integer count1, countp1, i, i1, j, j1, i_p, i_mem;

    reg [1:0] wr_mode_a, wr_mode_b;

    reg [31:0] doado_out, doado_out_out;
    reg [31:0] dobdo_out, dobdo_out_out;
    reg finish_error = 0;
    

    wire clkawrclk_in, clkbrdclk_in;

    wire rsta_in=RSTA;
    wire rstbrst_in=RSTB;

    
    assign clkawrclk_in = CLKA;
    assign clkbrdclk_in = CLKB;
    

    initial begin

	if (INIT_FILE == "NONE") begin
	
	    init_mult = 256/width;
	    
	    for (count = 0; count < init_mult; count = count + 1) begin
		for (count1 = 0; count1 < width; count1 = count1 + 1) begin
		    
		    mem[count][count1]                    = INIT_00[(count * width) + count1];
		    mem[count + (init_mult * 1)][count1]  = INIT_01[(count * width) + count1];
		    mem[count + (init_mult * 2)][count1]  = INIT_02[(count * width) + count1];
		    mem[count + (init_mult * 3)][count1]  = INIT_03[(count * width) + count1];
		    mem[count + (init_mult * 4)][count1]  = INIT_04[(count * width) + count1];
		    mem[count + (init_mult * 5)][count1]  = INIT_05[(count * width) + count1];
		    mem[count + (init_mult * 6)][count1]  = INIT_06[(count * width) + count1];
		    mem[count + (init_mult * 7)][count1]  = INIT_07[(count * width) + count1];
		    mem[count + (init_mult * 8)][count1]  = INIT_08[(count * width) + count1];
		    mem[count + (init_mult * 9)][count1]  = INIT_09[(count * width) + count1];
		    mem[count + (init_mult * 10)][count1] = INIT_0A[(count * width) + count1];
		    mem[count + (init_mult * 11)][count1] = INIT_0B[(count * width) + count1];
		    mem[count + (init_mult * 12)][count1] = INIT_0C[(count * width) + count1];
		    mem[count + (init_mult * 13)][count1] = INIT_0D[(count * width) + count1];
		    mem[count + (init_mult * 14)][count1] = INIT_0E[(count * width) + count1];
		    mem[count + (init_mult * 15)][count1] = INIT_0F[(count * width) + count1];
		    mem[count + (init_mult * 16)][count1] = INIT_10[(count * width) + count1];
		    mem[count + (init_mult * 17)][count1] = INIT_11[(count * width) + count1];
		    mem[count + (init_mult * 18)][count1] = INIT_12[(count * width) + count1];
		    mem[count + (init_mult * 19)][count1] = INIT_13[(count * width) + count1];
		    mem[count + (init_mult * 20)][count1] = INIT_14[(count * width) + count1];
		    mem[count + (init_mult * 21)][count1] = INIT_15[(count * width) + count1];
		    mem[count + (init_mult * 22)][count1] = INIT_16[(count * width) + count1];
		    mem[count + (init_mult * 23)][count1] = INIT_17[(count * width) + count1];
		    mem[count + (init_mult * 24)][count1] = INIT_18[(count * width) + count1];
		    mem[count + (init_mult * 25)][count1] = INIT_19[(count * width) + count1];
		    mem[count + (init_mult * 26)][count1] = INIT_1A[(count * width) + count1];
		    mem[count + (init_mult * 27)][count1] = INIT_1B[(count * width) + count1];
		    mem[count + (init_mult * 28)][count1] = INIT_1C[(count * width) + count1];
		    mem[count + (init_mult * 29)][count1] = INIT_1D[(count * width) + count1];
		    mem[count + (init_mult * 30)][count1] = INIT_1E[(count * width) + count1];
		    mem[count + (init_mult * 31)][count1] = INIT_1F[(count * width) + count1];
		    mem[count + (init_mult * 32)][count1] = INIT_20[(count * width) + count1];
		    mem[count + (init_mult * 33)][count1] = INIT_21[(count * width) + count1];
		    mem[count + (init_mult * 34)][count1] = INIT_22[(count * width) + count1];
		    mem[count + (init_mult * 35)][count1] = INIT_23[(count * width) + count1];
		    mem[count + (init_mult * 36)][count1] = INIT_24[(count * width) + count1];
		    mem[count + (init_mult * 37)][count1] = INIT_25[(count * width) + count1];
		    mem[count + (init_mult * 38)][count1] = INIT_26[(count * width) + count1];
		    mem[count + (init_mult * 39)][count1] = INIT_27[(count * width) + count1];
		    mem[count + (init_mult * 40)][count1] = INIT_28[(count * width) + count1];
		    mem[count + (init_mult * 41)][count1] = INIT_29[(count * width) + count1];
		    mem[count + (init_mult * 42)][count1] = INIT_2A[(count * width) + count1];
		    mem[count + (init_mult * 43)][count1] = INIT_2B[(count * width) + count1];
		    mem[count + (init_mult * 44)][count1] = INIT_2C[(count * width) + count1];
		    mem[count + (init_mult * 45)][count1] = INIT_2D[(count * width) + count1];
		    mem[count + (init_mult * 46)][count1] = INIT_2E[(count * width) + count1];
		    mem[count + (init_mult * 47)][count1] = INIT_2F[(count * width) + count1];
		    mem[count + (init_mult * 48)][count1] = INIT_30[(count * width) + count1];
		    mem[count + (init_mult * 49)][count1] = INIT_31[(count * width) + count1];
		    mem[count + (init_mult * 50)][count1] = INIT_32[(count * width) + count1];
		    mem[count + (init_mult * 51)][count1] = INIT_33[(count * width) + count1];
		    mem[count + (init_mult * 52)][count1] = INIT_34[(count * width) + count1];
		    mem[count + (init_mult * 53)][count1] = INIT_35[(count * width) + count1];
		    mem[count + (init_mult * 54)][count1] = INIT_36[(count * width) + count1];
		    mem[count + (init_mult * 55)][count1] = INIT_37[(count * width) + count1];
		    mem[count + (init_mult * 56)][count1] = INIT_38[(count * width) + count1];
		    mem[count + (init_mult * 57)][count1] = INIT_39[(count * width) + count1];
		    mem[count + (init_mult * 58)][count1] = INIT_3A[(count * width) + count1];
		    mem[count + (init_mult * 59)][count1] = INIT_3B[(count * width) + count1];
		    mem[count + (init_mult * 60)][count1] = INIT_3C[(count * width) + count1];
		    mem[count + (init_mult * 61)][count1] = INIT_3D[(count * width) + count1];
		    mem[count + (init_mult * 62)][count1] = INIT_3E[(count * width) + count1];
		    mem[count + (init_mult * 63)][count1] = INIT_3F[(count * width) + count1];
		end // for (count1 = 0; count1 < width; count1 = count1 + 1)
	    end // for (count = 0; count < init_mult; count = count + 1)

	    
	    if (width >= 8) begin
	    
		initp_mult = 256/widthp;
		
		for (countp = 0; countp < initp_mult; countp = countp + 1) begin
		    for (countp1 = 0; countp1 < widthp; countp1 = countp1 + 1) begin
			
			memp[countp][countp1]                     = INITP_00[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 1)][countp1]  = INITP_01[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 2)][countp1]  = INITP_02[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 3)][countp1]  = INITP_03[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 4)][countp1]  = INITP_04[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 5)][countp1]  = INITP_05[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 6)][countp1]  = INITP_06[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 7)][countp1]  = INITP_07[(countp * widthp) + countp1];
			
		    end // for (countp1 = 0; countp1 < widthp; countp1 = countp1 + 1)
		end // for (countp = 0; countp < initp_mult; countp = countp + 1)
		
	    end // if (width >= 8)
	    
	end // if (INIT_FILE == "NONE")
	
	else begin

	    for (j = 0; j < mem_depth; j = j + 1) begin
		for (j1 = 0; j1 < widest_width; j1 = j1 + 1) begin
		    tmp_mem[j][j1] = 1'b0;
		end
	    end
	    
	    $readmemh (INIT_FILE, tmp_mem);
	    case (widest_width)

		1, 2, 4 : for (i_mem = 0; i_mem <= mem_depth; i_mem = i_mem + 1)
		              mem[i_mem] = tmp_mem [i_mem];
		
        `ifndef verilator 
		9 : for (i_mem = 0; i_mem <= mem_depth; i_mem = i_mem + 1) begin
		        mem[i_mem] = tmp_mem[i_mem][0 +: 8];
		        memp[i_mem] = tmp_mem[i_mem][8 +: 1];
	            end

		18 : for (i_mem = 0; i_mem <= mem_depth; i_mem = i_mem + 1) begin
		         mem[i_mem] = tmp_mem[i_mem][0 +: 16];
		         memp[i_mem] = tmp_mem[i_mem][16 +: 2];
	             end
	    
		36 : for (i_mem = 0; i_mem <= mem_depth; i_mem = i_mem + 1) begin
		         mem[i_mem] = tmp_mem[i_mem][0 +: 32];
		         memp[i_mem] = tmp_mem[i_mem][32 +: 4];
	             end
        `else
        default: begin
            $display ( "verilator impl needed %d", `__LINE__ );
        end
        `endif
	    endcase // case(widest_width)

	    //for (i=0;i<10;i=i+1)
        //    $display ( "mem [%d] %d", i, mem[i] );
 
	end // else: !if(INIT_FILE == "NONE")
	
	
	case (DATA_WIDTH_A)

	    0, 1, 2, 4, 9, 18, 36: ;

	    default : begin
		          $display("Attribute Syntax Error : The attribute DATA_WIDTH_A on RAMB16BWER instance %m is set to %d.  Legal values for this attribute are 0, 1, 2, 4, 9, 18 or 36.", DATA_WIDTH_A);
		          finish_error = 1;
	              end

	endcase // case(DATA_WIDTH_A)

	
	case (DATA_WIDTH_B)

	    0, 1, 2, 4, 9, 18, 36: ;

	    default : begin
		          $display("Attribute Syntax Error : The attribute DATA_WIDTH_B on RAMB16BWER instance %m is set to %d.  Legal values for this attribute are 0, 1, 2, 4, 9, 18 or 36.", DATA_WIDTH_B);
		          finish_error = 1;
	              end

	endcase // case(DATA_WIDTH_B)


	if (DATA_WIDTH_A == 0 && DATA_WIDTH_B == 0) begin
	    $display("Attribute Syntax Error : Attributes DATA_WIDTH_A and DATA_WIDTH_B on RAMB16BWER instance %m, both can not be 0.");
	    finish_error = 1;
	end

	       
	case (WRITE_MODE_A)
	    "WRITE_FIRST" : wr_mode_a <= 2'b00;
	    "READ_FIRST"  : wr_mode_a <= 2'b01;
	    "NO_CHANGE"   : wr_mode_a <= 2'b10;
	    default       : begin
				$display("Attribute Syntax Error : The Attribute WRITE_MODE_A on RAMB16BWER instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE_A);
				finish_error = 1;
			    end
	endcase


	case (WRITE_MODE_B)
	    "WRITE_FIRST" : wr_mode_b <= 2'b00;
	    "READ_FIRST"  : wr_mode_b <= 2'b01;
	    "NO_CHANGE"   : wr_mode_b <= 2'b10;
	    default       : begin
				$display("Attribute Syntax Error : The Attribute WRITE_MODE_B on RAMB16BWER instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE_B);
				finish_error = 1;
			    end
	endcase

	
	if ((SIM_COLLISION_CHECK != "ALL") && (SIM_COLLISION_CHECK != "NONE") && (SIM_COLLISION_CHECK != "WARNING_ONLY") && (SIM_COLLISION_CHECK != "GENERATE_X_ONLY")) begin
	    
	    $display("Attribute Syntax Error : The attribute SIM_COLLISION_CHECK on RAMB16BWER instance %m is set to %s.  Legal values for this attribute are ALL, NONE, WARNING_ONLY or GENERATE_X_ONLY.", SIM_COLLISION_CHECK);
	    finish_error = 1;

	end


	if ((EN_RSTRAM_A != "TRUE") && (EN_RSTRAM_A != "FALSE")) begin
	    $display("Attribute Syntax Error : The attribute EN_RSTRAM_A on RAMB16BWER instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", EN_RSTRAM_A);
	    finish_error = 1;
	end
	

	if ((EN_RSTRAM_B != "TRUE") && (EN_RSTRAM_B != "FALSE")) begin
	    $display("Attribute Syntax Error : The attribute EN_RSTRAM_B on RAMB16BWER instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", EN_RSTRAM_B);
	    finish_error = 1;
	end
	
	
	if ((RST_PRIORITY_A != "SR") && (RST_PRIORITY_A != "CE")) begin
	    $display("Attribute Syntax Error : The attribute RST_PRIORITY_A on RAMB16BWER instance %m is set to %s.  Legal values for this attribute are CE or SR.", RST_PRIORITY_A);
	    finish_error = 1;
	end
	
	
	if ((RST_PRIORITY_B != "SR") && (RST_PRIORITY_B != "CE")) begin
	    $display("Attribute Syntax Error : The attribute RST_PRIORITY_B on RAMB16BWER instance %m is set to %s.  Legal values for this attribute are CE or SR.", RST_PRIORITY_B);
	    finish_error = 1;
	end


	if (!(SIM_DEVICE == "SPARTAN3ADSP" || SIM_DEVICE == "SPARTAN6")) begin
	    $display("Attribute Syntax Error : The Attribute SIM_DEVICE on RAMB16BWER instance %m is set to %s.  Legal values for this attribute are SPARTAN3ADSP, or SPARTAN6.", SIM_DEVICE);
	    finish_error = 1;
	end

	
	if (finish_error == 1)
	    $finish;

	
    end // initial begin

// verilator lint_on selrange
// verilator lint_on initialdly

    assign DOA = DOA_REG>0 ? doado_out_out : doado_out;
    wire ena = EN_RSTRAM_A == "TRUE" ? ENA : 1;

    wire [12:0] addra = width <= 8 ? ADDRA  >> 1:
                        width <= 16 ? ADDRA >> 1 :
                        ADDRA >> 2;
    wire [12:0] addrb = width <= 8 ? ADDRB  >> 1:
                        width <= 16 ? ADDRB >> 1 :
                        ADDRB >> 2;

    wire write_a = |WEA && ena;

    always @(posedge clkawrclk_in or posedge rsta_in) begin
      if (rsta_in) begin
        doado_out <= 0;  
        doado_out_out <= 0;
      end else begin
        if (write_a) begin
          mem[addra] <= DIA[width-1:0]; 
          if (! (&WEA)) $display ( "verilator impl needed %d",`__LINE__);
        end
        doado_out <= WRITE_MODE_A == "WRITE_FIRST" && write_a ? DIA : mem[addra]; 
        doado_out_out <= doado_out;
      end
    end

    assign DOB = DOB_REG>0 ? dobdo_out_out : dobdo_out;
    wire enb = EN_RSTRAM_B == "TRUE" ? ENB : 1;

    wire write_b = |WEB && enb;

    always @(posedge clkbrdclk_in or posedge rstbrst_in) begin
      if (rstbrst_in) begin
        dobdo_out <= 0;  
        dobdo_out_out <= 0;
      end else begin
        if (write_b) begin
          mem[addrb] <= DIB[width-1:0]; 
          if (! (&WEB)) $display ( "verilator impl needed %d",`__LINE__);
        end
        dobdo_out <= WRITE_MODE_B == "WRITE_FIRST" && write_b ? DIB : mem[addrb]; 
        dobdo_out_out <= dobdo_out;
      end
    end

    
endmodule // RAMB16BWER

// verilator lint_on width
