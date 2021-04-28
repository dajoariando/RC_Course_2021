`timescale 1ps / 1ps

module fir
# (
	parameter DWIDTH = 14,	// data width
	parameter CWIDTH = 11	// coefficient width
)
(
	// control signal
	input	EN,
	
	// data input/output
	// input	[DWIDTH-1:0]		din,
	input	signed [14:0]		din [37],
	output	signed [31:0]		dout,
	
	// filter coefficient
	input	signed [10:0]	coeff [37], // there are 37 coefficients
	
	// system signal
	input CLK,
	input RST
);
	/* implementation 1
	reg [DWIDTH-1:0] dbuf [37];

	genvar i;
	generate
		for (i=0; i<37; i=i+1)
		begin : dbuf_init
			initial
			begin
				dbuf[i]   <= {DWIDTH{1'b0}};
			end
		end
	endgenerate
	
	generate
		for (i=0; i<37; i=i+1)
		begin : dbuf_shift
			if (i == 0)
			begin
				always @(posedge CLK, posedge RST)
				begin
					if (RST)
					begin
						dbuf[i]   <= {DWIDTH{1'b0}};
					end
					
					else
					begin
						dbuf[i]		<= din;
					end
				end
			end
			else
			begin
				always @(posedge CLK, posedge RST)
				begin
					if (RST)
					begin
						dbuf[i]   <= {DWIDTH{1'b0}};
					end
					
					else
					begin
						dbuf[i]		<= dbuf[i-1];
					end
				end
			end
		end
	endgenerate
	
	assign dout =	dbuf[0 ]*coeff[0 ] +
					dbuf[1 ]*coeff[1 ] +
					dbuf[2 ]*coeff[2 ] +
					dbuf[3 ]*coeff[3 ] +
					dbuf[4 ]*coeff[4 ] +
					dbuf[5 ]*coeff[5 ] +
					dbuf[6 ]*coeff[6 ] +
					dbuf[7 ]*coeff[7 ] +
					dbuf[8 ]*coeff[8 ] +
					dbuf[9 ]*coeff[9 ] +
					dbuf[10]*coeff[10] +
					dbuf[11]*coeff[11] +
					dbuf[12]*coeff[12] +
					dbuf[13]*coeff[13] +
					dbuf[14]*coeff[14] +
					dbuf[15]*coeff[15] +
					dbuf[16]*coeff[16] +
					dbuf[17]*coeff[17] +
					dbuf[18]*coeff[18] +
					dbuf[19]*coeff[19] +
					dbuf[20]*coeff[20] +
					dbuf[21]*coeff[21] +
					dbuf[22]*coeff[22] +
					dbuf[23]*coeff[23] +
					dbuf[24]*coeff[24] +
					dbuf[25]*coeff[25] +
					dbuf[26]*coeff[26] +
					dbuf[27]*coeff[27] +
					dbuf[28]*coeff[28] +
					dbuf[29]*coeff[29] +
					dbuf[30]*coeff[30] +
					dbuf[31]*coeff[31] +
					dbuf[32]*coeff[32] +
					dbuf[33]*coeff[33] +
					dbuf[34]*coeff[34] +
					dbuf[35]*coeff[35] +
					dbuf[36]*coeff[36];
	*/
	
	/* implementation 2
	assign dout =	din[0 ]*coeff[0 ] +
					din[1 ]*coeff[1 ] +
					din[2 ]*coeff[2 ] +
					din[3 ]*coeff[3 ] +
					din[4 ]*coeff[4 ] +
					din[5 ]*coeff[5 ] +
					din[6 ]*coeff[6 ] +
					din[7 ]*coeff[7 ] +
					din[8 ]*coeff[8 ] +
					din[9 ]*coeff[9 ] +
					din[10]*coeff[10] +
					din[11]*coeff[11] +
					din[12]*coeff[12] +
					din[13]*coeff[13] +
					din[14]*coeff[14] +
					din[15]*coeff[15] +
					din[16]*coeff[16] +
					din[17]*coeff[17] +
					din[18]*coeff[18] +
					din[19]*coeff[19] +
					din[20]*coeff[20] +
					din[21]*coeff[21] +
					din[22]*coeff[22] +
					din[23]*coeff[23] +
					din[24]*coeff[24] +
					din[25]*coeff[25] +
					din[26]*coeff[26] +
					din[27]*coeff[27] +
					din[28]*coeff[28] +
					din[29]*coeff[29] +
					din[30]*coeff[30] +
					din[31]*coeff[31] +
					din[32]*coeff[32] +
					din[33]*coeff[33] +
					din[34]*coeff[34] +
					din[35]*coeff[35] +
					din[36]*coeff[36];
	*/
		
	/* reduced: implementation 3
	assign dout =
					(din[0 ]+din[36])*coeff[0 ] +
					(din[1 ]+din[35])*coeff[1 ] +
					(din[2 ]+din[34])*coeff[2 ] +
					(din[3 ]+din[33])*coeff[3 ] +
					(din[4 ]+din[32])*coeff[4 ] +
					(din[5 ]+din[31])*coeff[5 ] +
					(din[6 ]+din[30])*coeff[6 ] +
					(din[7 ]+din[29])*coeff[7 ] +
					(din[8 ]+din[28])*coeff[8 ] +
					(din[9 ]+din[27])*coeff[9 ] +
					(din[10]+din[26])*coeff[10] +
					(din[11]+din[25])*coeff[11] +
					(din[12]+din[24])*coeff[12] +
					(din[13]+din[23])*coeff[13] +
					(din[14]+din[22])*coeff[14] +
					(din[15]+din[21])*coeff[15] +
					(din[16]+din[20])*coeff[16] +
					(din[17]+din[19])*coeff[17] +
					din[18]*coeff[18];
	*/
	
	
	// implementation 4
	genvar i;
	generate
		for (i=0; i<19; i=i+1)
		begin : fir_add
			wire signed [14:0] atemp;
			if (i==18)
			begin
				add	add_inst (
					.dataa ( din[i] ),
					.datab ( din[15'b0] ),
					.result ( atemp )
				);
			end
			else
			begin
				add	add_inst (
					.dataa ( din[i] ),
					.datab ( din[36-i] ),
					.result ( atemp )
				);
			end
		end
	endgenerate
	
	generate
		for (i=0; i<19; i=i+1)
		begin : fir_mult
			wire signed [25:0] dtemp;
			mult	mult_inst (
				.dataa ( fir_add[i].atemp ),
				.datab ( coeff[i] ),
				.result ( dtemp )
				);
		end
	endgenerate
	
	/* final addition : old code
	assign dout =
		fir_mult[0].dtemp + 
		fir_mult[1].dtemp + 
		fir_mult[2].dtemp + 
		fir_mult[3].dtemp + 
		fir_mult[4].dtemp + 
		fir_mult[5].dtemp + 
		fir_mult[6].dtemp + 
		fir_mult[7].dtemp +
		fir_mult[8].dtemp + 
		fir_mult[9].dtemp + 
		fir_mult[10].dtemp + 
		fir_mult[11].dtemp + 
		fir_mult[12].dtemp + 
		fir_mult[13].dtemp + 
		fir_mult[14].dtemp + 
		fir_mult[15].dtemp + 
		fir_mult[16].dtemp + 
		fir_mult[17].dtemp +
		fir_mult[18].dtemp ;
	*/
	
	add_prl	add_prl_inst (
		.data0x 	(fir_mult[0].dtemp ),
		.data10x 	(fir_mult[1].dtemp ),
		.data11x 	(fir_mult[2].dtemp ),
		.data12x 	(fir_mult[3].dtemp ),
		.data13x 	(fir_mult[4].dtemp ),
		.data14x 	(fir_mult[5].dtemp ),
		.data15x 	(fir_mult[6].dtemp ),
		.data16x 	(fir_mult[7].dtemp ),
		.data17x 	(fir_mult[8].dtemp ),
		.data18x 	(fir_mult[9].dtemp ),
		.data1x 	(fir_mult[10].dtemp),
		.data2x 	(fir_mult[11].dtemp),
		.data3x 	(fir_mult[12].dtemp),
		.data4x 	(fir_mult[13].dtemp),
		.data5x 	(fir_mult[14].dtemp),
		.data6x 	(fir_mult[15].dtemp),
		.data7x 	(fir_mult[16].dtemp),
		.data8x 	(fir_mult[17].dtemp),
		.data9x 	(fir_mult[18].dtemp),
		.result ( dout )
	);
	
endmodule