module cnt
(
	// control signals
	input ASYNC_START,
	input FIFO_VALID,
	output reg SYNC_READY,
	output reg DONE,
	output reg OUT_VALID,
	
	// system signals
	input CLK,
	input RST,
	
	// data to be processed
	input [31:0] DLEN
	
);
	
	wire SYNC_START;

	cdc
	#(
		.SYNC_REG_LEN (2)
	) cdc1
	(
		// Input Signal
		.ASYNC_IN (ASYNC_START),
		
		// Output Signal
		.SYNC_OUT (SYNC_START),
		
		// System Signals
		.CLK (CLK)
	);
	
	reg [31:0] DLEN_CNT;
	reg [31:0] OUT_VALID_CNT;
	
	wire [31:0] DLEN_CNT_LOADVAL;
	wire [31:0] OUT_VALID_CNT_LOADVAL;
	
	reg TOKEN; // token to avoid restarting ACQ_EN window when the ACQ_WND is long
	
	// clock domain crossing
	reg [31:0] DLEN_REG;
	reg [31:0] DLEN_REG2;
	always @(posedge CLK)
	begin
		DLEN_REG <= DLEN;
		DLEN_REG2 <= DLEN_REG;
	end
	
	reg [6:0] State;
	localparam [6:0]
		S0 = 7'b0000001,
		S1 = 7'b0000010,
		S2 = 7'b0000100,
		S3 = 7'b0001000,
		S4 = 7'b0010000,
		S5 = 7'b0100000,
		S6 = 7'b1000000;
		
	
	assign DLEN_CNT_LOADVAL = {1'b1,{ (31) {1'b0} }} - DLEN_REG2 + 1'b1;
	assign OUT_VALID_CNT_LOADVAL = {1'b1,{ (31) {1'b0} }} - 32'd7;
	
	initial
	begin
		DLEN_CNT <= {32{1'b0}};
		OUT_VALID_CNT <= {32{1'b0}};
		TOKEN <= 1'b0;
	end
	
	always @(posedge CLK, posedge RST)
	begin
		if (RST)
		begin
			TOKEN <= 1'b0;
			DLEN_CNT <= DLEN_CNT_LOADVAL;
			OUT_VALID_CNT <= OUT_VALID_CNT_LOADVAL;
			DONE <= 1'b1;
			SYNC_READY <= 1'b0;
			OUT_VALID <= 1'b0;
			State <= S0;
		end
		
		else
		begin
			
			case (State)
				
				S0 : // 
				begin
					DLEN_CNT <= DLEN_CNT_LOADVAL;
					OUT_VALID_CNT <= OUT_VALID_CNT_LOADVAL;
					OUT_VALID <= 1'b0;
					TOKEN <= SYNC_START;
					if (TOKEN == 1'b0 && SYNC_START == 1'b1) // detecting SYNC_START rising edge
						State = S1;
				end
				
				S1 : //
				begin
					DONE <= 1'b0;
					SYNC_READY <= 1'b1;
					if (FIFO_VALID)
						State <= S2;
				end
				
				S2 : //
				begin
					OUT_VALID_CNT <= OUT_VALID_CNT + 1'b1;
					if (OUT_VALID_CNT[31])
						State <= S3;
				end
				
				S3 : // 
				begin
					SYNC_READY <= 1'b1;
					OUT_VALID <= 1'b1;
					DLEN_CNT <= DLEN_CNT + 1'b1;
					if (DLEN_CNT[31])
						State <= S4;
				end
				
				S4 : //
				begin
					OUT_VALID <= 1'b0;
					SYNC_READY <= 1'b0;
					DONE <= 1'b1;
					State <= S0;
				end
				
			endcase
			
		end
	end
	
endmodule