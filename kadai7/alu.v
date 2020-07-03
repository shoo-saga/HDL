module alu(input [15:0] a, b, input [2:0] op, output logic [15:0] r);
	parameter SET0 = 3'b000, SET1 = 3'b001, ADD = 3'b010;
	parameter SUB = 3'b011, TRU = 3'b100;
	always_comb
		case(op)
		// synopsys full_case parallel_case
		SET0: r = 16'd0;
		SET1: r = 16'd1;
		ADD: r = a + b;
		SUB: r = a - b;
		TRU: r = a;
		endcase
endmodule
