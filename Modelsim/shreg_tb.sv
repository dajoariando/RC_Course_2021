module shreg_tb ();

parameter DWIDTH = 14;
parameter UNR = 4;
parameter BUFLEN = 37-1+UNR;

// parameters are referenced in MHz for calculation
parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
parameter CLK_RATE_HZ = 10; // in MHz
localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;

// system signals
reg CLK;
reg RST;

// data
reg [DWIDTH-1:0]	din [UNR];
wire [DWIDTH-1:0]	dout [BUFLEN];

shreg
#(
	.DWIDTH (DWIDTH),
	.UNR (UNR),
	.BUFLEN (BUFLEN)
) shreg1
(
	// system signals
	.CLK (CLK),
	.RST (RST),
	
	// data
	.din (din),
	.dout (dout)
);

initial
begin
	CLK = 1;
	RST = 1;
	#(clockticks*2) RST = 0;
	din = '{0,0,0,0};
	#(clockticks*100);
	#(clockticks*2) din = '{1,2,3,4};
	#(clockticks*2) din = '{5,6,7,8};
	#(clockticks*2) din = '{9,10,11,12};
	#(clockticks*2) din = '{13,14,15,16};
	#(clockticks*2) din = '{17,18,19,20};
	#(clockticks*2) din = '{21,22,23,24};
	#(clockticks*2) din = '{25,26,27,28};
	#(clockticks*2) din = '{29,30,31,32};
	#(clockticks*2) din = '{33,34,35,36};
	#(clockticks*2) din = '{37,38,39,40};
	#(clockticks*2) din = '{1,2,3,4};
end

always begin
	#clockticks CLK = ~CLK;
end

endmodule