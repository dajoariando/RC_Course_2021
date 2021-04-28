`timescale 1ps / 1ps

module fir_tb ();
	
	parameter DWIDTH = 15;
	parameter CWIDTH = 11;
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 10; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;
	
	// control signal
	reg	EN;
	
	// data input/output
	// reg		[DWIDTH-1:0]		din;
	reg 	[DWIDTH-1:0]	din[37] = '{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1};
	wire	[DWIDTH+CWIDTH-1:0]	dout;
	
	// filter coefficient
	reg	[CWIDTH-1:0]	coeff[37] = '{144, 115, 158, 207, 263, 325, 392, 462, 535, 609, 682, 752, 817, 876, 926, 968, 998, 1016, 1023, 1016, 998, 968, 926, 876, 817, 752, 682, 609, 535, 462, 392, 325, 263, 207, 158, 115, 144};
	
	// system signal
	reg CLK;
	reg RST;
	
	
	fir
	# (
		.DWIDTH (DWIDTH),	// data width
		.CWIDTH (CWIDTH)	// coefficient width
	)
	fir1
	(
		// control signal
		.EN(EN),
		
		// data input/output
		.din(din),
		.dout(dout),
		
		// filter coefficient
		.coeff (coeff ),
		
		// system signal
		.CLK(CLK),
		.RST(RST)
	);
	
	
	
	initial
	begin
		EN	= 0;
		// din = 0;
		CLK = 0;
		RST = 1;
		
		#(clockticks*10) RST = 0;
		// #(clockticks*1) din = 1;
		#(clockticks*2) EN = 1;
	end
	
	always begin
		#clockticks CLK = ~CLK;
	end

endmodule