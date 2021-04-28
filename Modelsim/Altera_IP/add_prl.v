// megafunction wizard: %PARALLEL_ADD%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: parallel_add 

// ============================================================
// File Name: add_prl.v
// Megafunction Name(s):
// 			parallel_add
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 17.1.0 Build 590 10/25/2017 SJ Lite Edition
// ************************************************************


//Copyright (C) 2017  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module add_prl (
	data0x,
	data10x,
	data11x,
	data12x,
	data13x,
	data14x,
	data15x,
	data16x,
	data17x,
	data18x,
	data1x,
	data2x,
	data3x,
	data4x,
	data5x,
	data6x,
	data7x,
	data8x,
	data9x,
	result);

	input	[25:0]  data0x;
	input	[25:0]  data10x;
	input	[25:0]  data11x;
	input	[25:0]  data12x;
	input	[25:0]  data13x;
	input	[25:0]  data14x;
	input	[25:0]  data15x;
	input	[25:0]  data16x;
	input	[25:0]  data17x;
	input	[25:0]  data18x;
	input	[25:0]  data1x;
	input	[25:0]  data2x;
	input	[25:0]  data3x;
	input	[25:0]  data4x;
	input	[25:0]  data5x;
	input	[25:0]  data6x;
	input	[25:0]  data7x;
	input	[25:0]  data8x;
	input	[25:0]  data9x;
	output	[48:0]  result;

	wire [48:0] sub_wire20;
	wire [25:0] sub_wire19 = data18x[25:0];
	wire [25:0] sub_wire18 = data17x[25:0];
	wire [25:0] sub_wire17 = data16x[25:0];
	wire [25:0] sub_wire16 = data15x[25:0];
	wire [25:0] sub_wire15 = data14x[25:0];
	wire [25:0] sub_wire14 = data13x[25:0];
	wire [25:0] sub_wire13 = data12x[25:0];
	wire [25:0] sub_wire12 = data11x[25:0];
	wire [25:0] sub_wire11 = data10x[25:0];
	wire [25:0] sub_wire10 = data9x[25:0];
	wire [25:0] sub_wire9 = data8x[25:0];
	wire [25:0] sub_wire8 = data7x[25:0];
	wire [25:0] sub_wire7 = data6x[25:0];
	wire [25:0] sub_wire6 = data5x[25:0];
	wire [25:0] sub_wire5 = data4x[25:0];
	wire [25:0] sub_wire4 = data3x[25:0];
	wire [25:0] sub_wire3 = data2x[25:0];
	wire [25:0] sub_wire2 = data1x[25:0];
	wire [25:0] sub_wire0 = data0x[25:0];
	wire [493:0] sub_wire1 = {sub_wire19, sub_wire18, sub_wire17, sub_wire16, sub_wire15, sub_wire14, sub_wire13, sub_wire12, sub_wire11, sub_wire10, sub_wire9, sub_wire8, sub_wire7, sub_wire6, sub_wire5, sub_wire4, sub_wire3, sub_wire2, sub_wire0};
	wire [48:0] result = sub_wire20[48:0];

	parallel_add	parallel_add_component (
				.data (sub_wire1),
				.result (sub_wire20)
				// synopsys translate_off
				,
				.aclr (),
				.clken (),
				.clock ()
				// synopsys translate_on
				);
	defparam
		parallel_add_component.msw_subtract = "NO",
		parallel_add_component.pipeline = 0,
		parallel_add_component.representation = "SIGNED",
		parallel_add_component.result_alignment = "LSB",
		parallel_add_component.shift = 0,
		parallel_add_component.size = 19,
		parallel_add_component.width = 26,
		parallel_add_component.widthr = 49;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: MSW_SUBTRACT STRING "NO"
// Retrieval info: CONSTANT: PIPELINE NUMERIC "0"
// Retrieval info: CONSTANT: REPRESENTATION STRING "SIGNED"
// Retrieval info: CONSTANT: RESULT_ALIGNMENT STRING "LSB"
// Retrieval info: CONSTANT: SHIFT NUMERIC "0"
// Retrieval info: CONSTANT: SIZE NUMERIC "19"
// Retrieval info: CONSTANT: WIDTH NUMERIC "26"
// Retrieval info: CONSTANT: WIDTHR NUMERIC "49"
// Retrieval info: USED_PORT: data0x 0 0 26 0 INPUT NODEFVAL "data0x[25..0]"
// Retrieval info: USED_PORT: data10x 0 0 26 0 INPUT NODEFVAL "data10x[25..0]"
// Retrieval info: USED_PORT: data11x 0 0 26 0 INPUT NODEFVAL "data11x[25..0]"
// Retrieval info: USED_PORT: data12x 0 0 26 0 INPUT NODEFVAL "data12x[25..0]"
// Retrieval info: USED_PORT: data13x 0 0 26 0 INPUT NODEFVAL "data13x[25..0]"
// Retrieval info: USED_PORT: data14x 0 0 26 0 INPUT NODEFVAL "data14x[25..0]"
// Retrieval info: USED_PORT: data15x 0 0 26 0 INPUT NODEFVAL "data15x[25..0]"
// Retrieval info: USED_PORT: data16x 0 0 26 0 INPUT NODEFVAL "data16x[25..0]"
// Retrieval info: USED_PORT: data17x 0 0 26 0 INPUT NODEFVAL "data17x[25..0]"
// Retrieval info: USED_PORT: data18x 0 0 26 0 INPUT NODEFVAL "data18x[25..0]"
// Retrieval info: USED_PORT: data1x 0 0 26 0 INPUT NODEFVAL "data1x[25..0]"
// Retrieval info: USED_PORT: data2x 0 0 26 0 INPUT NODEFVAL "data2x[25..0]"
// Retrieval info: USED_PORT: data3x 0 0 26 0 INPUT NODEFVAL "data3x[25..0]"
// Retrieval info: USED_PORT: data4x 0 0 26 0 INPUT NODEFVAL "data4x[25..0]"
// Retrieval info: USED_PORT: data5x 0 0 26 0 INPUT NODEFVAL "data5x[25..0]"
// Retrieval info: USED_PORT: data6x 0 0 26 0 INPUT NODEFVAL "data6x[25..0]"
// Retrieval info: USED_PORT: data7x 0 0 26 0 INPUT NODEFVAL "data7x[25..0]"
// Retrieval info: USED_PORT: data8x 0 0 26 0 INPUT NODEFVAL "data8x[25..0]"
// Retrieval info: USED_PORT: data9x 0 0 26 0 INPUT NODEFVAL "data9x[25..0]"
// Retrieval info: USED_PORT: result 0 0 49 0 OUTPUT NODEFVAL "result[48..0]"
// Retrieval info: CONNECT: @data 0 0 26 0 data0x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 260 data10x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 286 data11x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 312 data12x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 338 data13x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 364 data14x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 390 data15x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 416 data16x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 442 data17x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 468 data18x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 26 data1x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 52 data2x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 78 data3x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 104 data4x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 130 data5x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 156 data6x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 182 data7x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 208 data8x 0 0 26 0
// Retrieval info: CONNECT: @data 0 0 26 234 data9x 0 0 26 0
// Retrieval info: CONNECT: result 0 0 49 0 @result 0 0 49 0
// Retrieval info: GEN_FILE: TYPE_NORMAL add_prl.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL add_prl.inc TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL add_prl.cmp TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL add_prl.bsf TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL add_prl_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL add_prl_bb.v TRUE
// Retrieval info: LIB_FILE: altera_mf
