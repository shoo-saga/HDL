`include "pu.vh"
module lidx(input [`WIDTH:0] i, input [`HALFWIDTH:0] iv, input [`LIDXS:0] op, output logic [`WIDTH:0] o);
	parameter THU =2'b00, IMM =2'b01, LIL =2'b10 ,LIH =2'b11;
	always @*
		casex(op)
		// synopsys full_case parallel_case
		THU:
			o = i;
		IMM:
			o = {{8{iv[`HALFWIDTH]}},iv[`HALFWIDTH:0]};
		LIL:
			o = {i[`WIDTH:`HALFWIDTH+1],iv};
		LIH:
			o = {iv,i[`HALFWIDTH:0]};
		endcase
endmodule
