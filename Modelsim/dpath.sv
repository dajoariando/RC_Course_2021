module dpath
#(
	parameter DWIDTH = 14,
	parameter CWIDTH = 11,
	parameter UNR = 4,
	parameter BUFLEN = 37-1+UNR
)
(
	// system signals
	input CLK,
	input RST,
	
	// data input
	input [13:0]	din [UNR],
	output	[25:0] firsum,
	
	// for testing only
	output [25:0] firout0,
	output [25:0] firout1,
	output [25:0] firout2,
	output [25:0] firout3,
	
	// filter coefficient
	input	[10:0]	coeff [37], // there are 37 coefficients
	
	// control signal
	input EN
	
);
	
	wire [14:0]	dsin [UNR]; // data multiplied by sine
	wire [14:0]	dshreg [BUFLEN]; // data in shift register
	// wire [DWIDTH+1+CWIDTH-1+2:0] firsum;
	
	sine
	# (
		.DWIDTH (DWIDTH),
		.CWIDTH (CWIDTH),
		.UNR (UNR) // the unroll factor
	) sine1
	(
		.din (din),
		.dout (dsin)
	);
	
	shreg
	#(
		.DWIDTH (DWIDTH+CWIDTH+1),
		.UNR (UNR),
		.BUFLEN (BUFLEN)
	) shreg1
	(
		// system signals
		.CLK (CLK),
		.RST (RST),
		
		// data
		.din (dsin),
		.dout (dshreg)
	);
	
	genvar i;
	generate
		for (i=0; i<UNR; i=i+1)
		begin : genfir
			wire [25:0] firout;
		
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
				.din(dshreg[4-1-i:40-1-i]),
				.dout(firout),
				
				// filter coefficient
				.coeff (coeff),
				
				// system signal
				.CLK(CLK),
				.RST(RST)
			);
		end
	endgenerate
	
	assign firsum = genfir[0].firout + genfir[1].firout + genfir[2].firout + genfir[3].firout ;
	assign firout0 = genfir[0].firout;
	assign firout1 = genfir[1].firout;
	assign firout2 = genfir[2].firout;
	assign firout3 = genfir[3].firout;

endmodule