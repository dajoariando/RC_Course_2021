// system_mm_interconnect_0_monitor_system_console_master_mm_interconnect_2.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 17.1 590

`timescale 1 ps / 1 ps
module system_mm_interconnect_0_monitor_system_console_master_mm_interconnect_2 (
		input  wire        clk_clk_clk,                                //                              clk_clk.clk
		input  wire        gatherer_reset_reset_bridge_in_reset_reset, // gatherer_reset_reset_bridge_in_reset.reset
		input  wire [5:0]  trace_endpoint_control_address,             //               trace_endpoint_control.address
		output wire        trace_endpoint_control_waitrequest,         //                                     .waitrequest
		input  wire        trace_endpoint_control_read,                //                                     .read
		output wire [31:0] trace_endpoint_control_readdata,            //                                     .readdata
		input  wire        trace_endpoint_control_write,               //                                     .write
		input  wire [31:0] trace_endpoint_control_writedata,           //                                     .writedata
		output wire [5:0]  gatherer_control_address,                   //                     gatherer_control.address
		output wire        gatherer_control_write,                     //                                     .write
		output wire        gatherer_control_read,                      //                                     .read
		input  wire [31:0] gatherer_control_readdata,                  //                                     .readdata
		output wire [31:0] gatherer_control_writedata,                 //                                     .writedata
		input  wire        gatherer_control_readdatavalid,             //                                     .readdatavalid
		input  wire        gatherer_control_waitrequest                //                                     .waitrequest
	);

	wire         trace_endpoint_control_translator_avalon_universal_master_0_waitrequest;   // gatherer_control_translator:uav_waitrequest -> trace_endpoint_control_translator:uav_waitrequest
	wire  [31:0] trace_endpoint_control_translator_avalon_universal_master_0_readdata;      // gatherer_control_translator:uav_readdata -> trace_endpoint_control_translator:uav_readdata
	wire         trace_endpoint_control_translator_avalon_universal_master_0_debugaccess;   // trace_endpoint_control_translator:uav_debugaccess -> gatherer_control_translator:uav_debugaccess
	wire   [7:0] trace_endpoint_control_translator_avalon_universal_master_0_address;       // trace_endpoint_control_translator:uav_address -> gatherer_control_translator:uav_address
	wire         trace_endpoint_control_translator_avalon_universal_master_0_read;          // trace_endpoint_control_translator:uav_read -> gatherer_control_translator:uav_read
	wire   [3:0] trace_endpoint_control_translator_avalon_universal_master_0_byteenable;    // trace_endpoint_control_translator:uav_byteenable -> gatherer_control_translator:uav_byteenable
	wire         trace_endpoint_control_translator_avalon_universal_master_0_readdatavalid; // gatherer_control_translator:uav_readdatavalid -> trace_endpoint_control_translator:uav_readdatavalid
	wire         trace_endpoint_control_translator_avalon_universal_master_0_lock;          // trace_endpoint_control_translator:uav_lock -> gatherer_control_translator:uav_lock
	wire         trace_endpoint_control_translator_avalon_universal_master_0_write;         // trace_endpoint_control_translator:uav_write -> gatherer_control_translator:uav_write
	wire  [31:0] trace_endpoint_control_translator_avalon_universal_master_0_writedata;     // trace_endpoint_control_translator:uav_writedata -> gatherer_control_translator:uav_writedata
	wire   [2:0] trace_endpoint_control_translator_avalon_universal_master_0_burstcount;    // trace_endpoint_control_translator:uav_burstcount -> gatherer_control_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (6),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (8),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (0),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (0),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) trace_endpoint_control_translator (
		.clk                    (clk_clk_clk),                                                               //                       clk.clk
		.reset                  (gatherer_reset_reset_bridge_in_reset_reset),                                //                     reset.reset
		.uav_address            (trace_endpoint_control_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (trace_endpoint_control_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (trace_endpoint_control_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (trace_endpoint_control_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (trace_endpoint_control_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (trace_endpoint_control_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (trace_endpoint_control_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (trace_endpoint_control_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (trace_endpoint_control_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (trace_endpoint_control_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (trace_endpoint_control_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (trace_endpoint_control_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (trace_endpoint_control_waitrequest),                                        //                          .waitrequest
		.av_read                (trace_endpoint_control_read),                                               //                          .read
		.av_readdata            (trace_endpoint_control_readdata),                                           //                          .readdata
		.av_write               (trace_endpoint_control_write),                                              //                          .write
		.av_writedata           (trace_endpoint_control_writedata),                                          //                          .writedata
		.av_burstcount          (1'b1),                                                                      //               (terminated)
		.av_byteenable          (4'b1111),                                                                   //               (terminated)
		.av_beginbursttransfer  (1'b0),                                                                      //               (terminated)
		.av_begintransfer       (1'b0),                                                                      //               (terminated)
		.av_chipselect          (1'b0),                                                                      //               (terminated)
		.av_readdatavalid       (),                                                                          //               (terminated)
		.av_lock                (1'b0),                                                                      //               (terminated)
		.av_debugaccess         (1'b0),                                                                      //               (terminated)
		.uav_clken              (),                                                                          //               (terminated)
		.av_clken               (1'b1),                                                                      //               (terminated)
		.uav_response           (2'b00),                                                                     //               (terminated)
		.av_response            (),                                                                          //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                                      //               (terminated)
		.av_writeresponsevalid  ()                                                                           //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (6),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (8),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (1),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (1),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) gatherer_control_translator (
		.clk                    (clk_clk_clk),                                                               //                      clk.clk
		.reset                  (gatherer_reset_reset_bridge_in_reset_reset),                                //                    reset.reset
		.uav_address            (trace_endpoint_control_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (trace_endpoint_control_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (trace_endpoint_control_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (trace_endpoint_control_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (trace_endpoint_control_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (trace_endpoint_control_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (trace_endpoint_control_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (trace_endpoint_control_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (trace_endpoint_control_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (trace_endpoint_control_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (trace_endpoint_control_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (gatherer_control_address),                                                  //      avalon_anti_slave_0.address
		.av_write               (gatherer_control_write),                                                    //                         .write
		.av_read                (gatherer_control_read),                                                     //                         .read
		.av_readdata            (gatherer_control_readdata),                                                 //                         .readdata
		.av_writedata           (gatherer_control_writedata),                                                //                         .writedata
		.av_readdatavalid       (gatherer_control_readdatavalid),                                            //                         .readdatavalid
		.av_waitrequest         (gatherer_control_waitrequest),                                              //                         .waitrequest
		.av_begintransfer       (),                                                                          //              (terminated)
		.av_beginbursttransfer  (),                                                                          //              (terminated)
		.av_burstcount          (),                                                                          //              (terminated)
		.av_byteenable          (),                                                                          //              (terminated)
		.av_writebyteenable     (),                                                                          //              (terminated)
		.av_lock                (),                                                                          //              (terminated)
		.av_chipselect          (),                                                                          //              (terminated)
		.av_clken               (),                                                                          //              (terminated)
		.uav_clken              (1'b0),                                                                      //              (terminated)
		.av_debugaccess         (),                                                                          //              (terminated)
		.av_outputenable        (),                                                                          //              (terminated)
		.uav_response           (),                                                                          //              (terminated)
		.av_response            (2'b00),                                                                     //              (terminated)
		.uav_writeresponsevalid (),                                                                          //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                                       //              (terminated)
	);

endmodule
