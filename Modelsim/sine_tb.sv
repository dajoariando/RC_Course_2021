`timescale 1ps / 1ps

module sine_tb ();
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 10; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;
	
	
	parameter DWIDTH = 14;
	parameter UNR = 4;
	
	reg [DWIDTH-1:0]	din [UNR];
	wire [DWIDTH:0]		dout [UNR];
	
	
	
	sine
	# (
		.DWIDTH (DWIDTH),
		.UNR (UNR) // the unroll factor
	) sine1
	(
		.din (din),
		.dout (dout)
	);

	initial
	begin
		din = '{15,100,30,5};
		#(clockticks*10) din = '{105,10,20,17};
	end

endmodule