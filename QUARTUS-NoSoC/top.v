
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module top(

	//////////// ADC //////////
	output		          		ADC_CONVST,
	output		          		ADC_DIN,
	input 		          		ADC_DOUT,
	output		          		ADC_SCLK,

	//////////// Audio //////////
	input 		          		AUD_ADCDAT,
	inout 		          		AUD_ADCLRCK,
	inout 		          		AUD_BCLK,
	output		          		AUD_DACDAT,
	inout 		          		AUD_DACLRCK,
	output		          		AUD_XCK,

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,

	//////////// I2C for Audio and Video-In //////////
	output		          		FPGA_I2C_SCLK,
	inout 		          		FPGA_I2C_SDAT,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// IR //////////
	input 		          		IRDA_RXD,
	output		          		IRDA_TXD,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// PS2 //////////
	inout 		          		PS2_CLK,
	inout 		          		PS2_CLK2,
	inout 		          		PS2_DAT,
	inout 		          		PS2_DAT2,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// Video-In //////////
	input 		          		TD_CLK27,
	input 		     [7:0]		TD_DATA,
	input 		          		TD_HS,
	output		          		TD_RESET_N,
	input 		          		TD_VS,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	inout 		    [35:0]		GPIO_0,

	//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
	inout 		    [35:0]		GPIO_1
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
	
	localparam PULSE_AND_DELAY_WIDTH = 32;
	localparam ECHOES_PER_SCAN_WIDTH = 32;
	localparam ADC_INIT_DELAY_WIDTH = 32;
	localparam SAMPLES_PER_ECHO_WIDTH = 32;
	localparam NMR_MAIN_TIMER_WIDTH = 32;
	localparam ADC_DATA_WIDTH = 16;
	localparam ADC_PHYS_WIDTH = 14; // ADC physical data width
	localparam ADC_LATENCY = 5;
	
	wire i2c_int_sda_in;
    wire i2c_int_scl_in;
    wire i2c_int_sda_oe;
    wire i2c_int_scl_oe;
    wire i2c_ext_sda_in;
    wire i2c_ext_scl_in;
    wire i2c_ext_sda_oe;
    wire i2c_ext_scl_oe;
	
	wire DAC_SYNC;
	wire DAC_SCLK;
	wire DAC_SDIN;
	wire DAC_LDAC;
	wire DAC_CLR;
	
	// parameters
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		pulse_t1;
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		delay_t1;
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		pulse_90deg;
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		delay_nosig;
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		pulse_180deg;
	wire	[PULSE_AND_DELAY_WIDTH-1:0]		delay_sig;
	wire	[ECHOES_PER_SCAN_WIDTH-1:0]		echoes_per_scan;
	wire	[SAMPLES_PER_ECHO_WIDTH-1:0]	samples_per_echo;
	wire	[ADC_INIT_DELAY_WIDTH-1:0]		init_delay;
	
	wire	nmr_rfout_p;
	wire	nmr_rfout_n;
	
	wire	phase_cycle;
	
	wire	pulseprog_clk;
	
	// adc data
	wire	[ADC_DATA_WIDTH-1:0]	adc_data_in;
	wire	[ADC_DATA_WIDTH-1:0]	adc_data_out;
	
	wire adc_clk;
	wire nmr_controller_reset;
	
	wire fsm_start_issp;
	
	



	
	altiobuf i2c_ext_io (
		.datain		( 2'b00 ),
		.oe			( {i2c_ext_sda_oe , i2c_ext_scl_oe} ),
		.dataio		( {GPIO_1[14],GPIO_1[17]} ),
		.dataout	( {i2c_ext_sda_in , i2c_ext_scl_in} )
	);
	
	
	assign GPIO_1[5]	= SW[0];
	assign GPIO_1[16]	= SW[1];
	assign GPIO_1[13]	= DAC_SDIN;
	assign GPIO_1[10]	= DAC_SCLK;
	assign GPIO_1[11]	= DAC_SYNC;
	assign GPIO_1[15]	= DAC_CLR;
	assign GPIO_1[12]	= DAC_LDAC;
	assign GPIO_1[1] 	= nmr_rfout_p;
	assign GPIO_1[0]	= nmr_rfout_n;
	assign adc_data_in = {
							1'b0,
							GPIO_1[34],		// overflow sign
							GPIO_1[35],		// bit 13
							GPIO_1[32],		// bit 12
							GPIO_1[33],		// bit 11
							GPIO_1[30],		// bit 10
							GPIO_1[31],		// bit 9
							GPIO_1[28],		// bit 8
							GPIO_1[29],		// bit 7
							GPIO_1[26],		// bit 6
							GPIO_1[27],		// bit 5
							GPIO_1[24],		// bit 4
							GPIO_1[25],		// bit 3
							GPIO_1[22],		// bit 2
							GPIO_1[23],		// bit 1
							GPIO_1[20]		// bit 0
						};
	assign GPIO_1[19] = adc_clk;
	assign GPIO_1[18] = 1'b0;
	
	assign nmr_controller_reset = !KEY[1];
	assign fsm_start = !KEY[2] || fsm_start_issp;

endmodule
