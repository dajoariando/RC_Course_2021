--Copyright (C) 2017  Intel Corporation. All rights reserved.
--Your use of Intel Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Intel Program License 
--Subscription Agreement, the Intel Quartus Prime License Agreement,
--the Intel FPGA IP License Agreement, or other applicable license
--agreement, including, without limitation, that your use is for
--the sole purpose of programming logic devices manufactured by
--Intel and sold by Intel or its authorized distributors.  Please
--refer to the applicable agreement for further details.


FUNCTION add_prl 
(
	data0x[25..0],
	data10x[25..0],
	data11x[25..0],
	data12x[25..0],
	data13x[25..0],
	data14x[25..0],
	data15x[25..0],
	data16x[25..0],
	data17x[25..0],
	data18x[25..0],
	data1x[25..0],
	data2x[25..0],
	data3x[25..0],
	data4x[25..0],
	data5x[25..0],
	data6x[25..0],
	data7x[25..0],
	data8x[25..0],
	data9x[25..0]
)

RETURNS (
	result[48..0]
);