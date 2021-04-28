`timescale 1ps / 1ps

module sine
# (
	parameter DWIDTH = 14,
	parameter CWIDTH = 11,
	parameter UNR = 4 // the unroll factor
)
(
	input [13:0]	din [UNR],
	output [14:0]	dout [UNR]
);
	
	// wire [DWIDTH:0] dummy0;
	// wire [DWIDTH:0] dummy1;
	// wire [DWIDTH:0] dummy2;
	// wire [DWIDTH:0] dummy3;
	
	// sine wave multiplication
	// assign dummy0 = {1'b0,din[0]};
	// assign dummy1 = {(DWIDTH+1){1'b0}}; // din[1];
	// assign dummy2 = ~{1'b0,din[2]}+1'b1;
	// assign dummy3 = {(DWIDTH+1){1'b0}};
	
	// assign dout[0] = {{CWIDTH{dummy0[DWIDTH]}},dummy0};
	// assign dout[1] = {{CWIDTH{dummy1[DWIDTH]}},dummy1};
	// assign dout[2] = {{CWIDTH{dummy2[DWIDTH]}},dummy2};
	// assign dout[3] = {{CWIDTH{dummy3[DWIDTH]}},dummy3};
	
	assign dout[0] = {1'b0,din[0]};
	assign dout[1] = {(DWIDTH+1){1'b0}}; // din[1];
	assign dout[2] = ~{1'b0,din[2]}+1'b1;
	assign dout[3] = {(DWIDTH+1){1'b0}};

	// simplified for debugging
	// assign dout[0] = {1'b0,din[0]};
	// assign dout[1] = {1'b0,din[1]};
	// assign dout[2] = {1'b0,din[2]};
	// assign dout[3] = {1'b0,din[3]};

endmodule