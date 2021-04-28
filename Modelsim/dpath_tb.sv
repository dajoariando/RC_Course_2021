`timescale 1ps / 1ps

module dpath_tb ();
	
	parameter DWIDTH = 14;
	parameter CWIDTH = 11;
	parameter UNR = 4;
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 10; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;
	
	// control signal
	reg	EN;
	
	// data input/output
	reg [DWIDTH-1:0]	din [UNR];
	wire	[31:0] firsum;
	wire	[31:0] firout0;
	wire	[31:0] firout1;
	wire	[31:0] firout2;
	wire	[31:0] firout3;

	
	// filter coefficient
	// reg	[CWIDTH-1:0]	coeff[37] = '{144, 115, 158, 207, 263, 325, 392, 462, 535, 609, 682, 752, 817, 876, 926, 968, 998, 1016, 1023, 1016, 998, 968, 926, 876, 817, 752, 682, 609, 535, 462, 392, 325, 263, 207, 158, 115, 144};
	reg	[CWIDTH-1:0]	coeff[37] = '{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37};
	// system signal
	reg CLK;
	reg RST;
	
	reg ASYNC_START;
	reg FIFO_VALID;
	wire SYNC_READY;
	wire DONE;
	wire OUT_VALID;
	
	// data to be processed
	reg [31:0] DLEN;
	
	dpath
	#(
		.DWIDTH(DWIDTH),
		.CWIDTH(CWIDTH),
		.UNR(UNR)
	) dpath1
	(
		// system signals
		.CLK(CLK),
		.RST(RST),
		
		// data input
		.din (din),
		.firsum (firsum),
		
		// for testing only
		.firout0(firout0),
		.firout1(firout1),
		.firout2(firout2),
		.firout3(firout3),

		
		// filter coefficient
		.coeff (coeff), // there are 37 coefficients
		
		// control signal
		.EN (EN)
		
	);
	
	cnt cnt1
	(
		// control signals
		.ASYNC_START(ASYNC_START),
		.FIFO_VALID(FIFO_VALID),
		.SYNC_READY(SYNC_READY),
		.DONE(DONE),
		.OUT_VALID(OUT_VALID),
		
		// system signals
		.CLK(CLK),
		.RST(RST),
		
		// data to be processed
		.DLEN(DLEN)
		
	);
	
	initial
	begin
		EN	= 0;
		CLK = 1;
		RST = 1;
		DLEN = 100;
		FIFO_VALID = 0;
		ASYNC_START = 0;
		#(clockticks*2) RST = 0;
		din = '{0,0,0,0};
		#(clockticks*1) ASYNC_START = 1;
		#(clockticks*1) EN = 1;
		#(clockticks*10);
		#(clockticks*2) din = '{1,0,1,0};	// '{1,2,3,4}; // bit-0, bit-1, bit-2, bit-3
		FIFO_VALID = 1'b1;
		
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
									
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
								
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
								
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		#(clockticks*2) din = '{1,0,1,0};
		
		
		
		
		
		
		
		
		
		
		// #(clockticks*2) din = '{0,0,1,0};	// '{5,6,7,8};
		// #(clockticks*2) din = '{1,1,1,1};	// '{9,10,11,12};
		// #(clockticks*2) din = '{1,1,1,1};	// '{13,14,15,16};
		// #(clockticks*2) din = '{1,1,1,1};	// '{17,18,19,20};
		// #(clockticks*2) din = '{1,1,1,1};	// '{21,22,23,24};
		// #(clockticks*2) din = '{1,1,1,1};	// '{25,26,27,28};
		// #(clockticks*2) din = '{1,1,1,1};	// '{29,30,31,32};
		// #(clockticks*2) din = '{1,1,1,1};	// '{33,34,35,36};
		// #(clockticks*2) din = '{1,1,1,1};	// '{37,38,39,40};
		#(clockticks*2) din = '{0,0,0,0};
		#(clockticks*10) ASYNC_START = 0;
	end
	
	always begin
		#clockticks CLK = ~CLK;
	end

endmodule