/*
 * mmcme2_base.v: Simulates the MMCME2_BASE pll of the Xilinx 7 series. This
 * is just a wrapper around the actual logic found in pll.v
 * author: Till Mahlburg
 * year: 2020
 * organization: Universität Leipzig
 * license: ISC
 *
 */

`timescale 1 ns / 1 ps

/* A reference for the interface can be found in Xilinx UG953 page 461ff */
module MMCME2_BASE #(
	/* not implemented */
	parameter BANDWIDTH 			= "OPTIMIZED",

	parameter CLKFBOUT_MULT_F 		= 5.000,
	parameter CLKFBOUT_PHASE 		= 0.000,

	/* is ignored, but should be set */
	parameter CLKIN1_PERIOD			= 0.000,

	parameter CLKOUT0_DIVIDE_F		= 1.000,
	parameter CLKOUT1_DIVIDE		= 1,
	parameter CLKOUT2_DIVIDE		= 1,
	parameter CLKOUT3_DIVIDE		= 1,
	parameter CLKOUT4_DIVIDE		= 1,
	parameter CLKOUT5_DIVIDE		= 1,
	parameter CLKOUT6_DIVIDE		= 1,

	parameter CLKOUT0_DUTY_CYCLE	= 0.500,
	parameter CLKOUT1_DUTY_CYCLE	= 0.500,
	parameter CLKOUT2_DUTY_CYCLE	= 0.500,
	parameter CLKOUT3_DUTY_CYCLE	= 0.500,
	parameter CLKOUT4_DUTY_CYCLE	= 0.500,
	parameter CLKOUT5_DUTY_CYCLE	= 0.500,
	parameter CLKOUT6_DUTY_CYCLE	= 0.500,

	parameter CLKOUT0_PHASE			= 0.000,
	parameter CLKOUT1_PHASE			= 0.000,
	parameter CLKOUT2_PHASE			= 0.000,
	parameter CLKOUT3_PHASE			= 0.000,
	parameter CLKOUT4_PHASE			= 0.000,
	parameter CLKOUT5_PHASE			= 0.000,
	parameter CLKOUT6_PHASE			= 0.000,

	parameter CLKOUT4_CASCADE		= "FALSE",

	parameter DIVCLK_DIVIDE			= 1,

	/* both not implemented */
	parameter REF_JITTER1			= 0.010,
	parameter STARTUP_WAIT			= "FALSE",

	/* Setting the FPGA model and speed grade allows a more realistic
	 * simulation. Default values are the most restrictive */
	parameter FPGA_TYPE				= "ARTIX",
	parameter SPEED_GRADE 			= "-1")(
	output CLKOUT0,
	output CLKOUT0B,
	output CLKOUT1,
	output CLKOUT1B,
	output CLKOUT2,
	output CLKOUT2B,
	output CLKOUT3,
	output CLKOUT3B,
	output CLKOUT4,
	output CLKOUT5,
	output CLKOUT6,
	/* PLL feedback output. */
	output CLKFBOUT,
	output CLKFBOUTB,

	output LOCKED,

	input CLKIN1,
	/* PLL feedback input. Is ignored in this implementation, but should be connected to CLKFBOUT for internal feedback. */
	input CLKFBIN,

	/* Used to power down instatiated but unused PLLs */
	input	PWRDWN,
	input	RST);

	wire	[15:0] DO;
	wire	DRDY;

	pll #(
 		.BANDWIDTH(BANDWIDTH),
 		.CLKFBOUT_MULT_F(CLKFBOUT_MULT_F),
		.CLKFBOUT_PHASE(CLKFBOUT_PHASE),
		.CLKIN1_PERIOD(CLKIN1_PERIOD),
		.CLKIN2_PERIOD(0.000),

		.CLKOUT0_DIVIDE_F(CLKOUT0_DIVIDE_F),
		.CLKOUT1_DIVIDE(CLKOUT1_DIVIDE),
		.CLKOUT2_DIVIDE(CLKOUT2_DIVIDE),
		.CLKOUT3_DIVIDE(CLKOUT3_DIVIDE),
		.CLKOUT4_DIVIDE(CLKOUT4_DIVIDE),
		.CLKOUT5_DIVIDE(CLKOUT5_DIVIDE),
		.CLKOUT6_DIVIDE(CLKOUT6_DIVIDE),

		.CLKOUT0_DUTY_CYCLE(CLKOUT0_DUTY_CYCLE),
		.CLKOUT1_DUTY_CYCLE(CLKOUT1_DUTY_CYCLE),
		.CLKOUT2_DUTY_CYCLE(CLKOUT2_DUTY_CYCLE),
		.CLKOUT3_DUTY_CYCLE(CLKOUT3_DUTY_CYCLE),
		.CLKOUT4_DUTY_CYCLE(CLKOUT4_DUTY_CYCLE),
		.CLKOUT5_DUTY_CYCLE(CLKOUT5_DUTY_CYCLE),
		.CLKOUT6_DUTY_CYCLE(CLKOUT6_DUTY_CYCLE),

		.CLKOUT0_PHASE(CLKOUT0_PHASE),
		.CLKOUT1_PHASE(CLKOUT1_PHASE),
		.CLKOUT2_PHASE(CLKOUT2_PHASE),
		.CLKOUT3_PHASE(CLKOUT3_PHASE),
		.CLKOUT4_PHASE(CLKOUT4_PHASE),
		.CLKOUT5_PHASE(CLKOUT5_PHASE),
		.CLKOUT6_PHASE(CLKOUT6_PHASE),

		.CLKOUT4_CASCADE(CLKOUT4_CASCADE),

		.DIVCLK_DIVIDE(DIVCLK_DIVIDE),
		.REF_JITTER1(REF_JITTER1),
		.REF_JITTER2(0.010),
		.STARTUP_WAIT(STARTUP_WAIT),
		.COMPENSATION("ZHOLD"),

		.MODULE_TYPE("MMCME2_BASE"),

		.FPGA_TYPE(FPGA_TYPE),
		.SPEED_GRADE(SPEED_GRADE))
	mmcme2_base (
		.CLKOUT0(CLKOUT0),
		.CLKOUT0B(CLKOUT0B),
		.CLKOUT1(CLKOUT1),
		.CLKOUT1B(CLKOUT1B),
		.CLKOUT2(CLKOUT2),
		.CLKOUT2B(CLKOUT2B),
		.CLKOUT3(CLKOUT3),
		.CLKOUT3B(CLKOUT3B),
		.CLKOUT4(CLKOUT4),
		.CLKOUT5(CLKOUT5),
		.CLKOUT6(CLKOUT6),

		.CLKFBOUT(CLKFBOUT),
		.CLKFBOUTB(CLKFBOUTB),
		.LOCKED(LOCKED),

		.CLKIN1(CLKIN1),
		.CLKIN2(1'b0),
		.CLKINSEL(1'b1),

		.PWRDWN(PWRDWN),
		.RST(RST),
		.CLKFBIN(CLKFBIN),

		.DADDR(7'h00),
		.DCLK(1'b0),
		.DEN(1'b0),
		.DWE(1'b0),
		.DI(16'h0),

		.DO(DO),
		.DRDY(DRDY));

endmodule
