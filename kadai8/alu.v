
module alu(input [15:0] a, b, input [2:0] op, output logic [15:0] r,
		input dstb, output logic ze, ca, sg, input clk, rst);
	parameter ADD = 3'b000, SUB = 3'b001, THB = 3'b010, ASR = 3'b011;
	parameter RSR = 3'b100, RSL = 3'b101, NAD = 3'b110, XOR = 3'b111;
	logic [15+1:0] rr;
	always @* begin
		case(op)
		// synopsys full_case parallel_case
		ADD: rr = a+b;
		SUB: rr = a-b;
		THB: rr = b;
		ASR: rr = a>>>b;
		RSR: rr = a>>b;
		RSL: rr = a<<b;
		NAD: rr = ~(a&b);
		XOR: rr = a^b;
		endcase
	end
	assign r = rr[15:0];
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			ze <= 1'b0;
			ca <= 1'b0;
			sg <= 1'b0;
		end else begin
			if(r == 0) ze <= 1'b1;
			else ze <= 1'b0;
			if(r[15] == 1'b1) sg <= 1'b1;
			else sg <= 1'b0;
			if(rr[15+1] == 1'b1) ca <= 1'b1;
			else ca <= 1'b0;
		end
	end
endmodule
