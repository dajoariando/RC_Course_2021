/*
	this adc module is a controller for LTC1746 or its families
	it has latency due to its pipeline operation internally,
	so to avoid having latency, the driver provides latency buffer.
	The buffer stores the measurement data and enable the data ready
	after the latency. 
*/

module ADC_LTC1746_DRV 
# (
	parameter ADC_WIDTH = 14, // ADC width given by the datasheet
	parameter ADC_LATENCY = 5 // ADC latency given by the datasheet
)
(
	// digital data
	input [ADC_WIDTH-1:0] Q_IN,			// digital data in
	input Q_IN_OV,						// digital data in overflow
	output reg [ADC_WIDTH-1:0] Q_OUT,	// digital data out
	output reg Q_OUT_OV,				// digital data out overflow
	
	// control signal
	input acq_en,		// acquisition starts (synced signal)
	output reg data_ready,	// data ready signal for capture
	output out_en,		// output enable for the ADC
	
	// system signal
	input SYS_CLK,		// system control clock
	input RESET		// reset
);
	
	//reg [ADC_WIDTH-1:0] Q [ADC_LATENCY-1:0];	// this was a mistake, there's no need to buffer the data as the data already has latency
	//reg [ADC_LATENCY-1:0] Q_OV;				// this was a mistake, there's no need to buffer the data as the data already has latency
	reg [ADC_LATENCY-1:0] data_ready_buf;		// the only thing needs to be buffered is the data_ready, to add delay by the latency of the ADC
	
	assign out_en = 1'b1; // always enable the ADC
	
	genvar i;
	
	// generate buffer
	generate
	begin
		for (i = 0; i < ADC_LATENCY; i=i+1)
		begin : Latency_Buf_Gen
			if (i == 0)
			begin
				always @ (posedge SYS_CLK)
				begin
					//Q[i] <= Q_IN;
					//Q_OV[i] <= Q_IN_OV;
					data_ready_buf[i] <= acq_en;
				end
			end
			else
			begin
				always @ (posedge SYS_CLK)
				begin
					//Q[i] <= Q[i-1];
					//Q_OV[i] <= Q_OV[i-1];
					data_ready_buf[i] <= data_ready_buf[i-1];
				end
			end
		end
	end
	endgenerate
	
	// init buffer
	generate
	begin
		for (i = 0; i < ADC_LATENCY; i=i+1)
		begin : Latency_Buf_Gen_init
			initial
			begin
				//Q[i] <= {ADC_WIDTH{1'b0}};
				//Q_OV[i] <= 1'b0;
				data_ready_buf[i] <= 1'b0;
			end
		end
	end
	endgenerate
	
	// init output
	initial
	begin
		Q_OUT <= {ADC_WIDTH{1'b0}};
		Q_OUT_OV <= 1'b0;
		data_ready <= 1'b0;
	end
	
	always @(*)
	begin
		if (RESET)
		begin
			Q_OUT <= {ADC_WIDTH{1'b0}};
			Q_OUT_OV <= 1'b0;
			data_ready <= 1'b0;
		end
		else
		begin
			//Q_OUT <= Q[ADC_LATENCY-1];		// no need to add delay to the data
			Q_OUT <= Q_IN;
			//Q_OUT_OV <= Q_OV[ADC_LATENCY-1];	// no need to add delay to the data
			Q_OUT_OV <= Q_IN_OV;
			data_ready <= data_ready_buf[ADC_LATENCY-1];
		end
	end

endmodule