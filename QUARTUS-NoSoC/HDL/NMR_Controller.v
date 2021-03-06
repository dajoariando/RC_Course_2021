/*
	there is an issue with the ADC_WINGEN, where TOKEN is implemented to prevent retriggering. But also at the same time, if ADC_CLOCK is generated after ACQ_WND rises, the TOKEN is not resetted to 0, which will prevent the state machine from running. It is fixed by having reset button implemented to reset the TOKEN to 0 just before any acquisition. This is done in C Programming
*/

module NMR_Controller
#(
	parameter DATABUS_WIDTH = 32,
	parameter ADC_DATA_WIDTH = 16,	// ADC interface to FIFO width
	parameter ADC_PHYS_WIDTH = 14, 	// ADC physical data width
	parameter ADC_LATENCY = 5		// check the datasheet of LTC1746 for this
)
(
	// control signals
	input 	START /* synthesis keep = 1 */,
	output 	FSMSTAT /* synthesis keep = 1 */,
	
	// nmr parameters
	input [DATABUS_WIDTH-1:0]	T1_PULSE180,
	input [DATABUS_WIDTH-1:0]	T1_DELAY,
	input [DATABUS_WIDTH-1:0]	PULSE90,
	input [DATABUS_WIDTH-1:0]	DELAY_NO_ACQ,
	input [DATABUS_WIDTH-1:0]	PULSE180,
	input [DATABUS_WIDTH-1:0]	DELAY_WITH_ACQ,
	input [DATABUS_WIDTH-1:0]	ECHO_PER_SCAN,	// echo per scan integer number
	input [DATABUS_WIDTH-1:0]	SAMPLES_PER_ECHO,
	input [DATABUS_WIDTH-1:0]	ADC_INIT_DELAY,
	input [DATABUS_WIDTH-1:0]	RX_DELAY,
	input [DATABUS_WIDTH-1:0]	ECHO_SKIP,
	
	// nmr rf tx-output (differential)
	output RF_OUT_P,
	output RF_OUT_N,
	
	// nmr control signals
	input PHASE_CYCLE, 	// phase cycle control bit
	input PULSE_ON_RX,	// enable the transmit pulse on receive
	output EN_ADC,		// enable adc
	output EN_RX,		// enable receiver signal
	output ACQ_WND_DLY,	// delayed acquisition window for broadband board, mainly used for DUP_EN or RX_EN
	output TX_SD, // shutdown the transmitter during reception (minimize noise during reception)
	output EN_QSW,	// enable Q-switch
	output TX_PULSE_EN, // the pulse enable signal (RF pulse is output'd when this is high)
	
	// ADC bus
	input [ADC_PHYS_WIDTH-1:0] Q_IN,
	input Q_IN_OV,
	
	// data output
	output [ADC_DATA_WIDTH-1:0] ADC_OUT_DATA,
	output ADC_DATA_VALID /* synthesis keep = 1 */,
	
	// system signals
	input PULSEPROG_CLK,
	output ADC_CLK,		// clock generated by the FPGA for the ADC
	input ADC_CLKOUT,	// clock generated by the external ADC (phase shifted from the ADC_CLK)
	input RESET
);

	wire ACQ_WND /* synthesis keep = 1 */;
	wire ACQ_WND_ALWAYS_ON /* synthesis keep = 1 */;
	wire ACQ_EN;
	wire ACQ_EN_ALWAYS_ON;
	wire START_SYNC /* synthesis keep = 1 */;
	wire ACQ_WND_PULSED;
	

	
	CDC_Input_Synchronizer
	#(
		.SYNC_REG_LEN (4)
	)
	start_cnt_cdc
	(
		.ASYNC_IN	(START),
		.SYNC_OUT	(START_SYNC),
		.CLK		(PULSEPROG_CLK)
	);
	
	NMR_PULSE_PROGRAM
	#(
		.DATABUS_WIDTH (DATABUS_WIDTH)

	)
	NMR_PULSE_PROGRAM1
	(
		// control signals
		.START 			(START_SYNC),
		.FSMSTAT 		(FSMSTAT),
		
		// nmr control signals
		.PHASE_CYC		(PHASE_CYCLE),
		.PULSE_ON_RX	(PULSE_ON_RX),
		.ACQ_WND 		(ACQ_WND),
		.ACQ_WND_ALWAYS_ON (ACQ_WND_ALWAYS_ON),
		.OUT_EN			(TX_PULSE_EN),
		
		// nmr parameters
		.T1_PULSE180	(T1_PULSE180),
		.T1_DELAY		(T1_DELAY),
		.PULSE90 		(PULSE90),
		.DELAY_NO_ACQ 	(DELAY_NO_ACQ),
		.PULSE180 		(PULSE180),
		.DELAY_WITH_ACQ	(DELAY_WITH_ACQ),
		.ECHO_PER_SCAN 	(ECHO_PER_SCAN),
		.ECHO_SKIP		(ECHO_SKIP),
		
		// adc clock generator
		.ADC_CLK		(ADC_CLK),
		
		// nmr tx clock output
		.TX_OUT_P		(RF_OUT_P),
		.TX_OUT_N		(RF_OUT_N),
		
		// system signals
		.CLK			(PULSEPROG_CLK),
		.RESET			(RESET)
	);
	
	
	
	ADC_ACQ_WINGEN
	# (
		.DATABUS_WIDTH (DATABUS_WIDTH) 
	)
	ADC_ACQ_WINGEN1
	(

		// parameters
		.ADC_INIT_DELAY (ADC_INIT_DELAY),
		.SAMPLES_PER_ECHO (SAMPLES_PER_ECHO),
		
		// control signal
		.ACQ_WND (ACQ_WND),
		.ACQ_EN (ACQ_EN),
		
		// system signal
		.CLK (ADC_CLKOUT),
		.RESET (RESET)
	);
	
	ADC_ACQ_WINGEN
	# (
		.DATABUS_WIDTH (DATABUS_WIDTH) 
	)
	ADC_ACQ_WINGEN_ALWAYS_ON
	(

		// parameters
		.ADC_INIT_DELAY (ADC_INIT_DELAY),
		.SAMPLES_PER_ECHO (SAMPLES_PER_ECHO),
		
		// control signal
		.ACQ_WND (ACQ_WND_ALWAYS_ON),
		.ACQ_EN (ACQ_EN_ALWAYS_ON),
		
		// system signal
		.CLK (ADC_CLKOUT),
		.RESET (RESET)
	);
	
	ADC_LTC1746_DRV 
	# (
		.ADC_WIDTH		(ADC_PHYS_WIDTH), 	// ADC width given by the datasheet
		.ADC_LATENCY	(ADC_LATENCY) 		// ADC latency given by the datasheet
	)
	ADC_LTC1746_DRV1
	(
		// digital data
		.Q_IN		(Q_IN),								// digital data in
		.Q_IN_OV	(Q_IN_OV),							// digital data in overflow
		.Q_OUT		(ADC_OUT_DATA[ADC_PHYS_WIDTH-1:0]),	// digital data out
		.Q_OUT_OV	(ADC_OUT_DATA[ADC_PHYS_WIDTH]),		// digital data out overflow
		
		// control signal
		.acq_en		(ACQ_EN),			// acquisition starts (synced signal)
		.data_ready	(ADC_DATA_VALID),	// data ready signal for capture
		.out_en		(),					// output enable for the ADC
		
		// system signal
		.SYS_CLK	(ADC_CLKOUT),		// system control clock
		.RESET		(RESET)			// reset
	);
	assign ADC_OUT_DATA[ADC_DATA_WIDTH-1] = 1'b0; // bit-15 were not initialized anywhere in the ADC
	
	assign EN_ADC = ACQ_EN;
	assign EN_RX = ACQ_WND;
	
	
	// generate the RX enable or DUP enable with specific delay from the transmit signal
	NMR_RXDUP_EN_WINGEN
	# (
		.DATABUS_WIDTH (DATABUS_WIDTH)
	)
	NMR_RXDUP_EN_WINGEN1
	(
		// control signals
		.ACQ_WND (ACQ_WND_ALWAYS_ON),
		.ACQ_EN (ACQ_EN_ALWAYS_ON),
		.ACQ_WND_DLY (ACQ_WND_DLY),
		.ACQ_WND_PULSED (ACQ_WND_PULSED),
		
		.RX_DELAY (RX_DELAY),
		
		.ADC_CLK (ADC_CLKOUT),
		.RESET (RESET)
	);
	
	// generate the Q-switch enable signal
	NMR_QSW_EN_WINGEN NMR_QSW_EN_WINGEN1 (
		
		// control signal
		.ACQ_WND_PULSED	(ACQ_WND_PULSED),
		.ACQ_WND				(ACQ_WND_ALWAYS_ON),
		.EN_QSW				(EN_QSW),
		.RESET				(RESET),
		.ADC_CLK				(ADC_CLKOUT)
	
	);
	
	// generate the TX shutdown signal (to minimize noise during reception)
	NMR_TX_SD_WINGEN NMR_TX_SD_WINGEN1
	(
			
		// control signal
		.ACQ_EN	(ACQ_EN_ALWAYS_ON),
		.ACQ_WND	(ACQ_WND_ALWAYS_ON),
		
		.TX_SD	(TX_SD),
		.RESET	(RESET),
		.ADC_CLK	(ADC_CLKOUT)
		
	);

endmodule
