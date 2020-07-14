`include "pu.vh"
module lidx(input [15:0] i, input [7:0] iv, input [1:0] op, output logic [15:0] o);
	parameter THU =2'b00, IMM =2'b01, LIL =2'b10 ,LIH =2'b11;
	always @*
		casex(op)
		// synopsys full_case parallel_case
		THU:
			o = i;
		IMM:
			o = {{8{iv[7]}},iv[7:0]};
		LIL:
			o = {i[15:7+1],iv};
		LIH:
			o = {iv,i[7:0]};
		endcase
endmodule
