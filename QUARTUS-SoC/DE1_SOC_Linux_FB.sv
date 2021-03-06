// search for keyword: POSSIBLE ISSUE if there's a problem, e.g. in timing

// ANY RESET SIGNAL THAT'S TRIGGERED BY adc_clkout won't be working cause adc_clkout is not present before the sequence!!!!!!!!!!!!!!!!!!!!!!

`define ENABLE_HPS

module DE1_SOC_Linux_FB(
	// ADC
	inout			ADC_CS_N,
	output			ADC_DIN,
	input			ADC_DOUT,
	output			ADC_SCLK,

	// AUD
	input			AUD_ADCDAT,
	inout			AUD_ADCLRCK,
	inout			AUD_BCLK,
	output			AUD_DACDAT,
	inout			AUD_DACLRCK,
	output			AUD_XCK,

	// CLOCKS
	input			CLOCK2_50,
	input			CLOCK3_50,
	input			CLOCK4_50,
	input			CLOCK_50,

	// DRAM
	output	[12:0]	DRAM_ADDR,
	output	[1:0]	DRAM_BA,
	output			DRAM_CAS_N,
	output			DRAM_CKE,
	output			DRAM_CLK,
	output			DRAM_CS_N,
	inout	[15:0]	DRAM_DQ,
	output			DRAM_LDQM,
	output			DRAM_RAS_N,
	output			DRAM_UDQM,
	output			DRAM_WE_N,

	// FAN
	output			FAN_CTRL,

	// FPGA
	output			FPGA_I2C_SCLK,
	inout			FPGA_I2C_SDAT,

	// GPIO
	inout	[35:0]	GPIO_0,
	inout	[35:0]	GPIO_1,


	// HEX
	output	[6:0]	HEX0,
	output	[6:0]	HEX1,
	output	[6:0]	HEX2,
	output	[6:0]	HEX3,
	output	[6:0]	HEX4,
	output	[6:0]	HEX5,

`ifdef ENABLE_HPS
	// HPS
	inout			HPS_CONV_USB_N,
	output	[14:0]	HPS_DDR3_ADDR,
	output	[2:0]	HPS_DDR3_BA,
	output			HPS_DDR3_CAS_N,
	output			HPS_DDR3_CKE,
	output			HPS_DDR3_CK_N,
	output			HPS_DDR3_CK_P,
	output			HPS_DDR3_CS_N,
	output	[3:0]	HPS_DDR3_DM,
	inout	[31:0]	HPS_DDR3_DQ,
	inout	[3:0]	HPS_DDR3_DQS_N,
	inout	[3:0]	HPS_DDR3_DQS_P,
	output			HPS_DDR3_ODT,
	output			HPS_DDR3_RAS_N,
	output			HPS_DDR3_RESET_N,
	input			HPS_DDR3_RZQ,
	output			HPS_DDR3_WE_N,
	output			HPS_ENET_GTX_CLK,
	inout			HPS_ENET_INT_N,
	output			HPS_ENET_MDC,
	inout			HPS_ENET_MDIO,
	input			HPS_ENET_RX_CLK,
	input	[3:0]	HPS_ENET_RX_DATA,
	input			HPS_ENET_RX_DV,
	output	[3:0]	HPS_ENET_TX_DATA,
	output			HPS_ENET_TX_EN,
	inout	[3:0]	HPS_FLASH_DATA,
	output			HPS_FLASH_DCLK,
	output			HPS_FLASH_NCSO,
	inout			HPS_GSENSOR_INT,
	inout			HPS_I2C1_SCLK,
	inout			HPS_I2C1_SDAT,
	inout			HPS_I2C2_SCLK,
	inout			HPS_I2C2_SDAT,
	inout			HPS_I2C_CONTROL,
	inout			HPS_KEY,
	inout			HPS_LED,
	inout			HPS_LTC_GPIO,
	output			HPS_SD_CLK,
	inout			HPS_SD_CMD,
	inout	[3:0]	HPS_SD_DATA,
	output			HPS_SPIM_CLK,
	input			HPS_SPIM_MISO,
	output			HPS_SPIM_MOSI,
	inout			HPS_SPIM_SS,
	input			HPS_UART_RX,
	output			HPS_UART_TX,
	input			HPS_USB_CLKOUT,
	inout	[7:0]	HPS_USB_DATA,
	input			HPS_USB_DIR,
	input			HPS_USB_NXT,
	output			HPS_USB_STP,
