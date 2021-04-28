`timescale 1ps / 1ps

module shreg
#(
	parameter DWIDTH = 15,
	parameter UNR = 4,
	parameter BUFLEN = 37-1+UNR
)
(
	// system signals
	input CLK,
	input RST,
	
	// data
	input signed [14:0]	din [UNR],
	output reg signed [14:0]	dout [BUFLEN]
);
	
	genvar i;
	
	// set all the buffers to 0 at bootup
	generate
		for (i=0; i<(BUFLEN); i=i+1)
		begin : buf_init
			initial
			begin
				dout[i] <= {15{1'b0}};
			end
		end
	endgenerate
	
	// buffer is shifted by 4 for every clock cycle
	generate
		for (i=0; i<(BUFLEN); i=i+1)
		begin : shbyUNR
			if (i<4)
			begin
				always @(posedge CLK, posedge RST)
					if (RST)
					begin
						dout[i] <= {15{1'b0}};
					end
					else
					begin
						dout[i] <= din[i];
					end
			end
			else
			begin
				always @(posedge CLK, posedge RST)
					if (RST)
					begin
						dout[i] <= {15{1'b0}};
					end
					else
					begin
						dout[i] <= dout[i-4];
					end
			end
		end
	endgenerate

	


endmodule