`endif /*ENABLE_HPS*/

	// IRDA
	input			IRDA_RXD,
	output			IRDA_TXD,

	// KEY
	input	[3:0]	KEY,

	// LEDR
	output	[9:0]	LEDR,

	// PS2
	inout			PS2_CLK,
	inout			PS2_CLK2,
	inout			PS2_DAT,
	inout			PS2_DAT2,

	// SW
	input	[9:0]	SW,

	// TD
	input			TD_CLK27,
	input	[7:0]	TD_DATA,
	input			TD_HS,
	output			TD_RESET_N,
	input			TD_VS,

	// VGA
	output	[7:0]	VGA_B,
	output			VGA_BLANK_N,
	output			VGA_CLK,
	output	[7:0]	VGA_G,
	output			VGA_HS,
	output	[7:0]	VGA_R,
	output			VGA_SYNC_N,
	output			VGA_VS
);

	localparam DATABUS_WIDTH = 32;
	localparam ADC_DATA_WIDTH = 16;
	localparam ADC_PHYS_WIDTH = 14; // ADC physical data width
	localparam ADC_LATENCY = 5;


//=======================================================
// REG/WIRE declarations
//=======================================================

	// control output signal
	wire			nmr_clk_gate_avln_cnt;	// nmr clock gate controlled by the avalon bus
	wire			activate_adc_avln_cnt;	// adc control signal to be activated from the avalon memory map bus / hard processor
	wire			adc_fifo_reset;
	wire			fsm_start;
	wire			phase_cycle;
	wire			enable_rx;
	wire			enable_adc;
	wire			dac_preamp_LDAC_n;
	wire			dac_grad_LDAC_n;
	wire			dac_preamp_CLR_n;
	wire			dac_grad_CLR_n;
	wire			qsw_en;
	wire			dup_en;
	wire			tx_opa_sd;						// shutdown signal for the TX devices
	wire			tx_opa_sd_msk;					// override/mask the effect of shutdown signal (put 0 to disable tx_opa_sd output)
	wire			tx_opa_en;						// the transmitter always enable signal
	wire			pulse_on_rx;				// enable the tx pulse during receive phase
	wire			tx_pulse_en;				// the pulse is output'd when this signal is high
	wire			sys_rst;

	// control input signal
	wire			pll_nmr_sys_locked;
	wire			pll_analyzer_locked;
	wire			fsmstat;

	// clock
	wire			pulseprog_clk;
	wire			adc_clk, adc_clkout; 	// adc_clk is the clock generated by the fpga. adc_clk_gen is the clock generated by the ADC.
	
	wire			pll_analyzer_clk0;
	wire			pll_analyzer_clk1;
	wire			pll_analyzer_clk2;
	wire			pll_analyzer_clk3;
	
	reg			pll_analyzer_clk0_gated;
	reg			pll_analyzer_clk1_gated;
	reg			pll_analyzer_clk2_gated;
	reg			pll_analyzer_clk3_gated;


	// reset signals
	wire			pll_nmr_sys_reset;
	wire			pll_analyzer_reset;
	wire			nmr_controller_reset;
	wire			FSM_GNRTD_RST__adc_clk;
	
	// parameters
	wire	[DATABUS_WIDTH-1:0]		pulse_90deg;
	wire	[DATABUS_WIDTH-1:0]		pulse_180deg;
	wire	[DATABUS_WIDTH-1:0]		delay_nosig;
	wire	[DATABUS_WIDTH-1:0]		delay_sig;
	wire	[DATABUS_WIDTH-1:0]		pulse_t1;
	wire	[DATABUS_WIDTH-1:0]		delay_t1;
	wire	[DATABUS_WIDTH-1:0]		samples_per_echo;
	wire	[DATABUS_WIDTH-1:0]		echoes_per_scan;
	wire	[DATABUS_WIDTH-1:0]		init_delay;
	wire	[DATABUS_WIDTH-1:0]		rx_delay;
	wire	[DATABUS_WIDTH-1:0]		adc_val_sub;
	wire	[15:0]							dec_fact;
	wire	[DATABUS_WIDTH-1:0]		echo_skip;

	// adc data
	wire	[ADC_DATA_WIDTH-1:0]			adc_data_in/* synthesis keep = 1 */;
	wire	[ADC_DATA_WIDTH-1:0]			adc_data_out;

	wire									adc_data_valid;
	wire									nmr_rfout_p;
	wire									nmr_rfout_n;
	
	// fir related signals
	wire	[31:0]							dconv_fir_out_data/* synthesis keep = 1 */; // the bus length is defined by FIR module in the QSYS. Make sure of this.
	wire	[31:0]							dconv_fir_q_out_data; // the bus length is defined by FIR module in the QSYS. Make sure of this.
	wire	[31:0]							dconv_fir_iq_comb_dec_data; // the combined decimated data from FIR filter
	wire 									dconv_fir_out_valid;
	wire 									dconv_fir_q_out_valid;
	wire									dconv_fir_iq_comb_dec_valid;
	wire									dconv_fir_q_rst_reset_n;
	wire									dconv_fir_rst_reset_n;
	wire	[ADC_PHYS_WIDTH:0]				data_i /* synthesis keep = 1 */;
	wire	[ADC_PHYS_WIDTH:0]				data_q /* synthesis keep = 1 */;

	// VGA control
	wire		clk_65;
	wire [7:0]	vid_r,vid_g,vid_b;
	wire		vid_v_sync ;
	wire		vid_h_sync ;
	wire		vid_datavalid;
	wire		pll_vga_locked;

	/* DAC preamp
	wire dac_preamp_MISO;
	wire dac_preamp_MOSI;
	wire dac_preamp_SCLK;
	wire dac_preamp_SS_n;
	
	// DAC gradient driver
	wire dac_grad_MISO;
	wire dac_grad_MOSI;
	wire dac_grad_SCLK;
	wire dac_grad_SS_n;

	// SPI for matching network
	wire spi_mtch_ntwrk_MISO;
	wire spi_mtch_ntwrk_MOSI;
	wire spi_mtch_ntwrk_SCLK;
	wire spi_mtch_ntwrk_SS_n;
	
	// SPI for AFE relays
	wire spi_afe_relays_MISO;
	wire spi_afe_relays_MOSI;
	wire spi_afe_relays_SCLK;
	wire spi_afe_relays_SS_n;
	
	// I2C wires
	wire i2c_int_sda_in;
	wire i2c_int_scl_in;
	wire i2c_int_sda_oe;
	wire i2c_int_scl_oe;
	
	// wire i2c_ext_sda_in;
	// wire i2c_ext_scl_in;
	// wire i2c_ext_sda_oe;
	// wire i2c_ext_scl_oe;
	*/
	
	// Clock Domain Crossing!!!
	reg	[DATABUS_WIDTH-1:0]		pulse_90deg_reg;
	reg	[DATABUS_WIDTH-1:0]		pulse_180deg_reg;
	reg	[DATABUS_WIDTH-1:0]		delay_nosig_reg;
	reg	[DATABUS_WIDTH-1:0]		delay_sig_reg;
	reg	[DATABUS_WIDTH-1:0]		pulse_t1_reg;
	reg	[DATABUS_WIDTH-1:0]		delay_t1_reg;
	reg	[DATABUS_WIDTH-1:0]		samples_per_echo_reg;
	reg	[DATABUS_WIDTH-1:0]		echoes_per_scan_reg;
	reg	[DATABUS_WIDTH-1:0]		echo_skip_reg;
	reg	[DATABUS_WIDTH-1:0]		init_delay_reg;
	reg	[DATABUS_WIDTH-1:0]		rx_delay_reg;
	reg	[DATABUS_WIDTH-1:0]		adc_val_sub_reg;
	reg 	[15:0]						dec_fact_reg;
	reg 	[ADC_DATA_WIDTH-1:0] 	adc_data_in__adc_clkreg;
	reg									fsmstat__adc_clkreg;

	always @(posedge pulseprog_clk)
	begin
		pulse_90deg_reg      <= pulse_90deg;
		pulse_180deg_reg     <= pulse_180deg;
		delay_nosig_reg      <= delay_nosig;
		delay_sig_reg        <= delay_sig;
		pulse_t1_reg         <= pulse_t1;
		delay_t1_reg         <= delay_t1;
		echoes_per_scan_reg  <= echoes_per_scan;
		echo_skip_reg			<= echo_skip;
		
		// POSSIBLE ISSUE: these lines should be put in adc_clkout CDC, but adc_clkout is not present at the beginning,
		// making these registers not updated at the right time. So it is put here with the consideration that these logic
		// are very slow and that the data doesn't change during the acquisition
		init_delay_reg       	<= init_delay;
		adc_val_sub_reg			<= adc_val_sub;
		samples_per_echo_reg 	<= samples_per_echo;
		rx_delay_reg		 		<= rx_delay;
		dec_fact_reg				<= dec_fact;
		
	end
	always @(posedge adc_clkout)
	begin
		fsmstat__adc_clkreg		<= fsmstat;
		adc_data_in__adc_clkreg	<= adc_data_in;
	end
	
	parameter DWIDTH = 14;
	parameter CWIDTH = 11;
	parameter UNR = 4;
	
	wire [DWIDTH-1:0]				din [UNR];
	wire [31:0]	firsum;
	// reg [CWIDTH-1:0]				coeff[37] = '{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37};
	reg [CWIDTH-1:0]				coeff[37] = '{144, 115, 158, 207, 263, 325, 392, 462, 535, 609, 682, 752, 817, 876, 926, 968, 998, 1016, 1023, 1016, 998, 968, 926, 876, 817, 752, 682, 609, 535, 462, 392, 325, 263, 207, 158, 115, 144};
	
	wire FIFO_VALID;
	wire SYNC_READY;
	wire OUT_VALID;
	wire [31:0] DLEN;
	
	wire [31:0] firout0;
	wire [31:0] firout1;
	wire [31:0] firout2;
	wire [31:0] firout3;
	
	wire [3:0] dummy;
	

 
//=======================================================
// Structural coding
//=======================================================


	assign   VGA_BLANK_N          =     1'b1;
	assign   VGA_SYNC_N           =     1'b0;	
	assign   VGA_CLK              =     clk_65;
	assign  {VGA_B,VGA_G,VGA_R}   =     {vid_b,vid_g,vid_r};
	assign   VGA_VS               =     vid_v_sync;
	assign   VGA_HS               =     vid_h_sync;

	soc_system u0 (

		.clk_clk			(CLOCK_50),	// clk.clk
		.reset_reset_n		(1'b1),		// reset.reset_n

		// HPS ddr3
		.memory_mem_a		(HPS_DDR3_ADDR),	// memory.mem_a
		.memory_mem_ba		(HPS_DDR3_BA),		// .mem_ba
		.memory_mem_ck		(HPS_DDR3_CK_P),	// .mem_ck
		.memory_mem_ck_n	(HPS_DDR3_CK_N),	// .mem_ck_n
		.memory_mem_cke		(HPS_DDR3_CKE),		// .mem_cke
		.memory_mem_cs_n	(HPS_DDR3_CS_N),	// .mem_cs_n
		.memory_mem_ras_n	(HPS_DDR3_RAS_N),	// .mem_ras_n
		.memory_mem_cas_n	(HPS_DDR3_CAS_N),	// .mem_cas_n
		.memory_mem_we_n	(HPS_DDR3_WE_N),	// .mem_we_n
		.memory_mem_reset_n	(HPS_DDR3_RESET_N),	// .mem_reset_n
		.memory_mem_dq		(HPS_DDR3_DQ),		// .mem_dq
		.memory_mem_dqs		(HPS_DDR3_DQS_P),	// .mem_dqs
		.memory_mem_dqs_n	(HPS_DDR3_DQS_N),	// .mem_dqs_n
		.memory_mem_odt		(HPS_DDR3_ODT),		// .mem_odt
		.memory_mem_dm		(HPS_DDR3_DM),		// .mem_dm
		.memory_oct_rzqin	(HPS_DDR3_RZQ),		// .oct_rzqin

		// HPS ethernet
		.hps_0_hps_io_hps_io_emac1_inst_TX_CLK	(HPS_ENET_GTX_CLK),		// .hps_0_hps_io.hps_io_emac1_inst_TX_CLK
		.hps_0_hps_io_hps_io_emac1_inst_TXD0	(HPS_ENET_TX_DATA[0]),	// .hps_io_emac1_inst_TXD0
		.hps_0_hps_io_hps_io_emac1_inst_TXD1	(HPS_ENET_TX_DATA[1]),	// .hps_io_emac1_inst_TXD1
		.hps_0_hps_io_hps_io_emac1_inst_TXD2	(HPS_ENET_TX_DATA[2]),	// .hps_io_emac1_inst_TXD2
		.hps_0_hps_io_hps_io_emac1_inst_TXD3	(HPS_ENET_TX_DATA[3]),	// .hps_io_emac1_inst_TXD3
		.hps_0_hps_io_hps_io_emac1_inst_RXD0	(HPS_ENET_RX_DATA[0]),	// .hps_io_emac1_inst_RXD0
		.hps_0_hps_io_hps_io_emac1_inst_MDIO	(HPS_ENET_MDIO),		// .hps_io_emac1_inst_MDIO
		.hps_0_hps_io_hps_io_emac1_inst_MDC		(HPS_ENET_MDC),			// .hps_io_emac1_inst_MDC
		.hps_0_hps_io_hps_io_emac1_inst_RX_CTL	(HPS_ENET_RX_DV),		// .hps_io_emac1_inst_RX_CTL
		.hps_0_hps_io_hps_io_emac1_inst_TX_CTL	(HPS_ENET_TX_EN),		// .hps_io_emac1_inst_TX_CTL
		.hps_0_hps_io_hps_io_emac1_inst_RX_CLK	(HPS_ENET_RX_CLK),		// .hps_io_emac1_inst_RX_CLK
		.hps_0_hps_io_hps_io_emac1_inst_RXD1	(HPS_ENET_RX_DATA[1]),	// .hps_io_emac1_inst_RXD1
		.hps_0_hps_io_hps_io_emac1_inst_RXD2	(HPS_ENET_RX_DATA[2]),	// .hps_io_emac1_inst_RXD2
		.hps_0_hps_io_hps_io_emac1_inst_RXD3	(HPS_ENET_RX_DATA[3]),	// .hps_io_emac1_inst_RXD3

		// HPS QSPI
		.hps_0_hps_io_hps_io_qspi_inst_IO0	(HPS_FLASH_DATA[0]),	// .hps_io_qspi_inst_IO0
		.hps_0_hps_io_hps_io_qspi_inst_IO1	(HPS_FLASH_DATA[1]),	// .hps_io_qspi_inst_IO1
		.hps_0_hps_io_hps_io_qspi_inst_IO2	(HPS_FLASH_DATA[2]),	// .hps_io_qspi_inst_IO2
		.hps_0_hps_io_hps_io_qspi_inst_IO3	(HPS_FLASH_DATA[3]),	// .hps_io_qspi_inst_IO3
		.hps_0_hps_io_hps_io_qspi_inst_SS0	(HPS_FLASH_NCSO),		// .hps_io_qspi_inst_SS0
		.hps_0_hps_io_hps_io_qspi_inst_CLK	(HPS_FLASH_DCLK),		// .hps_io_qspi_inst_CLK

		// HPS SD card
		.hps_0_hps_io_hps_io_sdio_inst_CMD	(HPS_SD_CMD),		// .hps_io_sdio_inst_CMD
		.hps_0_hps_io_hps_io_sdio_inst_D0	(HPS_SD_DATA[0]),	// .hps_io_sdio_inst_D0
		.hps_0_hps_io_hps_io_sdio_inst_D1	(HPS_SD_DATA[1]),	// .hps_io_sdio_inst_D1
		.hps_0_hps_io_hps_io_sdio_inst_CLK	(HPS_SD_CLK),		// .hps_io_sdio_inst_CLK
		.hps_0_hps_io_hps_io_sdio_inst_D2	(HPS_SD_DATA[2]),	// .hps_io_sdio_inst_D2
		.hps_0_hps_io_hps_io_sdio_inst_D3	(HPS_SD_DATA[3]),	// .hps_io_sdio_inst_D3

		// HPS USB
		.hps_0_hps_io_hps_io_usb1_inst_D0	(HPS_USB_DATA[0]),	// .hps_io_usb1_inst_D0
		.hps_0_hps_io_hps_io_usb1_inst_D1	(HPS_USB_DATA[1]),	// .hps_io_usb1_inst_D1
		.hps_0_hps_io_hps_io_usb1_inst_D2	(HPS_USB_DATA[2]),	// .hps_io_usb1_inst_D2
		.hps_0_hps_io_hps_io_usb1_inst_D3	(HPS_USB_DATA[3]),	// .hps_io_usb1_inst_D3
		.hps_0_hps_io_hps_io_usb1_inst_D4	(HPS_USB_DATA[4]),	// .hps_io_usb1_inst_D4
		.hps_0_hps_io_hps_io_usb1_inst_D5	(HPS_USB_DATA[5]),	// .hps_io_usb1_inst_D5
		.hps_0_hps_io_hps_io_usb1_inst_D6	(HPS_USB_DATA[6]),	// .hps_io_usb1_inst_D6
		.hps_0_hps_io_hps_io_usb1_inst_D7	(HPS_USB_DATA[7]),	// .hps_io_usb1_inst_D7
		.hps_0_hps_io_hps_io_usb1_inst_CLK	(HPS_USB_CLKOUT),	// .hps_io_usb1_inst_CLK
		.hps_0_hps_io_hps_io_usb1_inst_STP	(HPS_USB_STP),		// .hps_io_usb1_inst_STP
		.hps_0_hps_io_hps_io_usb1_inst_DIR	(HPS_USB_DIR),		// .hps_io_usb1_inst_DIR
		.hps_0_hps_io_hps_io_usb1_inst_NXT	(HPS_USB_NXT),		// .hps_io_usb1_inst_NXT

		// HPS SPI
		.hps_0_hps_io_hps_io_spim1_inst_CLK		(HPS_SPIM_CLK),		// .hps_io_spim1_inst_CLK
		.hps_0_hps_io_hps_io_spim1_inst_MOSI	(HPS_SPIM_MOSI),	// .hps_io_spim1_inst_MOSI
		.hps_0_hps_io_hps_io_spim1_inst_MISO	(HPS_SPIM_MISO),	// .hps_io_spim1_inst_MISO
		.hps_0_hps_io_hps_io_spim1_inst_SS0		(HPS_SPIM_SS),		// .hps_io_spim1_inst_SS0

		// HPS UART
		.hps_0_hps_io_hps_io_uart0_inst_RX	(HPS_UART_RX),	// .hps_io_uart0_inst_RX
		.hps_0_hps_io_hps_io_uart0_inst_TX	(HPS_UART_TX),	// .hps_io_uart0_inst_TX

		// HPS I2C1
		.hps_0_hps_io_hps_io_i2c0_inst_SDA	(HPS_I2C1_SDAT),	// .hps_io_i2c0_inst_SDA
		.hps_0_hps_io_hps_io_i2c0_inst_SCL	(HPS_I2C1_SCLK),	// .hps_io_i2c0_inst_SCL

		// HPS I2C2
		.hps_0_hps_io_hps_io_i2c1_inst_SDA	(HPS_I2C2_SDAT),	// .hps_io_i2c1_inst_SDA
		.hps_0_hps_io_hps_io_i2c1_inst_SCL	(HPS_I2C2_SCLK),	// .hps_io_i2c1_inst_SCL

		// HPS GPIO
		.hps_0_hps_io_hps_io_gpio_inst_GPIO09	(HPS_CONV_USB_N),	// .hps_io_gpio_inst_GPIO09
		.hps_0_hps_io_hps_io_gpio_inst_GPIO35	(HPS_ENET_INT_N),	// .hps_io_gpio_inst_GPIO35
		.hps_0_hps_io_hps_io_gpio_inst_GPIO40	(HPS_LTC_GPIO),		// .hps_io_gpio_inst_GPIO40

		//.hps_0_hps_io_hps_io_gpio_inst_GPIO41	(HPS_GPIO[1]),		// .hps_io_gpio_inst_GPIO41
		.hps_0_hps_io_hps_io_gpio_inst_GPIO48	(HPS_I2C_CONTROL),	// .hps_io_gpio_inst_GPIO48
		.hps_0_hps_io_hps_io_gpio_inst_GPIO53	(HPS_LED),			// .hps_io_gpio_inst_GPIO53
		.hps_0_hps_io_hps_io_gpio_inst_GPIO54	(HPS_KEY),			// .hps_io_gpio_inst_GPIO54
		.hps_0_hps_io_hps_io_gpio_inst_GPIO61	(HPS_GSENSOR_INT),	// .hps_io_gpio_inst_GPIO61

		// hps reset
		.hps_0_h2f_reset_reset_n	(),			// hps_0_h2f_reset.reset_n

		/* Parameters
		.samples_per_echo_export	(samples_per_echo),
		.echoes_per_scan_export		(echoes_per_scan),
		.delay_nosig_export			(delay_nosig),
		.delay_sig_export			(delay_sig),
		.pulse_180deg_export		(pulse_180deg),
		.pulse_90deg_export			(pulse_90deg),
		.init_delay_export			(init_delay),
		.rx_delay_export			(rx_delay),
		.pulse_t1_export			(pulse_t1),
		.delay_t1_export			(delay_t1),
		.adc_val_sub_export			(adc_val_sub),                         //                 adc_val_sub.export
		.dec_fact_export            (dec_fact),
		.echo_skip_export				(echo_skip),
		*/
		
		// Control Signals from/to HPS
		.ctrl_in_export ({
			DONE
			//pll_analyzer_locked,
			//fsmstat,				// NMR sequence status (1 if the fsm is running and 0 if the fsm is stopped)
			//pll_nmr_sys_locked		// PLL lock status for the NMR pulse programmer
		}),
		.ctrl_out_export({
			// pulse_on_rx,
			// tx_opa_sd_msk,
			// tx_opa_en, 					// the transmitter enable signal (active low)
			// dconv_fir_rst_reset_n,
			// dconv_fir_q_rst_reset_n,
			// nmr_controller_reset,
			// pll_analyzer_reset,		// analyzer_pll_reset
			// pll_nmr_sys_reset,		// nmr_system_pll reset for the FSM main controller clock
			// activate_adc_avln_cnt,	// NOT IMPLEMENTED AT THIS POINT, BUT THE PURPOSE WAS: adc start control signal to be activated from the avalon memory map bus / hard processor
			// nmr_clk_gate_avln_cnt,	// clock gate control signal to switch clock between main controller output and characterization clock output
			// adc_fifo_reset,			// reset adc fifo control signal
			fsm_start,				// fsm start control signal
			// phase_cycle,			// phase cycling control. 1 for 90 degrees and 0 for 270 degrees
			// dac_preamp_LDAC_n,	// NOT USED IN v6. dac_ldac -> active low
			// dac_preamp_CLR_n		// NOT USED IN v6. dac clear -> active low 
			sys_rst
		}),
		
		//.aux_cnt_out_export ({
		//	GPIO_0[9],
		//	GPIO_0[8],
		//	GPIO_0[7],
		//	GPIO_0[6],
		//	GPIO_0[5],
		//	GPIO_0[4],
		//	GPIO_0[3],
		//	GPIO_0[2]
		//}),

		/* I2C onboard
		.i2c_int_sda_in                            (i2c_int_sda_in),                            //                     i2c_int.sda_in
		.i2c_int_scl_in                            (i2c_int_scl_in),                            //                            .scl_in
		.i2c_int_sda_oe                            (i2c_int_sda_oe),                            //                            .sda_oe
		.i2c_int_scl_oe                            (i2c_int_scl_oe),                            //                            .scl_oe
		*/
		
		// I2C offboard
		// .i2c_ext_sda_in                            (i2c_ext_sda_in),                            //                     i2c_ext.sda_in
		// .i2c_ext_scl_in                            (i2c_ext_scl_in),                            //                            .scl_in
		// .i2c_ext_sda_oe                            (i2c_ext_sda_oe),                            //                            .sda_oe
		// .i2c_ext_scl_oe                            (i2c_ext_scl_oe),                            //                            .scl_oe
		
		/* Dedicated SPI for DAC preamp
		.dac_preamp_MISO                           (dac_preamp_MISO),                           //                  dac_preamp.MISO
		.dac_preamp_MOSI                           (dac_preamp_MOSI),                           //                            .MOSI
		.dac_preamp_SCLK                           (dac_preamp_SCLK),                           //                            .SCLK
		.dac_preamp_SS_n                           (dac_preamp_SS_n),
		*/
		
		/* Dedicated SPI for DAC gradient driver
		.dac_grad_MISO                           (dac_grad_MISO),                           //                  dac_preamp.MISO
		.dac_grad_MOSI                           (dac_grad_MOSI),                           //                            .MOSI
		.dac_grad_SCLK                           (dac_grad_SCLK),                           //                            .SCLK
		.dac_grad_SS_n                           (dac_grad_SS_n),
		*/
		
		/* FIFO
		.adc_fifo_in_data			({ {16{1'b0}},adc_data_out}),
		.adc_fifo_in_valid			(adc_data_valid),
		.adc_fifo_in_ready			(),
		.fifo_clk_bridge_in_clk		(adc_clkout),
		.fifo_rst_reset				(adc_fifo_reset),
		*/
		
		// NMR system clock
		.nmr_sys_pll_outclk_clk   	(pulseprog_clk),
        .nmr_sys_pll_locked_export	(pll_nmr_sys_locked),
		.nmr_sys_pll_reset_reset	(pll_nmr_sys_reset),

		/* Analyzer PLL for performance characterization
		.analyzer_pll_reset_reset	(pll_analyzer_reset), 
        .analyzer_pll_locked_export	(pll_analyzer_locked),
		.analyzer_pll_outclk0_clk	(pll_analyzer_clk0),
		.analyzer_pll_outclk1_clk	(pll_analyzer_clk1),
		.analyzer_pll_outclk2_clk	(pll_analyzer_clk2),
		.analyzer_pll_outclk3_clk	(pll_analyzer_clk3),
		*/
		
		// VGA PLL
		.pll_vga_clk65_clk			(clk_65),
        .pll_vga_locked_export		(pll_vga_locked),

		//itc
		.alt_vip_itc_0_clocked_video_vid_clk         (~clk_65),         					 	 // alt_vip_itc_0_clocked_video.vid_clk
        .alt_vip_itc_0_clocked_video_vid_data        ({vid_r,vid_g,vid_b}),        		 //                .vid_data
        .alt_vip_itc_0_clocked_video_underflow       (),                           		 //                .underflow
        .alt_vip_itc_0_clocked_video_vid_datavalid   (vid_datavalid),                   //                .vid_datavalid
        .alt_vip_itc_0_clocked_video_vid_v_sync      (vid_v_sync),      					 //                .vid_v_sync
        .alt_vip_itc_0_clocked_video_vid_h_sync      (vid_h_sync),      					 //                .vid_h_sync
        .alt_vip_itc_0_clocked_video_vid_f           (),           							 //                .vid_f
        .alt_vip_itc_0_clocked_video_vid_h           (),           							 //                .vid_h
        .alt_vip_itc_0_clocked_video_vid_v           (),

		// SDRAM
		.sdram_clk_clk		(DRAM_CLK),                  //    
	    .sdram_wire_addr	(DRAM_ADDR),                //              sdram_wire.addr
		.sdram_wire_ba		(DRAM_BA),                  //                        .ba
		.sdram_wire_cas_n	(DRAM_CAS_N),               //                        .cas_n
		.sdram_wire_cke		(DRAM_CKE),                 //                        .cke
		.sdram_wire_cs_n	(DRAM_CS_N),                //                        .cs_n
		.sdram_wire_dq		(DRAM_DQ),                  //                        .dq
		.sdram_wire_dqm		({DRAM_UDQM,DRAM_LDQM}),                 //                        .dqm
		.sdram_wire_ras_n	(DRAM_RAS_N),               //                        .ras_n
		.sdram_wire_we_n	(DRAM_WE_N),                 //                              // 

		.switches_export	(SW),                            //                    switches.export
		
		/* downconversion data-i
		.dconv_fir_in_data		(data_i),                         //                dconv_fir_in.data
		.dconv_fir_in_valid		(fsmstat__adc_clkreg),                        //                            .valid
		.dconv_fir_in_error		(),                        //                            .error
		.dconv_fir_out_data		(dconv_fir_out_data),                        //               dconv_fir_out.data
		.dconv_fir_out_valid	(dconv_fir_out_valid),                       //                            .valid
		.dconv_fir_out_error	(),                        //                            .error
		.dconv_fir_rst_reset_n  (dconv_fir_rst_reset_n),
		
		// dconv fifo in 
		.dconv_fifo_in_data		(dconv_fir_iq_comb_dec_data),                        //               dconv_fifo_in.data
		.dconv_fifo_in_valid	(dconv_fir_iq_comb_dec_valid),                 //                            .valid
		.dconv_fifo_in_ready	(),                        //                            .ready
		
		// downconversion data-q
		.dconv_fir_q_in_data	(data_q),                       //              dconv_fir_q_in.data
		.dconv_fir_q_in_valid	(fsmstat__adc_clkreg),                      //                            .valid
		.dconv_fir_q_in_error	(),                      //                            .error
		.dconv_fir_q_out_data	(dconv_fir_q_out_data),                      //             dconv_fir_q_out.data
		.dconv_fir_q_out_valid	(dconv_fir_q_out_valid),                     //                            .valid
		.dconv_fir_q_out_error	(),                     //                            .error
		.dconv_fir_q_rst_reset_n	(dconv_fir_q_rst_reset_n),
		
		// Dedicated SPI for AFE relays
		.spi_afe_relays_MISO		(spi_afe_relays_MISO),                       //              spi_afe_relays.MISO
        .spi_afe_relays_MOSI		(spi_afe_relays_MOSI),                       //                            .MOSI
        .spi_afe_relays_SCLK		(spi_afe_relays_SCLK),                       //                            .SCLK
        .spi_afe_relays_SS_n		(spi_afe_relays_SS_n),                        //                            .SS_n
		
		// Dedicated SPI for the matching network
		.spi_mtch_ntwrk_MISO		(spi_mtch_ntwrk_MISO),	// spi_mtch_ntwrk.MISO
		.spi_mtch_ntwrk_MOSI		(spi_mtch_ntwrk_MOSI),	//               .MOSI
		.spi_mtch_ntwrk_SCLK		(spi_mtch_ntwrk_SCLK),	//               .SCLK
		.spi_mtch_ntwrk_SS_n		(spi_mtch_ntwrk_SS_n), 	//               .SS_n
		*/
		
		
		
		// FIFO out
		.outfifo_0_valid                           (FIFO_VALID),                           //  
		.outfifo_0_data                            ({din[1],dummy[1:0],din[0]}),   // add 2 dummy bits to make din[0] 16 bits instead of 14 bits                         //  
		.outfifo_0_ready                           (SYNC_READY),                           //  
		
		.outfifo_1_valid                           (),                           //                 
		.outfifo_1_data                            ({din[3],dummy[3:2],din[2]}),                            //                            .data
		.outfifo_1_ready                           (SYNC_READY),
		
		.infifo_0_valid                            (OUT_VALID),                            //                    infifo_0.valid
		.infifo_0_data                             (firsum),                              //                            .data
		.dlen_export                       (DLEN) ,                               //                        dlen.export
		        .led_export                                (LEDR),                                 //                         led.export
		
		.firfifo_0_valid                           	(OUT_VALID),                           //                   firfifo_0.valid
        .firfifo_0_data                            (firout0),                            //                            .data
        
		  .firfifo_1_valid                           (OUT_VALID),                           //                   firfifo_1.valid
        .firfifo_1_data                            (firout1),                            //                            .data
        
		  .firfifo_2_valid                           (OUT_VALID),                           //                   firfifo_2.valid
        .firfifo_2_data                            (firout2),                            //                            .data
        
		  .firfifo_3_valid                           (OUT_VALID),                           //                   firfifo_3.valid
        .firfifo_3_data                            (firout3) ,
		        .fifo_global_rst_reset                     (sys_rst)                      //             fifo_global_rst.reset
	
	);
	

	dpath
	#(
		.DWIDTH(DWIDTH),
		.CWIDTH(CWIDTH),
		.UNR(UNR)
	) dpath1
	(
		// system signals
		.CLK(CLOCK_50),
		.RST(sys_rst),
		
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
		.ASYNC_START(fsm_start),
		.FIFO_VALID(FIFO_VALID),
		.SYNC_READY(SYNC_READY),
		.DONE(DONE),
		.OUT_VALID(OUT_VALID),
		
		// system signals
		.CLK(CLOCK_50),
		.RST(sys_rst),
		
		// data to be processed
		.DLEN(DLEN)
		
	);
	
	
	
	
	
	
	
	/*
	// generating a reset single pulse using FSMSTAT that is synchronized with ADC_CLKOUT
	GNRL_delayed_pulser
	#(
		.DELAY_WIDTH (4)
	)
	GNRL_delayed_pulser_FSM_GNRTD_RESET_PULSE
	(
		// signals
		.SIG_IN		(fsmstat__adc_clkreg),
		.SIG_OUT		(FSM_GNRTD_RST__adc_clk),
		
		// parameters
		.DELAY		(5'd2), // set the delay to 2 (minimum)
		
		// system
		.CLK			(adc_clkout),
		.RESET		(nmr_controller_reset) // this is unsynchronized reset so it could be unrelated to the CLK used.
	
	);
	*/
	
	
	/*
	GNRL_dconv_nofilter // POSSIBLE ISSUE: the counter is synchronized with the conv_en. If fsmstat delay to first pulse is changing, this code might need to be changed.
	# (
		.ADC_PHYS_WIDTH (ADC_PHYS_WIDTH) 
	) GNRL_dconv_nofilter1
	(

		// data interface
		.adc_data_in	(adc_data_in__adc_clkreg[ADC_PHYS_WIDTH-1:0]), // unsigned integer data in, remove overflow sign
		.data_i			(data_i), // in-phase signed integer data (wider by 1 bit)
		.data_q			(data_q), // quadrature signed integer data (wider by 1 bit)

		// parameters
		.adc_dcval_subtractor	(adc_val_sub_reg[ADC_PHYS_WIDTH:0]), // signed integer subtractor to remove dc value

		.conv_en			(fsmstat__adc_clkreg),

		// system signal
		.CLK			(adc_clkout),
		.RESET			(FSM_GNRTD_RST__adc_clk)
	);
	
	// decimator module
	GNRL_IQcomb_decimator // POSSIBLE ISSUE: the IQ output from the filter also have 2 data_valid signals, and is only being used here. So it assumes that the data is always present at the same time, which is typical.
	#(
		.DATA_WIDTH (32),
		.DEC_WIDTH (16)
	)
	GNRL_IQcomb_decimator1
	(
		// signals
		.dataI (dconv_fir_out_data),	// in-phase data
		.dataQ (dconv_fir_q_out_data),	// quadrature data
		.dataout (dconv_fir_iq_comb_dec_data),// output data
		
		// control
		.in_valid (dconv_fir_out_valid && adc_data_valid), // the valid data should be limited by adc_data_valid cause the data is continuous
		.out_valid (dconv_fir_iq_comb_dec_valid),
		
		// parameters
		.dec_fact (dec_fact_reg), // the decimation factor selector
		
		// system
		.CLK (adc_clkout),
		.RESET (FSM_GNRTD_RST__adc_clk)
		
	);
	*/
	

	/*
	NMR_Controller
	#(
		.DATABUS_WIDTH 	(DATABUS_WIDTH),
		.ADC_DATA_WIDTH	(ADC_DATA_WIDTH),	// ADC interface to FIFO width
		.ADC_PHYS_WIDTH	(ADC_PHYS_WIDTH), 	// ADC physical data width
		.ADC_LATENCY		(ADC_LATENCY)			// check the datasheet of LTC1746 for this
	)
	NMR_Controller1
	(
		// control signals
		.START		(fsm_start),
		.FSMSTAT		(fsmstat),
		
		// nmr parameters
		.T1_PULSE180		(pulse_t1_reg),
		.T1_DELAY			(delay_t1_reg),
		.PULSE90			(pulse_90deg_reg),
		.DELAY_NO_ACQ		(delay_nosig_reg),
		.PULSE180			(pulse_180deg_reg),
		.DELAY_WITH_ACQ		(delay_sig_reg),
		.ECHO_PER_SCAN		(echoes_per_scan_reg),	// echo per scan integer number
		.SAMPLES_PER_ECHO	(samples_per_echo_reg),
		.ADC_INIT_DELAY		(init_delay_reg),
		.RX_DELAY			(rx_delay_reg),
		.ECHO_SKIP			(echo_skip_reg),		
		
		// nmr rf tx-output (differential)
		.RF_OUT_P			(nmr_rfout_p),
		.RF_OUT_N			(nmr_rfout_n),
		
		// nmr control signals
		.PHASE_CYCLE		(phase_cycle),
		.PULSE_ON_RX		(pulse_on_rx),
		.EN_RX				(enable_rx),
		.EN_ADC				(enable_adc),
		.ACQ_WND_DLY		(dup_en),
		.TX_SD				(tx_opa_sd),
		.EN_QSW				(qsw_en),
		.TX_PULSE_EN		(tx_pulse_en),
		
		
		// ADC bus
		.Q_IN				(adc_data_in[ADC_PHYS_WIDTH-1:0]),
		.Q_IN_OV			(adc_data_in[ADC_PHYS_WIDTH]),
		
		// data output
		.ADC_OUT_DATA		(adc_data_out),
		.ADC_DATA_VALID		(adc_data_valid),
		
		// system signals
		.PULSEPROG_CLK		(pulseprog_clk),
		.ADC_CLK			(adc_clk),
		.ADC_CLKOUT			(adc_clkout),
		.RESET				(nmr_controller_reset)
	);
	*/



	
	// PIN ASSIGNMENT
	
	/* DAC preamp
	assign GPIO_1[2] = dac_preamp_MOSI;
	assign GPIO_1[5] = dac_preamp_SCLK;
	assign GPIO_1[3] = dac_preamp_SS_n;
	// assign dac_preamp_MISO = GPIO_1[]; // not being used in v6
	
	// DAC gradient driver
	assign dac_grad_MISO = GPIO_1[19];
	assign GPIO_1[17] = dac_grad_SCLK;
	assign GPIO_1[14] = dac_grad_SS_n;
	// assign GPIO_1[12] = dac_grad_LDAC_n; 	// DAC_LDAC is hardwired in PCB v6.0
	assign GPIO_1[16] = dac_grad_MOSI;
	// assign GPIO_1[15] = dac_grad_CLR_n; 	// DAC_CLR is hardwired in PCB v6.0


	assign adc_clkout = GPIO_1[21];		// uncomment this if the shifted clock from the ADC is used instead of clk_25M below
	assign GPIO_1[18] = adc_clk;		// ADC high speed clock ENC
	// assign GPIO_1[18] = 1'b0; 		// ADC2_OE is hardwired in PCB v6.0
	
	altiobuf i2c_int_io (
		.datain		( 2'b00 ),
		.oe			( {i2c_int_sda_oe , i2c_int_scl_oe} ),
		.dataio		( {GPIO_1[15],GPIO_1[12]} ),
		.dataout	( {i2c_int_sda_in , i2c_int_scl_in} )
	);

	assign GPIO_1[13] = spi_mtch_ntwrk_SCLK;
	assign GPIO_1[10] = spi_mtch_ntwrk_MOSI;
	assign GPIO_1[11] = spi_mtch_ntwrk_SS_n;
	
	assign GPIO_1[4] = spi_afe_relays_SCLK;
	assign GPIO_1[7] = spi_afe_relays_MOSI;
	assign GPIO_1[6] = spi_afe_relays_SS_n;
	
	assign GPIO_1[8] = dup_en;
	assign GPIO_1[9] = qsw_en;
	*/










	/*
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
	*/
	
	/*
	always @*
	begin
		if (tx_pulse_en)
			begin
				pll_analyzer_clk0_gated = pll_analyzer_clk0;
				pll_analyzer_clk1_gated = pll_analyzer_clk1;
				pll_analyzer_clk2_gated = pll_analyzer_clk2;
				pll_analyzer_clk3_gated = pll_analyzer_clk3;
			end
		else
			begin
				pll_analyzer_clk0_gated = 1'b0;
				pll_analyzer_clk1_gated = 1'b0;
				pll_analyzer_clk2_gated = 1'b0;
				pll_analyzer_clk3_gated = 1'b0;
			end
	end
	
	
	
	assign GPIO_1[1] = nmr_clk_gate_avln_cnt ? nmr_rfout_p : pll_analyzer_clk0_gated;
	assign GPIO_1[0] = nmr_clk_gate_avln_cnt ? nmr_rfout_n : pll_analyzer_clk2_gated;

	assign GPIO_0[29] = enable_rx;
	// assign GPIO_0[27] = dup_en;
	assign GPIO_0[25] = enable_adc;
	assign GPIO_0[0]	= tx_opa_en & ( !(tx_opa_sd_msk && tx_opa_sd) ); // The transmitter is enabled when the pin is state 'high'. tx_opa_en and tx_opa_sd (transmit shutdown) is active high signal. PUt tx_opa_sd_msk to 0 to disable tx_opa_sd effect on the output.

	*/




















	// USEFUL SIMPLE STATUS SIGNALS
	// assign LEDR[0] = 1'b1;
	// assign LEDR[1] = 1'b0;
	// assign LEDR[2] = RESET;
	// assign LEDR[3] = pll_vga_locked;
	// assign LEDR[4] = pll_nmr_sys_locked;
	// assign LEDR[5] = pll_analyzer_locked;
	// assign LEDR[6] = phase_cycle;
	// assign LEDR[7] = fsmstat;
	// assign LEDR[8] = nmr_controller_reset;
	
		
endmodule

 